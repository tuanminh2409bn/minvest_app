import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AffiliateDetailScreen extends StatefulWidget {
  final String affiliateId;
  final Map<String, dynamic> affiliateData;

  const AffiliateDetailScreen({
    super.key,
    required this.affiliateId,
    required this.affiliateData,
  });

  @override
  State<AffiliateDetailScreen> createState() => _AffiliateDetailScreenState();
}

class _AffiliateDetailScreenState extends State<AffiliateDetailScreen> with SingleTickerProviderStateMixin {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late TabController _tabController;

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
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Chi tiết Đối tác: ${widget.affiliateData['code']}'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Tài chính & Giao dịch'),
            Tab(text: 'Khách hàng (Referrals)'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildStatsTab(),
          _buildReferralsTab(),
        ],
      ),
    );
  }

  Widget _buildStatsTab() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('commissions')
          .where('affiliateId', isEqualTo: widget.affiliateId)
          .snapshots(),
      builder: (context, snapshot) {
        double totalRevenue = 0;
        double totalCommission = 0;
        double paidCommission = 0;
        double pendingCommission = 0;

        if (snapshot.hasData) {
          for (var doc in snapshot.data!.docs) {
            final data = doc.data() as Map<String, dynamic>;
            final amount = (data['invoiceAmount'] ?? 0).toDouble();
            final comm = (data['commissionAmount'] ?? 0).toDouble();
            final status = data['status'] ?? 'pending';

            totalRevenue += amount;
            totalCommission += comm;
            if (status == 'paid') {
              paidCommission += comm;
            } else if (status == 'pending' || status == 'approved') {
              pendingCommission += comm;
            }
          }
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoCard(),
              const SizedBox(height: 24),
              const Text('Thống kê tài chính', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 16),
              _buildFinanceGrid(totalRevenue, totalCommission, pendingCommission, paidCommission),
              const SizedBox(height: 32),
              const Text('Lịch sử giao dịch hoa hồng', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 16),
              _buildTransactionList(snapshot.data?.docs ?? []),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          _buildInfoRow('Tên đối tác', widget.affiliateData['name'] ?? '---'),
          _buildInfoRow('Email', widget.affiliateData['email'] ?? '---'),
          _buildInfoRow('Mã giới thiệu', widget.affiliateData['code'] ?? '---', isCode: true),
          _buildInfoRow('Tỷ lệ hoa hồng', '${widget.affiliateData['commissionRate'] ?? 40}%'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isCode = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: isCode ? Colors.blue : Colors.white)),
        ],
      ),
    );
  }

  Widget _buildFinanceGrid(double revenue, double commission, double pending, double paid) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: [
        _FinanceStatCard(title: 'Doanh thu khách nạp', value: '\$${revenue.toStringAsFixed(2)}', color: Colors.purple, icon: Icons.monetization_on_outlined),
        _FinanceStatCard(title: 'Tổng hoa hồng', value: '\$${commission.toStringAsFixed(2)}', color: Colors.blue, icon: Icons.account_balance_wallet_outlined),
        _FinanceStatCard(title: 'Chờ thanh toán', value: '\$${pending.toStringAsFixed(2)}', color: Colors.orange, icon: Icons.timer_outlined),
        _FinanceStatCard(title: 'Đã chi trả', value: '\$${paid.toStringAsFixed(2)}', color: Colors.green, icon: Icons.check_circle_outline),
      ],
    );
  }

  Widget _buildTransactionList(List<QueryDocumentSnapshot> docs) {
    if (docs.isEmpty) return const Center(child: Padding(padding: EdgeInsets.all(20), child: Text('Chưa có giao dịch hoa hồng nào.', style: TextStyle(color: Colors.grey))));

    return Container(
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(12)),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: docs.length,
        separatorBuilder: (context, index) => const Divider(color: Colors.white10, height: 1),
        itemBuilder: (context, index) {
          final data = docs[index].data() as Map<String, dynamic>;
          final date = (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now();
          final comm = (data['commissionAmount'] ?? 0).toDouble();
          final rev = (data['invoiceAmount'] ?? 0).toDouble();
          final status = data['status'] ?? 'pending';

          return ListTile(
            title: Text(data['userEmail'] ?? '---', style: const TextStyle(fontSize: 14, color: Colors.white)),
            subtitle: Text(DateFormat('dd/MM/yyyy HH:mm').format(date), style: const TextStyle(fontSize: 12, color: Colors.grey)),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('+\$${comm.toStringAsFixed(2)}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                Text('từ \$${rev.toStringAsFixed(2)}', style: const TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildReferralsTab() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('users')
          .where('referred_by_affiliate_id', isEqualTo: widget.affiliateId)
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) return const Center(child: Text('Chưa có khách hàng nào.', style: TextStyle(color: Colors.grey)));

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final userDoc = snapshot.data!.docs[index];
            final userData = userDoc.data() as Map<String, dynamic>;
            final date = (userData['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now();
            final tier = (userData['subscriptionTier'] ?? 'free').toString().toUpperCase();

            // Tính toán doanh thu từ user này
            return FutureBuilder<QuerySnapshot>(
              future: _firestore.collection('commissions')
                  .where('affiliateId', isEqualTo: widget.affiliateId)
                  .where('userId', isEqualTo: userDoc.id)
                  .get(),
              builder: (context, commSnapshot) {
                double userRevenue = 0;
                if (commSnapshot.hasData) {
                  for (var doc in commSnapshot.data!.docs) {
                    userRevenue += (doc.data() as Map<String, dynamic>)['invoiceAmount'] ?? 0;
                  }
                }

                return Card(
                  color: Colors.white.withOpacity(0.05),
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    title: Text(userData['email'] ?? '---', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    subtitle: Text('Tham gia: ${DateFormat('dd/MM/yyyy').format(date)}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: tier == 'ELITE' ? Colors.green.withOpacity(0.2) : Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(tier, style: TextStyle(color: tier == 'ELITE' ? Colors.green : Colors.blue, fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 4),
                        Text('Đã nạp: \$${userRevenue.toStringAsFixed(2)}', style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 13)),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class _FinanceStatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  const _FinanceStatCard({required this.title, required this.value, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 11, color: Colors.grey), textAlign: TextAlign.center),
          const SizedBox(height: 4),
          FittedBox(child: Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white))),
        ],
      ),
    );
  }
}
