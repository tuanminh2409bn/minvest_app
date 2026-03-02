// lib/features/admin/screens/admin_panel_screen_mobile.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:minvest_forex_app/features/admin/services/admin_service.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  final AdminService _adminService = AdminService();
  final TextEditingController _searchController = TextEditingController();
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
          .limit(100)
          .snapshots();
    } else {
      _usersStream = FirebaseFirestore.instance
          .collection('users')
          .where('email', isGreaterThanOrEqualTo: _searchQuery)
          .where('email', isLessThanOrEqualTo: _searchQuery + '\uf8ff')
          .limit(50)
          .snapshots();
    }
  }

  // Helper to format dates
  String _formatDate(dynamic date) {
    if (date == null) return 'N/A';
    if (date is Timestamp) return DateFormat('dd/MM/yy').format(date.toDate());
    return 'N/A';
  }

  // Robust helper to get package date
  dynamic _getPackageDate(Map<String, dynamic> userData, String fieldPrefix, String packageKey) {
    final nested = userData[fieldPrefix];
    if (nested is Map<String, dynamic>) {
      final lowerKey = packageKey.toLowerCase();
      for (final k in nested.keys) {
        if (k.toLowerCase() == lowerKey) return nested[k];
      }
    }
    return null;
  }

  // --- UPDATE ACTIONS ---
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
      helpText: 'Ngày BẮT ĐẦU gói ${packageKey.toUpperCase()}',
    );

    if (!mounted || startDate == null) return;

    final DateTime? expiryDate = await showDatePicker(
      context: context,
      initialDate: currentExpiry?.toDate() ?? startDate.add(const Duration(days: 30)),
      firstDate: startDate,
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
      helpText: 'Ngày HẾT HẠN gói ${packageKey.toUpperCase()}',
    );

    if (!mounted || expiryDate == null) return;

    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'subscriptionsStart.$packageKey': Timestamp.fromDate(startDate),
      'subscriptionsExpiry.$packageKey': Timestamp.fromDate(expiryDate),
      'activeSubscriptions': FieldValue.arrayUnion([packageKey]),
    });
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Đã cập nhật gói ${packageKey.toUpperCase()}!')));
    }
  }

  void _handleTierUpdate(String userId, String currentTier) {
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
        title: const Text('Quản lý Người dùng'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Tìm theo Email...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty 
                  ? IconButton(icon: const Icon(Icons.clear), onPressed: () {
                      _searchController.clear();
                      setState(() { _searchQuery = ''; _updateStream(); });
                    })
                  : null,
                filled: true,
                fillColor: Colors.white.withOpacity(0.05),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              onChanged: (value) {
                setState(() { _searchQuery = value.trim().toLowerCase(); _updateStream(); });
              },
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Không tìm thấy người dùng.'));
          }
          final users = snapshot.data!.docs;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final doc = users[index];
              final userData = doc.data() as Map<String, dynamic>;
              final userId = doc.id;
              final tier = (userData['subscriptionTier'] as String?)?.toLowerCase() ?? 'free';
              final tokens = userData['tokenBalance'] ?? 0;
              final activeSubs = List<String>.from(userData['activeSubscriptions'] ?? []);

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: const Color(0xFF161616),
                child: ExpansionTile(
                  leading: CircleAvatar(
                    backgroundColor: _getTierColor(tier).withOpacity(0.2),
                    child: Text(tier[0].toUpperCase(), style: TextStyle(color: _getTierColor(tier))),
                  ),
                  title: Text(userData['displayName'] ?? 'No Name', style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(userData['email'] ?? 'No Email', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          _buildActionRow('Tier (Role)', tier.toUpperCase(), _getTierColor(tier), () => _handleTierUpdate(userId, tier)),
                          const Divider(height: 24),
                          _buildActionRow('Token Balance', tokens.toString(), Colors.blue, () => _updateTokenBalance(userId, tokens is int ? tokens : 0)),
                          const Divider(height: 24),
                          _buildPackageRow(userId, 'GOLD', 
                            _getPackageDate(userData, 'subscriptionsStart', 'gold'), 
                            _getPackageDate(userData, 'subscriptionsExpiry', 'gold'), 
                            activeSubs.contains('gold')),
                          const Divider(height: 16),
                          _buildPackageRow(userId, 'FOREX', 
                            _getPackageDate(userData, 'subscriptionsStart', 'forex'), 
                            _getPackageDate(userData, 'subscriptionsExpiry', 'forex'), 
                            activeSubs.contains('forex')),
                          const Divider(height: 16),
                          _buildPackageRow(userId, 'CRYPTO', 
                            _getPackageDate(userData, 'subscriptionsStart', 'crypto'), 
                            _getPackageDate(userData, 'subscriptionsExpiry', 'crypto'), 
                            activeSubs.contains('crypto')),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text('Registered: ${_formatDate(userData['createdAt'])}', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildActionRow(String label, String value, Color color, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: color.withOpacity(0.5)),
            ),
            child: Row(
              children: [
                Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
                const SizedBox(width: 8),
                const Icon(Icons.edit, size: 14, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPackageRow(String userId, String name, dynamic start, dynamic expiry, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: TextStyle(fontWeight: FontWeight.bold, color: isActive ? Colors.green : Colors.grey)),
            const SizedBox(height: 4),
            Text('Start: ${_formatDate(start)}', style: const TextStyle(fontSize: 11, color: Colors.grey)),
            Text('Expiry: ${_formatDate(expiry)}', style: TextStyle(fontSize: 11, color: isActive ? Colors.redAccent : Colors.grey)),
          ],
        ),
        IconButton(
          onPressed: () => _updatePackageDates(userId, name.toLowerCase(), start as Timestamp?, expiry as Timestamp?),
          icon: const Icon(Icons.calendar_month, size: 20, color: Colors.blue),
        ),
      ],
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
    if (!['free', 'demo', 'vip', 'elite'].contains(_selectedTier)) _selectedTier = 'free';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Cập nhật Role'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<String>(
            value: _selectedTier,
            decoration: const InputDecoration(labelText: 'Chọn Role', border: OutlineInputBorder()),
            items: ['free', 'demo', 'vip', 'elite'].map((t) => DropdownMenuItem(value: t, child: Text(t.toUpperCase()))).toList(),
            onChanged: (v) => setState(() => _selectedTier = v!),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _reasonController,
            decoration: const InputDecoration(hintText: 'Lý do thay đổi...', border: OutlineInputBorder()),
            maxLines: 2,
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
        FilledButton(onPressed: () {
          if (_reasonController.text.isEmpty) return;
          Navigator.pop(context);
          widget.onConfirm(_selectedTier, _reasonController.text);
        }, child: const Text('Xác nhận')),
      ],
    );
  }
}
