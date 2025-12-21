import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:minvest_forex_app/features/admin/services/admin_service.dart';
import 'package:minvest_forex_app/features/admin/screens/admin_news_screen.dart';

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
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: _screens[_selectedIndex],
          ),
        ],
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

  // Helper to format dates
  String _formatDate(dynamic date) {
    if (date == null) return '---';
    if (date is Timestamp) return DateFormat('dd/MM/yy').format(date.toDate());
    return '---';
  }

  // Helper to get map value ignoring case (e.g. finds 'Gold' when asking for 'gold')
  dynamic _getMapValueCaseInsensitive(Map<String, dynamic> map, String key) {
    if (map.isEmpty) return null;
    final lowerKey = key.toLowerCase();
    for (final k in map.keys) {
      if (k.toLowerCase() == lowerKey) return map[k];
    }
    return null;
  }

  // Robust helper to get package date (handles both nested Map and dot-notation keys)
  dynamic _getPackageDate(Map<String, dynamic> userData, String fieldPrefix, String packageKey) {
    // 1. Try nested map (Standard)
    final nested = userData[fieldPrefix];
    if (nested is Map<String, dynamic>) {
      final val = _getMapValueCaseInsensitive(nested, packageKey);
      if (val != null) return val;
    }

    // 2. Try flat dot-notation key (Legacy/Bug fallback)
    // Looks for keys like "subscriptionsExpiry.gold"
    final targetKey = '$fieldPrefix.$packageKey'.toLowerCase();
    for (final k in userData.keys) {
      if (k.toLowerCase() == targetKey) {
        return userData[k];
      }
    }
    
    return null;
  }

  // --- UPDATE LOGIC ---

  // 1. Update Token Balance
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
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'tokenBalance': newBalance,
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã cập nhật token!')));
    }
  }

  // 2. Update Subscription Package (Gold, Forex, Crypto)
  Future<void> _updatePackageDates(String userId, String packageKey, Timestamp? currentStart, Timestamp? currentExpiry) async {
    // Pick Start Date
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
      // Pick Expiry Date
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
      // Logic xóa gói nếu bấm Cancel ở bước chọn ngày bắt đầu
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

  // 3. Update Role (Tier)
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
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lý User & Gói Dịch Vụ (${_selectedUserIds.length} chọn)'),
        actions: [
          if (_selectedUserIds.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear_all),
              onPressed: () => setState(() => _selectedUserIds.clear()),
              tooltip: 'Bỏ chọn tất cả',
            ),
        ],
      ),
      body: SizedBox.expand( // Đảm bảo chiếm full chiều rộng
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').orderBy('createdAt', descending: true).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('Không có người dùng nào.'));
            }
            final userDocs = snapshot.data!.docs;

            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width - 72), // Trừ đi Rail width
                  child: DataTable(
                    showCheckboxColumn: true,
                    columnSpacing: 20,
                    dataRowMinHeight: 70,
                    dataRowMaxHeight: 90,
                    headingRowColor: WidgetStateProperty.all(Colors.grey.shade200),
                    columns: [
                      const DataColumn(label: Text('User Info', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))),
                      const DataColumn(label: Text('Role (Tier)', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))),
                      const DataColumn(label: Text('Tokens', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))),
                      DataColumn(label: Text('Gold (Start/Exp)', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber.shade900))),
                      DataColumn(label: Text('Forex (Start/Exp)', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue.shade900))),
                      DataColumn(label: Text('Crypto (Start/Exp)', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange.shade900))),
                      const DataColumn(label: Text('Registered', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))),
                    ],
                    rows: userDocs.map((doc) {
                      final userData = doc.data() as Map<String, dynamic>;
                      final userId = doc.id;
                      final isSelected = _selectedUserIds.contains(userId);

                      // Extract Data
                      final tier = (userData['subscriptionTier'] as String?)?.toLowerCase() ?? 'free';
                      final tokens = userData['tokenBalance'] ?? 0;
                      final activeSubs = List<String>.from(userData['activeSubscriptions'] ?? []);

                      return DataRow(
                        selected: isSelected,
                        onSelectChanged: (selected) {
                          setState(() {
                            if (selected == true) {
                              _selectedUserIds.add(userId);
                            } else {
                              _selectedUserIds.remove(userId);
                            }
                          });
                        },
                        cells: [
                          // 1. User Info (No ID)
                          DataCell(
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(userData['displayName'] ?? 'No Name', style: const TextStyle(fontWeight: FontWeight.bold)),
                                  Text(userData['email'] ?? 'No Email', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                                ],
                              ),
                            ),
                          ),
                          
                          // 2. Role (Free / Elite only)
                          DataCell(
                            InkWell(
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
                                    Text(tier.toUpperCase(), style: TextStyle(color: _getTierColor(tier), fontWeight: FontWeight.bold)),
                                    const SizedBox(width: 4),
                                    Icon(Icons.edit, size: 14, color: _getTierColor(tier)),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // 3. Tokens
                          DataCell(
                            InkWell(
                              onTap: () => _updateTokenBalance(userId, tokens is int ? tokens : 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('$tokens', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  const SizedBox(width: 4),
                                  const Icon(Icons.edit, size: 14, color: Colors.grey),
                                ],
                              ),
                            ),
                          ),

                          // 4-6. Packages (Start & Expiry)
                          DataCell(_buildPackageCell(userId, 'gold', 
                            _getPackageDate(userData, 'subscriptionsStart', 'gold'), 
                            _getPackageDate(userData, 'subscriptionsExpiry', 'gold'), 
                            activeSubs)),
                          DataCell(_buildPackageCell(userId, 'forex', 
                            _getPackageDate(userData, 'subscriptionsStart', 'forex'), 
                            _getPackageDate(userData, 'subscriptionsExpiry', 'forex'), 
                            activeSubs)),
                          DataCell(_buildPackageCell(userId, 'crypto', 
                            _getPackageDate(userData, 'subscriptionsStart', 'crypto'), 
                            _getPackageDate(userData, 'subscriptionsExpiry', 'crypto'), 
                            activeSubs)),

                          // 7. Created At
                          DataCell(Text(_formatDate(userData['createdAt']))),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPackageCell(String userId, String packageKey, dynamic start, dynamic expiry, List<String> activeSubs) {
    // Case-insensitive check
    final bool isActive = activeSubs.any((s) => s.toLowerCase() == packageKey.toLowerCase());
    
    // Formatting
    String startStr = _formatDate(start);
    final String expiryStr = _formatDate(expiry);

    // If active but missing start date (legacy data), show placeholder
    if (isActive && start == null) {
      startStr = '???';
    }

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
                Text(startStr, style: TextStyle(
                  fontSize: 11,
                  color: isActive ? Colors.black : Colors.grey,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                )),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('E: ', style: TextStyle(fontSize: 10, color: Colors.grey)),
                Text(expiryStr, style: TextStyle(
                  fontSize: 11,
                  color: isActive ? Colors.red.shade700 : Colors.grey,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                )),
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
    // Đảm bảo chỉ chọn free hoặc elite. Nếu đang là demo/vip thì cũng cho phép đổi sang 1 trong 2 cái này
    if (!['free', 'elite'].contains(_selectedTier)) {
      _selectedTier = 'free';
    }
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
              decoration: const InputDecoration(
                labelText: 'Chọn vai trò mới',
                border: OutlineInputBorder(),
              ),
              items: ['free', 'elite']
                  .map((tier) => DropdownMenuItem(
                        value: tier,
                        child: Text(tier.toUpperCase()),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedTier = value);
                }
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _reasonController,
              decoration: const InputDecoration(
                hintText: 'Nhập lý do thay đổi (bắt buộc)...',
                border: OutlineInputBorder(),
              ),
              autofocus: true,
              maxLines: null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Hủy'),
        ),
        FilledButton(
          onPressed: () {
            final reason = _reasonController.text.trim();
            if (reason.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Lý do không được để trống.')),
              );
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