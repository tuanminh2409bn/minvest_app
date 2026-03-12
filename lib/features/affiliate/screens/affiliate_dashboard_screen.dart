import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:minvest_forex_app/core/providers/user_provider.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';

class AffiliateDashboardScreen extends StatefulWidget {
  const AffiliateDashboardScreen({super.key});

  @override
  State<AffiliateDashboardScreen> createState() => _AffiliateDashboardScreenState();
}

class _AffiliateDashboardScreenState extends State<AffiliateDashboardScreen> {
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
          
      if (mounted) {
        if (query.docs.isNotEmpty) {
          setState(() {
            _affiliateData = query.docs.first.data();
            _isLoading = false;
          });
        } else {
          setState(() => _isLoading = false);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userRole = userProvider.userRole ?? 'user';
    final bool hasAffiliateRole = userRole == 'admin' || userRole == 'affiliate';
    final l10n = AppLocalizations.of(context)!;

    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: Color(0xFF276EFB))),
      );
    }

    // Lấy thông tin Affiliate từ Stream để đảm bảo real-time và lấy được Document ID chính xác
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('affiliates').where('uid', isEqualTo: _currentUser?.uid).limit(1).snapshots(),
      builder: (context, affSnapshot) {
        if (!hasAffiliateRole) {
          return _buildAccessDeniedScreen(l10n);
        }

        if (!affSnapshot.hasData || affSnapshot.data!.docs.isEmpty) {
          return _buildNoAffiliateCodeScreen(l10n);
        }

        final affDoc = affSnapshot.data!.docs.first;
        final affData = affDoc.data() as Map<String, dynamic>;
        final affDocId = affDoc.id; // Đây là ID dùng để liên kết với người dùng
        final String refCode = affData['code'] ?? '';
        final String refLink = 'https://signalgpt.ai/?ref=$refCode';

        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(l10n.affiliateDashboard, style: const TextStyle(color: Colors.white)),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(refLink, l10n),
                const SizedBox(height: 24),
                _buildStatsRow(affDocId, affData, l10n),
                const SizedBox(height: 32),
                Text(
                  l10n.latestReferrals,
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildReferralList(affDocId, l10n),
              ],
            ),
          ),
        );
      }
    );
  }

  Widget _buildAccessDeniedScreen(AppLocalizations l10n) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text(l10n.affiliateDashboard)),
      body: Center(child: Padding(padding: const EdgeInsets.all(24.0), child: Text(l10n.affiliateRoleRequired, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70, fontSize: 16)))),
    );
  }

  Widget _buildNoAffiliateCodeScreen(AppLocalizations l10n) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text(l10n.affiliateDashboard)),
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.info_outline, color: Colors.orange, size: 64), const SizedBox(height: 24), Text(l10n.affiliateCodeNotAssigned, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))])),
    );
  }

  Widget _buildHeader(String link, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF161616),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.referralLink, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(l10n.referralLinkDescription, style: const TextStyle(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF276EFB).withOpacity(0.5)),
            ),
            child: SelectableText(link, style: const TextStyle(color: Color(0xFF276EFB), fontSize: 14)),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: link));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.linkCopied)));
              },
              icon: const Icon(Icons.copy, size: 18),
              label: Text(l10n.copyLink),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF276EFB),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(String affDocId, Map<String, dynamic> affData, AppLocalizations l10n) {
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

        return Column(
          children: [
            _StatBox(
              title: l10n.referralCount,
              value: '${affData['referralCount'] ?? 0}',
              icon: Icons.people_outline,
              color: Colors.blue,
            ),
            const SizedBox(height: 12),
            _StatBox(
              title: l10n.pendingCommission,
              value: '\$${pendingAmount.toStringAsFixed(2)}',
              icon: Icons.timer_outlined,
              color: Colors.orange,
            ),
            const SizedBox(height: 12),
            _StatBox(
              title: l10n.totalEarnings,
              value: '\$${(affData['totalEarnings'] ?? 0).toStringAsFixed(2)}',
              icon: Icons.account_balance_wallet_outlined,
              color: Colors.green,
            ),
          ],
        );
      },
    );
  }

  Widget _buildReferralList(String affDocId, AppLocalizations l10n) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('users')
          .where('referred_by_affiliate_id', isEqualTo: affDocId)
          .orderBy('createdAt', descending: true)
          .limit(20)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(l10n.error, style: const TextStyle(color: Colors.redAccent)));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Color(0xFF276EFB)));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Text(l10n.noReferralsYet, style: const TextStyle(color: Colors.white38)),
            ),
          );
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: snapshot.data!.docs.length,
          separatorBuilder: (context, index) => const Divider(color: Colors.white10),
          itemBuilder: (context, index) {
            final data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
            final date = (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now();
            final email = data['email'] ?? '---';
            final maskedEmail = email.length > 8 
                ? '${email.substring(0, 4)}***${email.substring(email.indexOf('@'))}' 
                : email;
            final tier = (data['subscriptionTier'] ?? 'free').toString().toUpperCase();
            
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(maskedEmail, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 4),
                      Text(DateFormat('dd/MM/yyyy HH:mm').format(date), style: const TextStyle(color: Colors.white54, fontSize: 12)),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: tier == 'ELITE' ? Colors.green.withOpacity(0.1) : Colors.white10,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: tier == 'ELITE' ? Colors.green.withOpacity(0.3) : Colors.white24),
                    ),
                    child: Text(
                      tier,
                      style: TextStyle(
                        color: tier == 'ELITE' ? Colors.green : Colors.white70,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
