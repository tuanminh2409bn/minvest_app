import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:minvest_forex_app/core/providers/user_provider.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import 'package:minvest_forex_app/web/theme/text_styles.dart';
import 'package:minvest_forex_app/web/landing/widgets/navbar.dart';
import 'package:minvest_forex_app/web/landing/sections/footer_section.dart';

class AffiliateDashboardPage extends StatefulWidget {
  const AffiliateDashboardPage({super.key});

  @override
  State<AffiliateDashboardPage> createState() => _AffiliateDashboardPageState();
}

class _AffiliateDashboardPageState extends State<AffiliateDashboardPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? _currentUser = FirebaseAuth.instance.currentUser;
  
  Map<String, dynamic>? _affiliateData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAffiliateData();
  }

  Future<void> _loadAffiliateData() async {
    if (_currentUser == null) return;
    
    try {
      final query = await _firestore
          .collection('affiliates')
          .where('uid', isEqualTo: _currentUser.uid)
          .limit(1)
          .get();
          
      if (query.docs.isNotEmpty) {
        setState(() {
          _affiliateData = query.docs.first.data();
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userRole = userProvider.userRole ?? 'user';
    final bool hasAffiliateRole = userRole == 'admin' || userRole == 'affiliate';
    
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 900;
    final double horizontalPadding = width < 600 ? 16 : (width < 1200 ? 40 : 100);

    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('affiliates').where('uid', isEqualTo: _currentUser?.uid).limit(1).snapshots(),
      builder: (context, affSnapshot) {
        if (!hasAffiliateRole) {
          return const Scaffold(body: Center(child: Text('Bạn chưa được cấp quyền Affiliate. Vui lòng liên hệ Admin.')));
        }

        if (!affSnapshot.hasData || affSnapshot.data!.docs.isEmpty) {
          final bool isAdmin = userRole == 'admin';
          return Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(isAdmin ? Icons.admin_panel_settings : Icons.info_outline, 
                             color: isAdmin ? Colors.blue : Colors.orange, size: 64),
                        const SizedBox(height: 24),
                        Text(
                          isAdmin ? 'Xin chào Quản trị viên!' : 'Tài khoản của bạn đã có quyền Affiliate!',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: isMobile ? 20 : 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          isAdmin 
                            ? 'Để bắt đầu sử dụng các tính năng của đối tác, hãy tự cấp cho mình một Mã giới thiệu (Ref Code) trong phần Quản lý Affiliate của Admin.'
                            : 'Tuy nhiên, Admin chưa cấp Mã giới thiệu cho bạn.\nVui lòng liên hệ Admin để hoàn tất thiết lập.',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pushNamed(isAdmin ? '/profile' : '/'),
                          child: Text(isAdmin ? 'Đi đến Quản lý Admin' : 'Quay lại Trang chủ'),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 24),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
          );
        }

        final affDoc = affSnapshot.data!.docs.first;
        final affData = affDoc.data() as Map<String, dynamic>;
        final affDocId = affDoc.id;
        final String refCode = affData['code'] ?? '';
        final String refLink = 'https://signalgpt.ai/?ref=$refCode';

        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeader(refLink, refCode, isMobile),
                          const SizedBox(height: 40),
                          _buildStatsRow(affDocId, affData, isMobile),
                          const SizedBox(height: 40),
                          _buildDetailsSection(affDocId, isMobile),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 20,
                left: 20,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 24),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  Widget _buildHeader(String link, String code, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 20 : 32),
      decoration: BoxDecoration(
        color: const Color(0xFF161616),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: isMobile ? 1 : 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Link giới thiệu của bạn', style: TextStyle(color: Colors.white, fontSize: isMobile ? 20 : 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Text('Sử dụng link này để giới thiệu người dùng và nhận hoa hồng 40% trọn đời.', style: TextStyle(color: Colors.white70, fontSize: 16)),
                    const SizedBox(height: 24),
                    if (isMobile) ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blue.withOpacity(0.5)),
                        ),
                        child: SelectableText(link, style: const TextStyle(color: Colors.blue, fontSize: 14)),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: link));
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã copy link giới thiệu!')));
                          },
                          icon: const Icon(Icons.copy, size: 18),
                          label: const Text('Copy Link'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                          ),
                        ),
                      ),
                    ] else
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.blue.withOpacity(0.5)),
                              ),
                              child: Text(link, style: const TextStyle(color: Colors.blue, fontSize: 16)),
                            ),
                          ),
                          const SizedBox(width: 16),
                          ElevatedButton.icon(
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: link));
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã copy link giới thiệu!')));
                            },
                            icon: const Icon(Icons.copy, size: 18),
                            label: const Text('Copy Link'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              if (!isMobile) ...[
                const SizedBox(width: 40),
                Container(
                  width: 280,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.withOpacity(0.1), Colors.purple.withOpacity(0.1)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Column(
                    children: [
                      const Text('Mã giới thiệu', style: TextStyle(color: Colors.white70, fontSize: 14)),
                      const SizedBox(height: 8),
                      Text(code, style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 2)),
                      const SizedBox(height: 16),
                      OutlinedButton.icon(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: code));
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã copy mã giới thiệu!')));
                        },
                        icon: const Icon(Icons.copy, size: 16),
                        label: const Text('Copy Mã'),
                        style: OutlinedButton.styleFrom(foregroundColor: Colors.white70, side: const BorderSide(color: Colors.white24)),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
          if (isMobile) ...[
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.withOpacity(0.1), Colors.purple.withOpacity(0.1)],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Mã giới thiệu', style: TextStyle(color: Colors.white70, fontSize: 12)),
                      Text(code, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 1)),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: code));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã copy mã giới thiệu!')));
                    },
                    icon: const Icon(Icons.copy, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatsRow(String affDocId, Map<String, dynamic> affData, bool isMobile) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('commissions')
          .where('affiliateId', isEqualTo: affDocId)
          .where('status', isEqualTo: 'pending')
          .snapshots(),
      builder: (context, commSnapshot) {
        double pendingAmount = 0;
        if (commSnapshot.hasData) {
          for (var doc in commSnapshot.data!.docs) {
            pendingAmount += (doc.data() as Map<String, dynamic>)['commissionAmount'] ?? 0;
          }
        }

        if (isMobile) {
          return Column(
            children: [
              _StatBox(title: 'Người giới thiệu', value: '${affData['referralCount'] ?? 0}', icon: Icons.people_outline, color: Colors.blue),
              const SizedBox(height: 16),
              _StatBox(title: 'Hoa hồng chờ duyệt', value: '\$${pendingAmount.toStringAsFixed(2)}', icon: Icons.timer_outlined, color: Colors.orange),
              const SizedBox(height: 16),
              _StatBox(title: 'Tổng thu nhập', value: '\$${(affData['totalEarnings'] ?? 0).toStringAsFixed(2)}', icon: Icons.account_balance_wallet_outlined, color: Colors.green),
            ],
          );
        }
        
        return Row(
          children: [
            Expanded(child: _StatBox(title: 'Người giới thiệu', value: '${affData['referralCount'] ?? 0}', icon: Icons.people_outline, color: Colors.blue)),
            const SizedBox(width: 20),
            Expanded(child: _StatBox(title: 'Hoa hồng chờ duyệt', value: '\$${pendingAmount.toStringAsFixed(2)}', icon: Icons.timer_outlined, color: Colors.orange)),
            const SizedBox(width: 20),
            Expanded(child: _StatBox(title: 'Tổng thu nhập', value: '\$${(affData['totalEarnings'] ?? 0).toStringAsFixed(2)}', icon: Icons.account_balance_wallet_outlined, color: Colors.green)),
          ],
        );
      },
    );
  }

  Widget _buildDetailsSection(String affDocId, bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 20 : 32),
      decoration: BoxDecoration(
        color: const Color(0xFF161616),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Danh sách giới thiệu mới nhất', style: TextStyle(color: Colors.white, fontSize: isMobile ? 18 : 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          _buildReferralTable(affDocId, isMobile),
        ],
      ),
    );
  }

  Widget _buildReferralTable(String affDocId, bool isMobile) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('users')
          .where('referred_by_affiliate_id', isEqualTo: affDocId)
          .orderBy('createdAt', descending: true)
          .limit(10)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Center(
              child: Text('Không thể tải danh sách giới thiệu lúc này.', style: TextStyle(color: Colors.redAccent)),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Center(
              child: Text('Chưa có người dùng nào được giới thiệu.', style: TextStyle(color: Colors.white38)),
            ),
          );
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: WidgetStateProperty.all(Colors.white.withOpacity(0.05)),
            columns: const [
              DataColumn(label: Text('Ngày đăng ký', style: TextStyle(color: Colors.white))),
              DataColumn(label: Text('Email (Bảo mật)', style: TextStyle(color: Colors.white))),
              DataColumn(label: Text('Trạng thái', style: TextStyle(color: Colors.white))),
            ],
            rows: snapshot.data!.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              final date = (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now();
              final email = data['email'] ?? '---';
              final maskedEmail = email.length > 5 ? '${email.substring(0, 3)}***${email.substring(email.indexOf('@'))}' : email;
              
              return DataRow(cells: [
                DataCell(Text(DateFormat('dd/MM/yyyy').format(date), style: const TextStyle(color: Colors.white70))),
                DataCell(Text(maskedEmail, style: const TextStyle(color: Colors.white70))),
                DataCell(Text(data['subscriptionTier']?.toUpperCase() ?? 'FREE', style: TextStyle(color: data['subscriptionTier'] == 'elite' ? Colors.green : Colors.white54))),
              ]);
            }).toList(),
          ),
        );
      },
    );
  }
}

class _StatBox extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatBox({required this.title, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white70, fontSize: 14)),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
