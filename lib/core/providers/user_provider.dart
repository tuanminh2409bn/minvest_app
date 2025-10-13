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
  UserDataStatus _status = UserDataStatus.initial;

  // --- THAY ĐỔI 1: Thay thế các trường cũ bằng trường mới chung hơn ---
  bool _requiresSessionReset = false;
  String? _sessionResetReason;

  String? get userTier => _userTier;
  String? get verificationStatus => _verificationStatus;
  String? get verificationError => _verificationError;
  String? get role => _role;
  UserDataStatus get status => _status;

  // --- THAY ĐỔI 2: Cung cấp getter cho các thuộc tính mới ---
  bool get requiresSessionReset => _requiresSessionReset;
  String? get sessionResetReason => _sessionResetReason;

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
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        _userTier = data['subscriptionTier'];
        _verificationStatus = data['verificationStatus'];
        _verificationError = data['verificationError'];
        _role = data['role'] ?? 'user';

        // --- THAY ĐỔI 3: Đọc dữ liệu từ các trường mới trên Firestore ---
        _requiresSessionReset = data['requiresSessionReset'] ?? false;
        _sessionResetReason = data['sessionResetReason'];

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
    // --- THAY ĐỔI 5: Reset các trường mới ---
    _requiresSessionReset = false;
    _sessionResetReason = null;
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