import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AffiliateManagementView extends StatefulWidget {
  const AffiliateManagementView({super.key});

  @override
  State<AffiliateManagementView> createState() => _AffiliateManagementViewState();
}

class _AffiliateManagementViewState extends State<AffiliateManagementView> with SingleTickerProviderStateMixin {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late TabController _tabController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Affiliate'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Đối tác', icon: Icon(Icons.people_outline)),
            Tab(text: 'Hoa hồng', icon: Icon(Icons.account_balance_wallet_outlined)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _showCreateAffiliateDialog,
            icon: const Icon(Icons.person_add_alt_1),
            tooltip: 'Tạo Affiliate Mới',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAffiliatesTab(),
          _buildCommissionsTab(),
        ],
      ),
    );
  }

  // =================================================================
  // === TAB 1: DANH SÁCH ĐỐI TÁC ===
  // =================================================================
  Widget _buildAffiliatesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryCards(),
          const SizedBox(height: 24),
          const Text('Danh sách Affiliate', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 500, // Fixed height or use another approach for scrollable list
            child: _buildAffiliateList()
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('affiliates').snapshots(),
      builder: (context, snapshot) {
        int totalAffiliates = snapshot.data?.docs.length ?? 0;
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _StatCard(title: 'Tổng Affiliate', value: '$totalAffiliates', icon: Icons.people, color: Colors.blue),
            _StatCard(
              title: 'Hoa hồng Chờ', 
              value: '---', 
              icon: Icons.pending_actions, 
              color: Colors.orange
            ),
            _StatCard(title: 'Đã chi trả', value: '---', icon: Icons.payments, color: Colors.green),
          ],
        );
      },
    );
  }

  Widget _buildAffiliateList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('affiliates').orderBy('createdAt', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) return const Center(child: Text('Chưa có affiliate nào.'));

        return Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white10)),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Mã Code')),
                DataColumn(label: Text('Tên Affiliate')),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Số Ref')),
                DataColumn(label: Text('Hoa hồng (%)')),
                DataColumn(label: Text('Trạng thái')),
                DataColumn(label: Text('Thao tác')),
              ],
              rows: snapshot.data!.docs.map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                return DataRow(cells: [
                  DataCell(Text(data['code'] ?? '---', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue))),
                  DataCell(Text(data['name'] ?? 'No Name')),
                  DataCell(Text(data['email'] ?? '---')),
                  DataCell(Text('${data['referralCount'] ?? 0}')),
                  DataCell(Text('${data['commissionRate'] ?? 40}%')),
                  DataCell(_buildStatusBadge(data['isActive'] ?? true)),
                  DataCell(Row(
                    children: [
                      IconButton(icon: const Icon(Icons.edit, size: 20), onPressed: () => _showEditAffiliateDialog(doc)),
                    ],
                  )),
                ]);
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  // =================================================================
  // === TAB 2: QUẢN LÝ HOA HỒNG ===
  // =================================================================
  Widget _buildCommissionsTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: [
              const Text('Lịch sử Hoa hồng', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              FilledButton.icon(
                onPressed: () {}, // Chức năng xuất CSV
                icon: const Icon(Icons.download, size: 18),
                label: const Text('Xuất CSV', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(child: _buildCommissionsList()),
        ],
      ),
    );
  }

  Widget _buildCommissionsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('commissions').orderBy('createdAt', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) return const Center(child: Text('Chưa có dữ liệu hoa hồng.'));

        return Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white10)),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Ngày')),
                DataColumn(label: Text('Đối tác')),
                DataColumn(label: Text('Người dùng nạp')),
                DataColumn(label: Text('Số tiền nạp')),
                DataColumn(label: Text('Hoa hồng')),
                DataColumn(label: Text('Trạng thái')),
                DataColumn(label: Text('Thao tác')),
              ],
              rows: snapshot.data!.docs.map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                final status = data['status'] ?? 'pending';
                final date = (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now();
                
                return DataRow(cells: [
                  DataCell(Text(DateFormat('dd/MM HH:mm').format(date))),
                  DataCell(Text(data['affiliateCode'] ?? '---')),
                  DataCell(Text(data['userEmail'] ?? '---')),
                  DataCell(Text('\$${data['invoiceAmount'] ?? 0}')),
                  DataCell(Text('\$${data['commissionAmount'] ?? 0}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold))),
                  DataCell(_buildCommissionStatusBadge(status)),
                  DataCell(_buildCommissionActions(doc, status)),
                ]);
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCommissionStatusBadge(String status) {
    Color color = Colors.orange;
    if (status == 'paid') color = Colors.green;
    if (status == 'approved') color = Colors.blue;
    if (status == 'void') color = Colors.red;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(4), border: Border.all(color: color)),
      child: Text(status.toUpperCase(), style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildCommissionActions(DocumentSnapshot doc, String status) {
    if (status == 'paid') return const Icon(Icons.check_circle, color: Colors.green, size: 20);
    
    return Row(
      children: [
        if (status == 'pending')
          IconButton(
            icon: const Icon(Icons.thumb_up_alt_outlined, size: 18, color: Colors.blue),
            tooltip: 'Phê duyệt',
            onPressed: () => _updateCommissionStatus(doc, 'approved'),
          ),
        if (status == 'approved')
          IconButton(
            icon: const Icon(Icons.send_outlined, size: 18, color: Colors.green),
            tooltip: 'Đánh dấu Đã trả USDT',
            onPressed: () => _updateCommissionStatus(doc, 'paid'),
          ),
        IconButton(
          icon: const Icon(Icons.cancel_outlined, size: 18, color: Colors.red),
          tooltip: 'Hủy bỏ',
          onPressed: () => _updateCommissionStatus(doc, 'void'),
        ),
      ],
    );
  }

  Future<void> _updateCommissionStatus(DocumentSnapshot doc, String newStatus) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận'),
        content: Text('Bạn muốn chuyển trạng thái hoa hồng này thành ${newStatus.toUpperCase()}?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Hủy')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Xác nhận')),
        ],
      ),
    );

    if (confirm == true) {
      await doc.reference.update({
        'status': newStatus,
        if (newStatus == 'paid') 'paidAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  // =================================================================
  // === LOGIC TẠO AFFILIATE (GIỮ NGUYÊN TỪ TRƯỚC) ===
  // =================================================================
  void _showCreateAffiliateDialog() {
    final emailController = TextEditingController();
    final codeController = TextEditingController();
    final nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tạo Affiliate Mới'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email người dùng')),
            const SizedBox(height: 16),
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Tên đối tác')),
            const SizedBox(height: 16),
            TextField(controller: codeController, decoration: const InputDecoration(labelText: 'Mã Ref mong muốn')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
          FilledButton(
            onPressed: () => _createAffiliate(emailController.text, codeController.text, nameController.text),
            child: const Text('Tạo ngay'),
          ),
        ],
      ),
    );
  }

  Future<void> _createAffiliate(String email, String code, String name) async {
    if (email.isEmpty || code.isEmpty || name.isEmpty) return;
    setState(() => _isLoading = true);
    Navigator.pop(context);
    try {
      final userQuery = await _firestore.collection('users').where('email', isEqualTo: email).limit(1).get();
      if (userQuery.docs.isEmpty) throw Exception('Không tìm thấy người dùng.');
      final uid = userQuery.docs[0].id;
      final codeQuery = await _firestore.collection('affiliates').where('code', isEqualTo: code.toUpperCase()).get();
      if (codeQuery.docs.isNotEmpty) throw Exception('Mã giới thiệu đã tồn tại.');

      await _firestore.collection('affiliates').add({
        'uid': uid, 'email': email, 'name': name, 'code': code.toUpperCase(),
        'commissionRate': 40, 'isActive': true, 'referralCount': 0, 'totalEarnings': 0,
        'createdAt': FieldValue.serverTimestamp(),
      });
      await _firestore.collection('users').doc(uid).update({'role': 'affiliate'});
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã tạo Affiliate thành công!')));
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Lỗi: ${e.toString()}')));
    } finally { if (mounted) setState(() => _isLoading = false); }
  }

  void _showEditAffiliateDialog(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final rateController = TextEditingController(text: (data['commissionRate'] ?? 40).toString());
    final codeController = TextEditingController(text: data['code'] ?? '');
    final nameController = TextEditingController(text: data['name'] ?? '');
    bool isActive = data['isActive'] ?? true;
    
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text('Chỉnh sửa Affiliate: ${data['code']}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min, 
              children: [
                TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Tên đối tác')),
                const SizedBox(height: 16),
                TextField(
                  controller: codeController, 
                  decoration: const InputDecoration(labelText: 'Mã giới thiệu (Sửa thủ công)'),
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                const SizedBox(height: 16),
                TextField(controller: rateController, decoration: const InputDecoration(labelText: 'Tỷ lệ hoa hồng (%)')),
                const SizedBox(height: 8),
                SwitchListTile(title: const Text('Hoạt động'), value: isActive, onChanged: (val) => setDialogState(() => isActive = val)),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
            FilledButton(
              onPressed: () async {
                final newCode = codeController.text.trim().toUpperCase();
                final oldCode = data['code'];
                
                if (newCode.isEmpty) return;

                // Nếu đổi mã mới, kiểm tra trùng lặp
                if (newCode != oldCode) {
                  final codeQuery = await _firestore.collection('affiliates').where('code', isEqualTo: newCode).get();
                  if (codeQuery.docs.isNotEmpty) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Mã giới thiệu này đã được sử dụng bởi người khác!'), backgroundColor: Colors.red));
                    }
                    return;
                  }
                }

                await doc.reference.update({
                  'name': nameController.text.trim(),
                  'code': newCode,
                  'commissionRate': int.tryParse(rateController.text) ?? 40, 
                  'isActive': isActive
                });
                if (context.mounted) Navigator.pop(context);
              }, 
              child: const Text('Cập nhật'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: isActive ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(4), border: Border.all(color: isActive ? Colors.green : Colors.red)),
      child: Text(isActive ? 'ACTIVE' : 'DISABLED', style: TextStyle(color: isActive ? Colors.green : Colors.red, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  const _StatCard({required this.title, required this.value, required this.icon, required this.color});
  @override
  Widget build(BuildContext context) {
    // Calculate width to fit 2 cards per row on mobile
    final width = (MediaQuery.of(context).size.width - 44) / 2;
    
    return Container(
      width: width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1), 
        borderRadius: BorderRadius.circular(12), 
        border: Border.all(color: color.withOpacity(0.3))
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: color.withOpacity(0.2), 
            child: Icon(icon, color: color, size: 20)
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, 
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title, 
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  value, 
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ]
            ),
          ),
        ],
      ),
    );
  }
}
