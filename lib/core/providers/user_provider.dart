// lib/core/providers/user_provider.dart

import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minvest_forex_app/features/auth/services/auth_service.dart';
import 'package:minvest_forex_app/services/device_info_service.dart';

enum UserDataStatus { initial, loading, fromCache, fromServer, error }

class UserProvider with ChangeNotifier {
  final AuthService _authService;

  String? _uid;
  String? _email;
  String? _userTier;
  String? _verificationStatus;
  String? _verificationError;
  String? _role;
  String? _displayName;
  UserDataStatus _status = UserDataStatus.initial;
  String? _currentDeviceId;

  // --- Session Management ---
  bool _requiresSessionReset = false;
  String? _sessionResetReason;
  
  // --- Token & Subscriptions ---
  int _tokenBalance = 0;
  List<String> _activeSubscriptions = [];
  List<String> _unlockedSignals = [];
  DateTime? _subscriptionExpiryDate;
  Map<String, DateTime> _subscriptionsExpiry = {};

  String? get uid => _uid;
  String? get email => _email;
  String? get userTier => _userTier;
  String? get verificationStatus => _verificationStatus;
  String? get verificationError => _verificationError;
  String? get role => _role;
  String? get userRole => _role; // Alias cho tương thích với Navbar
  String? get displayName => _displayName;
  UserDataStatus get status => _status;

  bool get requiresSessionReset => _requiresSessionReset;
  String? get sessionResetReason => _sessionResetReason;
  int get tokenBalance => _tokenBalance;
  List<String> get activeSubscriptions => _activeSubscriptions;
  List<String> get unlockedSignals => _unlockedSignals;
  DateTime? get subscriptionExpiryDate => _subscriptionExpiryDate;
  Map<String, DateTime> get subscriptionsExpiry => _subscriptionsExpiry;

  StreamSubscription<DocumentSnapshot>? _userSubscription;
  StreamSubscription<User?>? _authStateSubscription;

  UserProvider({required AuthService authService}) : _authService = authService {
    _authStateSubscription =
        _authService.authStateChanges.listen(_onAuthStateChanged);
    _initDeviceId();
  }

  Future<void> _initDeviceId() async {
    _currentDeviceId = await DeviceInfoService.getDeviceId();
  }

  void _onAuthStateChanged(User? firebaseUser) {
    if (firebaseUser != null) {
      _listenToUserDocument(firebaseUser.uid);
    } else {
      stopListeningAndReset();
    }
  }

  void _listenToUserDocument(String uid) {
    _uid = uid;
    _userSubscription?.cancel();
    _status = UserDataStatus.loading;
    notifyListeners();

    _userSubscription = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots(includeMetadataChanges: true)
        .listen((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        
        _email = data['email'];
        _userTier = data['subscriptionTier'];
        _verificationStatus = data['verificationStatus'];
        _verificationError = data['verificationError'];
        _role = data['role'] ?? 'user';
        _displayName = data['displayName'];

        // Logic quản lý phiên mới: Kiểm tra theo platform
        final logoutTargetWeb = data['logoutTargetDeviceIdWeb'];
        final logoutTargetMobile = data['logoutTargetDeviceIdMobile'];
        
        bool platformLogout = false;
        if (kIsWeb) {
          platformLogout = logoutTargetWeb != null && logoutTargetWeb == _currentDeviceId;
        } else {
          platformLogout = logoutTargetMobile != null && logoutTargetMobile == _currentDeviceId;
        }

        _requiresSessionReset = (data['requiresSessionReset'] ?? false) || platformLogout;
        
        if (platformLogout) {
          _sessionResetReason = "Tài khoản của bạn đã được đăng nhập trên một ${kIsWeb ? 'trình duyệt' : 'điện thoại'} khác.";
        } else {
          _sessionResetReason = data['sessionResetReason'];
        }
        
        _tokenBalance = (data['tokenBalance'] ?? 0) as int;
        _activeSubscriptions = List<String>.from(data['activeSubscriptions'] ?? []);
        _unlockedSignals = List<String>.from(data['unlockedSignals'] ?? []);

        if (data['subscriptionExpiryDate'] != null && data['subscriptionExpiryDate'] is Timestamp) {
          _subscriptionExpiryDate = (data['subscriptionExpiryDate'] as Timestamp).toDate();
        } else {
          _subscriptionExpiryDate = null;
        }

        _subscriptionsExpiry = {};
        if (data['subscriptionsExpiry'] != null && data['subscriptionsExpiry'] is Map) {
          final map = data['subscriptionsExpiry'] as Map<String, dynamic>;
          map.forEach((key, value) {
            if (value is Timestamp) {
              _subscriptionsExpiry[key] = value.toDate();
            }
          });
        }

        _status = snapshot.metadata.isFromCache ? UserDataStatus.fromCache : UserDataStatus.fromServer;
      } else {
        _resetState();
        _status = UserDataStatus.fromServer;
      }
      notifyListeners();
    });
  }

  Future<void> acknowledgeSessionReset() async {
    if (_uid != null) {
      try {
        final fieldToRemove = kIsWeb ? 'logoutTargetDeviceIdWeb' : 'logoutTargetDeviceIdMobile';
        await FirebaseFirestore.instance.collection('users').doc(_uid!).update({
          'requiresSessionReset': FieldValue.delete(),
          'sessionResetReason': FieldValue.delete(),
          fieldToRemove: FieldValue.delete(),
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

  Future<bool> unlockSignal(String signalId, {bool freeUnlock = false}) async {
    if (_uid == null) return false;
    
    // Nếu không phải freeUnlock thì kiểm tra số dư
    if (!freeUnlock && _tokenBalance < 1) return false;

    try {
      final Map<String, dynamic> updates = {
        'unlockedSignals': FieldValue.arrayUnion([signalId]),
      };

      // Chỉ trừ token nếu không phải là freeUnlock
      if (!freeUnlock) {
        updates['tokenBalance'] = FieldValue.increment(-1);
      }

      await FirebaseFirestore.instance.collection('users').doc(_uid!).update(updates);
      return true;
    } catch (e) {
      print("Error unlocking signal: $e");
      return false;
    }
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    _authStateSubscription?.cancel();
    super.dispose();
  }
}