import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:minvest_forex_app/features/admin/services/admin_service.dart';
import 'package:minvest_forex_app/features/admin/screens/admin_news_screen.dart';
import 'package:minvest_forex_app/features/admin/screens/affiliate_management_view.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const UserManagementView(),
    const AdminNewsScreen(),
    const AffiliateManagementView(),
    const AppConfigView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.people),
                selectedIcon: Icon(Icons.people_alt),
                label: Text('Users'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.newspaper),
                selectedIcon: Icon(Icons.article),
                label: Text('News'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.share),
                selectedIcon: Icon(Icons.share_arrival_time),
                label: Text('Affiliate'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                selectedIcon: Icon(Icons.settings_applications),
                label: Text('Settings'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: _screens,
            ),
          ),
        ],
      ),
    );
  }
}

class AppConfigView extends StatefulWidget {
  const AppConfigView({super.key});

  @override
  State<AppConfigView> createState() => _AppConfigViewState();
}

class _AppConfigViewState extends State<AppConfigView> {
  final _winRateAdjustmentController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadConfig();
  }

  Future<void> _loadConfig() async {
    if (!mounted) return;
    setState(() => _isLoading = true);
    try {
      final doc = await FirebaseFirestore.instance.collection('settings').doc('app_config').get();
      if (doc.exists) {
        final data = doc.data()!;
        _winRateAdjustmentController.text = (data['winRateAdjustment'] ?? 8).toString();
      } else {
        _winRateAdjustmentController.text = '8';
      }
    } catch (e) {
      debugPrint('Error loading config: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Không thể tải cấu hình: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _saveConfig() async {
    final adjustment = double.tryParse(_winRateAdjustmentController.text);
    if (adjustment == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Vui lòng nhập số hợp lệ.')));
      return;
    }

    setState(() => _isLoading = true);
    try {
      await FirebaseFirestore.instance.collection('settings').doc('app_config').set({
        'winRateAdjustment': adjustment,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã cập nhật cấu hình!')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Lỗi khi lưu: $e')));
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cấu hình ứng dụng')),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Cấu hình Tỷ lệ Thắng (Win Rate)',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Giá trị phần trăm cộng thêm vào tỷ lệ thắng thực tế khi hiển thị cho người dùng.',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _winRateAdjustmentController,
                    decoration: const InputDecoration(
                      labelText: 'Phần trăm cộng thêm (%)',
                      border: OutlineInputBorder(),
                      suffixText: '%',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                FilledButton.icon(
                  onPressed: _saveConfig,
                  icon: const Icon(Icons.save),
                  label: const Text('Lưu cấu hình'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}

class UserManagementView extends StatefulWidget {
  const UserManagementView({super.key});

  @override
  State<UserManagementView> createState() => _UserManagementViewState();
}

class _UserManagementViewState extends State<UserManagementView> {
  final AdminService _adminService = AdminService();
  final Set<String> _selectedUserIds = {};
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _horizontalController = ScrollController();
  final ScrollController _verticalController = ScrollController();
  String _searchQuery = '';
  late Stream<QuerySnapshot> _usersStream;

  @override
  void initState() {
    super.initState();
    _updateStream();
  }

  void _updateStream() {
    if (_searchQuery.isEmpty) {
      _usersStream = FirebaseFirestore.instance
          .collection('users')
          .orderBy('createdAt', descending: true)
          .limit(200)
          .snapshots();
    } else {
      _usersStream = FirebaseFirestore.instance
          .collection('users')
          .where('email', isGreaterThanOrEqualTo: _searchQuery)
          .where('email', isLessThanOrEqualTo: _searchQuery + '\uf8ff')
          .limit(100)
          .snapshots();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _horizontalController.dispose();
    _verticalController.dispose();
    super.dispose();
  }

  // Helper to format dates
  String _formatDate(dynamic date) {
    if (date == null) return '---';
    if (date is Timestamp) return DateFormat('dd/MM/yy').format(date.toDate());
    return '---';
  }

  // Helper to get map value ignoring case
  dynamic _getMapValueCaseInsensitive(Map<String, dynamic> map, String key) {
    if (map.isEmpty) return null;
    final lowerKey = key.toLowerCase();
    for (final k in map.keys) {
      if (k.toLowerCase() == lowerKey) return map[k];
    }
    return null;
  }

  // Robust helper to get package date
  dynamic _getPackageDate(Map<String, dynamic> userData, String fieldPrefix, String packageKey) {
    final nested = userData[fieldPrefix];
    if (nested is Map<String, dynamic>) {
      final val = _getMapValueCaseInsensitive(nested, packageKey);
      if (val != null) return val;
    }
    final targetKey = '$fieldPrefix.$packageKey'.toLowerCase();
    for (final k in userData.keys) {
      if (k.toLowerCase() == targetKey) return userData[k];
    }
    return null;
  }

  // --- UPDATE LOGIC ---
  Future<void> _updateTokenBalance(String userId, int currentBalance) async {
    final controller = TextEditingController(text: currentBalance.toString());
    final newBalance = await showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cập nhật Token'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(labelText: 'Số lượng Token'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
          FilledButton(
            onPressed: () => Navigator.pop(context, int.tryParse(controller.text)),
            child: const Text('Lưu'),
          ),
        ],
      ),
    );

    if (newBalance != null && newBalance != currentBalance) {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({'tokenBalance': newBalance});
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã cập nhật token!')));
    }
  }

  Future<void> _updatePackageDates(String userId, String packageKey, Timestamp? currentStart, Timestamp? currentExpiry) async {
    final DateTime? startDate = await showDatePicker(
      context: context,
      initialDate: currentStart?.toDate() ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 2)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
      helpText: 'Chọn ngày BẮT ĐẦU gói ${packageKey.toUpperCase()}',
      cancelText: 'Hủy Gói',
    );

    if (!mounted) return;

    if (startDate != null) {
      final DateTime? expiryDate = await showDatePicker(
        context: context,
        initialDate: currentExpiry?.toDate() ?? startDate.add(const Duration(days: 30)),
        firstDate: startDate,
        lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
        helpText: 'Chọn ngày HẾT HẠN gói ${packageKey.toUpperCase()}',
      );

      if (!mounted) return;

      if (expiryDate != null) {
        await FirebaseFirestore.instance.collection('users').doc(userId).update({
          'subscriptionsStart.$packageKey': Timestamp.fromDate(startDate),
          'subscriptionsExpiry.$packageKey': Timestamp.fromDate(expiryDate),
          'activeSubscriptions': FieldValue.arrayUnion([packageKey]),
        });
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Đã cập nhật ngày cho gói ${packageKey.toUpperCase()}!')));
      }
    } else {
      if (currentStart != null || currentExpiry != null) {
        final confirmDelete = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Xóa gói ${packageKey.toUpperCase()}?'),
            content: const Text('Người dùng sẽ mất quyền truy cập vào gói này.'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Hủy')),
              TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Xóa', style: TextStyle(color: Colors.red))),
            ],
          ),
        );

        if (confirmDelete == true) {
          await FirebaseFirestore.instance.collection('users').doc(userId).update({
            'subscriptionsStart.$packageKey': FieldValue.delete(),
            'subscriptionsExpiry.$packageKey': FieldValue.delete(),
            'activeSubscriptions': FieldValue.arrayRemove([packageKey]),
          });
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Đã xóa gói ${packageKey.toUpperCase()}!')));
        }
      }
    }
  }

  void _handleSingleUserTierUpdate(String userId, String currentTier) {
    showDialog(
      context: context,
      builder: (context) => _UpdateUserTierDialog(
        initialTier: currentTier,
        onConfirm: (tier, reason) async {
          final message = await _adminService.updateUserSubscriptionTier(
            userIds: [userId],
            tier: tier,
            reason: reason,
          );
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('User Management (${_selectedUserIds.length})'),
            const SizedBox(width: 24),
            Expanded(
              child: SizedBox(
                height: 40,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Tìm theo Email...',
                    prefixIcon: const Icon(Icons.search, size: 20),
                    suffixIcon: _searchQuery.isNotEmpty 
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 20),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _searchQuery = '';
                              _updateStream();
                            });
                          },
                        )
                      : null,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value.trim().toLowerCase();
                      _updateStream();
                    });
                  },
                ),
              ),
            ),
            const SizedBox(width: 24),
          ],
        ),
        actions: [
          if (_selectedUserIds.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear_all),
              onPressed: () => setState(() => _selectedUserIds.clear()),
              tooltip: 'Bỏ chọn tất cả',
            ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Không có người dùng nào.'));
          }
          final userDocs = snapshot.data!.docs;

          return Scrollbar(
            controller: _horizontalController,
            thumbVisibility: true,
            child: SingleChildScrollView(
              controller: _horizontalController,
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 1400,
                child: Column(
                  children: [
                    // Table Header
                    Container(
                      color: Colors.grey.shade200,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      child: const Row(
                        children: [
                          SizedBox(width: 48, child: Text('Select')),
                          Expanded(flex: 3, child: Text('User Info', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))),
                          Expanded(flex: 2, child: Text('Role (Tier)', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))),
                          Expanded(flex: 1, child: Text('Tokens', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))),
                          Expanded(flex: 2, child: Text('Gold', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))),
                          Expanded(flex: 2, child: Text('Forex', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))),
                          Expanded(flex: 2, child: Text('Crypto', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))),
                          Expanded(flex: 2, child: Text('Registered', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))),
                        ],
                      ),
                    ),
                    // Table Content
                    Expanded(
                      child: Scrollbar(
                        controller: _verticalController,
                        thumbVisibility: true,
                        child: ListView.builder(
                          controller: _verticalController,
                          itemCount: userDocs.length,
                          itemExtent: 80,
                          itemBuilder: (context, index) {
                            final doc = userDocs[index];
                            final userData = doc.data() as Map<String, dynamic>;
                            final userId = doc.id;
                            final isSelected = _selectedUserIds.contains(userId);

                            final tier = (userData['subscriptionTier'] as String?)?.toLowerCase() ?? 'free';
                            final tokens = userData['tokenBalance'] ?? 0;
                            final activeSubs = List<String>.from(userData['activeSubscriptions'] ?? []);

                            return Container(
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                                color: isSelected ? Colors.blue.withValues(alpha: 0.05) : null,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 48,
                                    child: Checkbox(
                                      value: isSelected,
                                      onChanged: (selected) {
                                        setState(() {
                                          if (selected == true) {
                                            _selectedUserIds.add(userId);
                                          } else {
                                            _selectedUserIds.remove(userId);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(userData['displayName'] ?? 'No Name', 
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                            maxLines: 1, overflow: TextOverflow.ellipsis),
                                          Text(userData['email'] ?? 'No Email', 
                                            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                                            maxLines: 1, overflow: TextOverflow.ellipsis),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: InkWell(
                                        onTap: () => _handleSingleUserTierUpdate(userId, tier),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                          decoration: BoxDecoration(
                                            color: _getTierColor(tier).withValues(alpha: 0.2),
                                            border: Border.all(color: _getTierColor(tier)),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(tier.toUpperCase(), style: TextStyle(color: _getTierColor(tier), fontWeight: FontWeight.bold, fontSize: 12)),
                                              const SizedBox(width: 4),
                                              Icon(Icons.edit, size: 12, color: _getTierColor(tier)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: InkWell(
                                        onTap: () => _updateTokenBalance(userId, tokens is int ? tokens : 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text('$tokens', style: const TextStyle(fontWeight: FontWeight.bold)),
                                            const SizedBox(width: 4),
                                            const Icon(Icons.edit, size: 12, color: Colors.grey),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: _buildPackageCell(userId, 'gold', 
                                      _getPackageDate(userData, 'subscriptionsStart', 'gold'), 
                                      _getPackageDate(userData, 'subscriptionsExpiry', 'gold'), 
                                      activeSubs),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: _buildPackageCell(userId, 'forex', 
                                      _getPackageDate(userData, 'subscriptionsStart', 'forex'), 
                                      _getPackageDate(userData, 'subscriptionsExpiry', 'forex'), 
                                      activeSubs),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: _buildPackageCell(userId, 'crypto', 
                                      _getPackageDate(userData, 'subscriptionsStart', 'crypto'), 
                                      _getPackageDate(userData, 'subscriptionsExpiry', 'crypto'), 
                                      activeSubs),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Center(child: Text(_formatDate(userData['createdAt']), style: const TextStyle(fontSize: 12))),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPackageCell(String userId, String packageKey, dynamic start, dynamic expiry, List<String> activeSubs) {
    final bool isActive = activeSubs.any((s) => s.toLowerCase() == packageKey.toLowerCase());
    String startStr = _formatDate(start);
    final String expiryStr = _formatDate(expiry);
    if (isActive && start == null) startStr = '???';

    return InkWell(
      onTap: () => _updatePackageDates(userId, packageKey, start as Timestamp?, expiry as Timestamp?),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: isActive
            ? BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
              )
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('S: ', style: TextStyle(fontSize: 10, color: Colors.grey)),
                Text(startStr, style: TextStyle(fontSize: 11, color: isActive ? Colors.black : Colors.grey, fontWeight: isActive ? FontWeight.bold : FontWeight.normal)),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('E: ', style: TextStyle(fontSize: 10, color: Colors.grey)),
                Text(expiryStr, style: TextStyle(fontSize: 11, color: isActive ? Colors.red.shade700 : Colors.grey, fontWeight: isActive ? FontWeight.bold : FontWeight.normal)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getTierColor(String tier) {
    switch (tier) {
      case 'elite': return Colors.purple;
      case 'vip': return Colors.amber.shade800;
      case 'demo': return Colors.blue;
      default: return Colors.grey;
    }
  }
}

class _UpdateUserTierDialog extends StatefulWidget {
  final String? initialTier;
  final Function(String tier, String reason) onConfirm;

  const _UpdateUserTierDialog({this.initialTier, required this.onConfirm});

  @override
  State<_UpdateUserTierDialog> createState() => __UpdateUserTierDialogState();
}

class __UpdateUserTierDialogState extends State<_UpdateUserTierDialog> {
  final _reasonController = TextEditingController();
  late String _selectedTier;

  @override
  void initState() {
    super.initState();
    _selectedTier = widget.initialTier ?? 'free';
    if (!['free', 'elite'].contains(_selectedTier)) _selectedTier = 'free';
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Cập nhật vai trò người dùng'),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedTier,
              decoration: const InputDecoration(labelText: 'Chọn vai trò mới', border: OutlineInputBorder()),
              items: ['free', 'elite'].map((tier) => DropdownMenuItem(value: tier, child: Text(tier.toUpperCase()))).toList(),
              onChanged: (value) { if (value != null) setState(() => _selectedTier = value); },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _reasonController,
              decoration: const InputDecoration(hintText: 'Nhập lý do thay đổi (bắt buộc)...', border: OutlineInputBorder()),
              autofocus: true,
              maxLines: null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Hủy')),
        FilledButton(
          onPressed: () {
            final reason = _reasonController.text.trim();
            if (reason.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lý do không được để trống.')));
              return;
            }
            Navigator.of(context).pop();
            widget.onConfirm(_selectedTier, reason);
          },
          child: const Text('Xác nhận'),
        ),
      ],
    );
  }
}