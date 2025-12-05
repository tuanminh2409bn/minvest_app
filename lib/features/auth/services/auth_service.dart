// lib/features/auth/services/auth_service.dart

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:minvest_forex_app/services/session_service.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:minvest_forex_app/core/exceptions/auth_exceptions.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:minvest_forex_app/services/device_info_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:math';
import 'dart:io';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseFunctions _functions = FirebaseFunctions.instanceFor(region: "asia-southeast1");
  final _forceLogoutController = StreamController<String>.broadcast();
  Stream<String> get forceLogoutStream => _forceLogoutController.stream;
  StreamSubscription<DocumentSnapshot>? _sessionSubscription;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> sendPhoneOtp(String phoneNumber) async {
    final completer = Completer<String>();
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (credential) {},
      verificationFailed: (e) {
        if (!completer.isCompleted) {
          completer.completeError(e);
        }
      },
      codeSent: (verificationId, forceResendingToken) {
        if (!completer.isCompleted) {
          completer.complete(verificationId);
        }
      },
      codeAutoRetrievalTimeout: (verificationId) {
        if (!completer.isCompleted) {
          completer.complete(verificationId);
        }
      },
    );
    return completer.future;
  }

  Future<User?> signUpWithEmailPhone({
    required String email,
    required String password,
    required String displayName,
    required String phoneNumber,
    required String countryCode,
    required String verificationId,
    required String smsCode,
  }) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    final user = userCredential.user;
    if (user == null) return null;

    await user.updateDisplayName(displayName);

    final phoneCredential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
    try {
      await user.linkWithCredential(phoneCredential);
    } catch (e) {
      // ignore link errors to avoid blocking signup
      print('Link phone error: $e');
    }

    await _handleSuccessfulSignIn(userCredential);

    try {
      await _firestore.collection('users').doc(user.uid).set({
        'phone': phoneNumber,
        'countryCode': countryCode,
      }, SetOptions(merge: true));
    } catch (e) {
      print('Error updating phone: $e');
    }

    return user;
  }

  Future<User?> signUpWithEmailPassword({
    required String email,
    required String password,
    required String displayName,
    String? phoneNumber,
    String? countryCode,
  }) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCredential.user;
    if (user == null) return null;

    await user.updateDisplayName(displayName);

    // Không cần OTP: chỉ lưu thông tin người dùng vào Firestore.
    await _handleSuccessfulSignIn(userCredential);

    try {
      await _firestore.collection('users').doc(user.uid).set({
        'phone': phoneNumber,
        'countryCode': countryCode,
      }, SetOptions(merge: true));
    } catch (e) {
      print('Error updating phone info: $e');
    }

    return user;
  }

  Future<User?> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return await _handleSuccessfulSignIn(userCredential);
    } catch (e) {
      print('Lỗi đăng nhập email/password: $e');
      rethrow;
    }
  }

  Future<void> listenForSessionChanges() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return;

    final currentDeviceId = await DeviceInfoService.getDeviceId();
    stopListeningForSessionChanges(); // Hủy listener cũ trước khi tạo cái mới

    final userDocRef = _firestore.collection('users').doc(user.uid);
    _sessionSubscription = userDocRef.snapshots().listen((snapshot) async { // Thêm 'async'
      if (snapshot.exists && snapshot.data() != null) {
        final data = snapshot.data()!;

        // 1. Đọc trường "logoutTargetDeviceId" từ server
        final targetDeviceId = data['logoutTargetDeviceId'] as String?;

        // 2. So sánh mục tiêu với ID của thiết bị hiện tại
        if (targetDeviceId != null && targetDeviceId == currentDeviceId) {
          print('AuthService: Nhận lệnh đăng xuất từ server cho thiết bị này.');

          // 3. Kích hoạt luồng đăng xuất bắt buộc
          if (!_forceLogoutController.isClosed) {
            _forceLogoutController.add('Tài khoản của bạn đã được đăng nhập trên một thiết bị khác.');
          }

          // 4. (RẤT QUAN TRỌNG) Xóa "lệnh" trên server sau khi đã nhận
          // Để tránh việc bị đăng xuất lặp lại nếu có lỗi xảy ra.
          try {
            await userDocRef.update({'logoutTargetDeviceId': FieldValue.delete()});
          } catch (e) {
            print("Lỗi khi xóa logoutTargetDeviceId: $e");
          }
        }
      }
    });
  }

  void stopListeningForSessionChanges() {
    _sessionSubscription?.cancel();
    _sessionSubscription = null;
  }

  Future<void> _requestTrackingPermission() async {
    if (Platform.isIOS) {
      final status = await AppTrackingTransparency.trackingAuthorizationStatus;
      if (status == TrackingStatus.notDetermined) {
        await AppTrackingTransparency.requestTrackingAuthorization();
      }
    }
  }

  String _generateNonce([int length = 32]) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }

  String _sha256(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<User?> _handleSuccessfulSignIn(UserCredential userCredential, {
    bool isAnonymous = false,
    Map<String, dynamic>? facebookUserData,
    String? appleEmail,
    String? appleFullName,
    String? googleEmail,
  }) async {
    final User? user = userCredential.user;
    if (user == null) return null;

    try {
      final prefs = await SharedPreferences.getInstance();
      final languageCode = prefs.getString('language_code') ?? 'en'; // Lấy ngôn ngữ, mặc định là 'en' nếu không có

      await _firestore.runTransaction((transaction) async {
        final userDocRef = _firestore.collection('users').doc(user.uid);
        final userDoc = await transaction.get(userDocRef);

      if (!userDoc.exists) {
        if (isAnonymous) {
          transaction.set(userDocRef, {
            'uid': user.uid,
            'email': 'guest_${user.uid}@minvest.com',
              'displayName': 'Guest',
              'photoURL': null,
              'createdAt': Timestamp.now(),
              'subscriptionTier': 'free',
              'role': 'guest',
              'isSuspended': false,
              'languageCode': languageCode, // 2. Thêm languageCode cho Guest
            });
          } else {
            String? email = googleEmail ?? appleEmail ?? facebookUserData?['email'] ?? user.email;
            final displayName = appleFullName ?? facebookUserData?['name'] ?? user.displayName;
            final photoURL = facebookUserData?['picture']?['data']?['url'] ?? user.photoURL;

            if (email == null && user.providerData.any((p) => p.providerId == 'apple.com')) {
              email = '${user.uid}@appleid.placeholder.com';
            }

          if (email == null) {
            throw Exception("Không thể lấy được địa chỉ email. Vui lòng thử lại.");
          }

          transaction.set(userDocRef, {
            'uid': user.uid,
            'email': email,
            'displayName': displayName,
            'photoURL': photoURL,
            'createdAt': Timestamp.now(),
            'subscriptionTier': 'free',
            'role': 'user',
            'isSuspended': false,
            'languageCode': languageCode, // 3. Thêm languageCode cho người dùng thường
            'phone': user.phoneNumber,
          });
        }
      } else {
        if (userDoc.data()?['isSuspended'] == true) {
          throw SuspendedAccountException(userDoc.data()?['suspensionReason'] ?? 'Vui lòng liên hệ quản trị viên.');
          }
        }
      });
    } catch (e) {
      print("Lỗi trong transaction tạo user: $e");
      rethrow;
    }

    if (!isAnonymous) {
      await SessionService().updateUserSession();
      await listenForSessionChanges();
    }
    return user;
  }

  Future<User?> signInAnonymously() async {
    try {
      final userCredential = await _firebaseAuth.signInAnonymously();
      return await _handleSuccessfulSignIn(userCredential, isAnonymous: true);
    } catch (e) {
      print('Lỗi đăng nhập ẩn danh: $e');
      rethrow;
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;
      final String? googleEmail = googleUser.email;
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await _firebaseAuth.signInWithCredential(credential);
      return await _handleSuccessfulSignIn(userCredential, googleEmail: googleEmail);
    } catch (e) {
      print('Lỗi đăng nhập Google: $e');
      rethrow;
    }
  }

  Future<User?> signInWithFacebook() async {
    try {
      UserCredential userCredential;
      Map<String, dynamic>? facebookUserData;

      if (kIsWeb) {
        userCredential = await _firebaseAuth.signInWithPopup(FacebookAuthProvider());
      } else {
        await _requestTrackingPermission();
        final LoginResult result = await FacebookAuth.instance.login(
          loginTracking: LoginTracking.enabled,
          permissions: ['public_profile', 'email'],
        );
        if (result.status != LoginStatus.success) return null;
        facebookUserData = await FacebookAuth.instance.getUserData(fields: "name,email,picture.width(200)");
        final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.tokenString);
        userCredential = await _firebaseAuth.signInWithCredential(credential);
      }
      return await _handleSuccessfulSignIn(userCredential, facebookUserData: facebookUserData);
    } catch (e) {
      print('Lỗi đăng nhập Facebook: $e');
      rethrow;
    }
  }

  Future<User?> signInWithApple() async {
    try {
      UserCredential userCredential;
      String? appleEmail;
      String? appleFullName;
      if (kIsWeb) {
        userCredential = await _firebaseAuth.signInWithPopup(AppleAuthProvider());
      } else if (Platform.isIOS || Platform.isMacOS) {
        final rawNonce = _generateNonce();
        final nonce = _sha256(rawNonce);
        final appleCredential = await SignInWithApple.getAppleIDCredential(
          scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
          nonce: nonce,
        );
        appleEmail = appleCredential.email;
        if (appleCredential.givenName != null || appleCredential.familyName != null) {
          appleFullName = '${appleCredential.givenName ?? ''} ${appleCredential.familyName ?? ''}'.trim();
        }
        final oAuthCredential = OAuthProvider('apple.com').credential(
          idToken: appleCredential.identityToken,
          rawNonce: rawNonce,
          accessToken: appleCredential.authorizationCode,
        );
        userCredential = await _firebaseAuth.signInWithCredential(oAuthCredential);
      } else {
        throw UnsupportedError('Đăng nhập Apple không được hỗ trợ trên thiết bị này.');
      }
      return await _handleSuccessfulSignIn(userCredential, appleEmail: appleEmail, appleFullName: appleFullName);
    } catch (e) {
      print('Lỗi đăng nhập Apple: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    stopListeningForSessionChanges();
    try {
      if (!kIsWeb) {
        await FacebookAuth.instance.logOut();
      }
      await GoogleSignIn().signOut();
    } catch (e) {
      print("Lỗi khi đăng xuất khỏi các nhà cung cấp: $e");
    } finally {
      await _firebaseAuth.signOut();
      print("Đã đăng xuất khỏi Firebase");
    }
  }

  Future<void> deleteAccountAndData() async {
    try {
      final callable = _functions.httpsCallable('deleteUserAccount');
      final result = await callable.call();
      print('Cloud function deleteUserAccount được gọi thành công: ${result.data}');
      await signOut();
    } on FirebaseFunctionsException catch (e) {
      print('Lỗi khi gọi cloud function: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      print('Lỗi không xác định khi xóa tài khoản: $e');
      rethrow;
    }
  }
}
