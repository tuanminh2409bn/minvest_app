// lib/core/providers/user_provider.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minvest_forex_app/features/auth/services/auth_service.dart';

enum UserDataStatus { initial, loading, fromCache, fromServer, error }

class UserProvider with ChangeNotifier {
  final AuthService _authService;

  String? _uid;
  String? _userTier;
  String? _verificationStatus;
  String? _verificationError;
  String? _role;
  String? _displayName; // Thêm trường displayName
  UserDataStatus _status = UserDataStatus.initial;

  // --- THAY ĐỔI 1: Thay thế các trường cũ bằng trường mới chung hơn ---
  bool _requiresSessionReset = false;
  String? _sessionResetReason;
  
  // --- THAY ĐỔI: Token & Subscriptions ---
  int _tokenBalance = 0;
  List<String> _activeSubscriptions = [];
  List<String> _unlockedSignals = []; // New Field
  DateTime? _subscriptionExpiryDate;
  Map<String, DateTime> _subscriptionsExpiry = {};

  String? get uid => _uid;
  String? get userTier => _userTier;
  String? get verificationStatus => _verificationStatus;
  String? get verificationError => _verificationError;
  String? get role => _role;
  String? get displayName => _displayName; // Getter cho displayName
  UserDataStatus get status => _status;

  // --- THAY ĐỔI 2: Cung cấp getter cho các thuộc tính mới ---
  bool get requiresSessionReset => _requiresSessionReset;
  String? get sessionResetReason => _sessionResetReason;
  int get tokenBalance => _tokenBalance;
  List<String> get activeSubscriptions => _activeSubscriptions;
  List<String> get unlockedSignals => _unlockedSignals; // New Getter
  DateTime? get subscriptionExpiryDate => _subscriptionExpiryDate;
  Map<String, DateTime> get subscriptionsExpiry => _subscriptionsExpiry;

  StreamSubscription<DocumentSnapshot>? _userSubscription;
  StreamSubscription<User?>? _authStateSubscription;

  UserProvider({required AuthService authService}) : _authService = authService {
    _authStateSubscription =
        _authService.authStateChanges.listen(_onAuthStateChanged);
  }

  void _onAuthStateChanged(User? firebaseUser) {
    if (firebaseUser != null) {
      _listenToUserDocument(firebaseUser.uid);
    } else {
      stopListeningAndReset();
    }
  }

  void _listenToUserDocument(String uid) {
    print("DEBUG: UserProvider started listening to UID: $uid"); // Debug UID
    _uid = uid;
    _userSubscription?.cancel();
    _status = UserDataStatus.loading;
    notifyListeners();

    _userSubscription = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots(includeMetadataChanges: true)
        .listen((snapshot) {
      final bool isFromCache = snapshot.metadata.isFromCache;
      print("DEBUG: Firestore snapshot received. Source: ${isFromCache ? 'Cache' : 'Server'}. Exists: ${snapshot.exists}"); // Debug Source
      
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        print("DEBUG: Firestore Data for $uid: $data"); // Debug FULL Data
        
        _userTier = data['subscriptionTier'];
        _verificationStatus = data['verificationStatus'];
        _verificationError = data['verificationError'];
        _role = data['role'] ?? 'user';
        _displayName = data['displayName']; // Đọc displayName từ Firestore

        // --- THAY ĐỔI 3: Đọc dữ liệu từ các trường mới trên Firestore ---
        _requiresSessionReset = data['requiresSessionReset'] ?? false;
        _sessionResetReason = data['sessionResetReason'];
        
        _tokenBalance = (data['tokenBalance'] ?? 0) as int;
        _activeSubscriptions = List<String>.from(data['activeSubscriptions'] ?? []);
        _unlockedSignals = List<String>.from(data['unlockedSignals'] ?? []); // Parse unlockedSignals

        // Parse subscriptionExpiryDate
        if (data['subscriptionExpiryDate'] != null && data['subscriptionExpiryDate'] is Timestamp) {
          _subscriptionExpiryDate = (data['subscriptionExpiryDate'] as Timestamp).toDate();
        } else {
          _subscriptionExpiryDate = null;
        }

        // Parse subscriptionsExpiry map
        _subscriptionsExpiry = {};
        if (data['subscriptionsExpiry'] != null && data['subscriptionsExpiry'] is Map) {
          final map = data['subscriptionsExpiry'] as Map<String, dynamic>;
          map.forEach((key, value) {
            if (value is Timestamp) {
              _subscriptionsExpiry[key] = value.toDate();
            }
          });
        }

        _status =
        isFromCache ? UserDataStatus.fromCache : UserDataStatus.fromServer;
      } else {
        _resetState();
        _status = UserDataStatus.fromServer;
      }
      notifyListeners();
    }, onError: (error) {
      print("Lỗi khi lắng nghe dữ liệu người dùng: $error");
      _status = UserDataStatus.error;
      _resetState();
      notifyListeners();
    });
  }

  // --- THAY ĐỔI 4: Hàm mới để xác nhận và xóa cờ hiệu ---
  Future<void> acknowledgeSessionReset() async {
    if (_uid != null) {
      try {
        await FirebaseFirestore.instance.collection('users').doc(_uid!).update({
          'requiresSessionReset': FieldValue.delete(),
          'sessionResetReason': FieldValue.delete(),
        });
        _requiresSessionReset = false;
        notifyListeners();
      } catch (e) {
        print("Lỗi khi xác nhận reset session: $e");
      }
    }
  }

  Future<void> stopListeningAndReset() async {
    await _userSubscription?.cancel();
    _userSubscription = null;
    _resetState();
    _status = UserDataStatus.initial;
    notifyListeners();
  }

  void _resetState() {
    _uid = null;
    _userTier = null;
    _verificationStatus = null;
    _verificationError = null;
    _role = null;
    _displayName = null; // Reset displayName
    // --- THAY ĐỔI 5: Reset các trường mới ---
    _requiresSessionReset = false;
    _sessionResetReason = null;
    _tokenBalance = 0;
    _activeSubscriptions = [];
    _unlockedSignals = []; // Reset unlockedSignals
    _subscriptionExpiryDate = null;
    _subscriptionsExpiry = {};
  }

  void clearVerificationStatus() {
    if (_verificationStatus == 'failed') {
      _verificationStatus = null;
      _verificationError = null;
    }
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    _authStateSubscription?.cancel();
    super.dispose();
  }
}