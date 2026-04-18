import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:minvest_forex_app/core/models/exchange_app.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AffiliateProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<ExchangeApp> _exchangeApps = allExchangeApps;
  bool _isLoading = false;

  List<ExchangeApp> get exchangeApps => _exchangeApps;
  bool get isLoading => _isLoading;

  AffiliateProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    // Chờ một chút để Firebase Auth kịp khởi tạo
    await Future.delayed(const Duration(seconds: 2));
    await fetchAffiliateLinks();
    
    // Kiểm tra thực tế trên Firestore
    try {
      final snapshot = await _firestore.collection('settings').doc('affiliate_links').get();
      if (!snapshot.exists) {
        debugPrint('Affiliate links not found on Firestore, seeding...');
        await seedAffiliateLinks();
      } else {
        debugPrint('Affiliate links found on Firestore');
      }
    } catch (e) {
      debugPrint('Error during initialization: $e');
    }
  }

  Future<void> fetchAffiliateLinks() async {
    _isLoading = true;
    notifyListeners();

    try {
      final snapshot = await _firestore.collection('settings').doc('affiliate_links').get();
      
      if (snapshot.exists && snapshot.data() != null) {
        final List<dynamic> linksData = snapshot.data()!['links'] ?? [];
        if (linksData.isNotEmpty) {
          _exchangeApps = linksData
              .map((item) => ExchangeApp.fromMap(item as Map<String, dynamic>))
              .toList();
          debugPrint('Successfully fetched ${_exchangeApps.length} affiliate links from Firestore');
        }
      }
    } catch (e) {
      debugPrint('Error fetching affiliate links: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Đẩy dữ liệu từ code lên Firestore để làm dữ liệu mẫu
  Future<void> seedAffiliateLinks() async {
    // Chỉ seed nếu đã đăng nhập (để thỏa mãn Rules)
    if (FirebaseAuth.instance.currentUser == null) {
      debugPrint('Cannot seed affiliate links: User not signed in');
      return;
    }

    try {
      final List<Map<String, dynamic>> linksToUpload = 
          allExchangeApps.map((app) => app.toMap()).toList();
      
      await _firestore.collection('settings').doc('affiliate_links').set({
        'links': linksToUpload,
        'lastUpdated': FieldValue.serverTimestamp(),
        'seededBy': FirebaseAuth.instance.currentUser?.uid,
      });
      
      debugPrint('Successfully seeded affiliate links to Firestore/settings');
      // Fetch lại sau khi seed
      await fetchAffiliateLinks();
    } catch (e) {
      debugPrint('Error seeding affiliate links: $e');
    }
  }

  String getUrlForApp(String name) {
    try {
      return _exchangeApps.firstWhere(
        (app) => app.name.toLowerCase() == name.toLowerCase() || 
                 (name == 'Vantage' && app.name == 'Vantagemarkets'),
      ).url;
    } catch (_) {
      try {
        return allExchangeApps.firstWhere(
          (app) => app.name.toLowerCase() == name.toLowerCase() ||
                   (name == 'Vantage' && app.name == 'Vantagemarkets'),
        ).url;
      } catch (__) {
        return '';
      }
    }
  }
}
