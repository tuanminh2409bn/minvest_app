import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minvest_forex_app/core/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';

enum VerificationState { initial, imageSelected, loading, success, failure }

class AccountVerificationScreen extends StatefulWidget {
  const AccountVerificationScreen({super.key});

  @override
  State<AccountVerificationScreen> createState() => _AccountVerificationScreenState();
}

class _AccountVerificationScreenState extends State<AccountVerificationScreen> {
  // Thay đổi: Lưu lại XFile để có thể lấy metadata
  XFile? _pickedImageFile;
  VerificationState _currentState = VerificationState.initial;
  String _errorMessage = '';
  String _successTier = '';
  final String _exnessSignUpUrl = 'https://my.exmarkets.guide/accounts/sign-up/303589?utm_source=partners&ex_ol=1';

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _pickedImageFile = pickedFile; // Lưu XFile
        _currentState = VerificationState.imageSelected;
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_pickedImageFile == null) return;
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    setState(() {
      _currentState = VerificationState.loading;
    });

    try {
      // --- THAY ĐỔI BẮT ĐẦU ---

      // 1. Lấy đuôi file gốc (png, jpg, etc.)
      final fileExtension = _pickedImageFile!.name.split('.').last;

      // 2. Tạo đường dẫn với đuôi file chính xác
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef.child('verification_images/$userId.$fileExtension');

      // 3. Tạo metadata để đính kèm content type
      final metadata = SettableMetadata(
        contentType: _pickedImageFile!.mimeType ?? 'image/jpeg', // Gán loại file ảnh
      );

      // 4. Tải file LÊN KÈM metadata
      await imageRef.putFile(File(_pickedImageFile!.path), metadata);

      // --- THAY ĐỔI KẾT THÚC ---

    } catch (e) {
      if (mounted) {
        setState(() {
          _currentState = VerificationState.failure;
          if (e is FirebaseException && e.code == 'permission-denied') {
            _errorMessage = "Upload failed: Permission denied. Check Storage Rules.";
          } else {
            _errorMessage = "Failed to upload image. Please check your connection.";
          }
        });
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final userProvider = Provider.of<UserProvider>(context, listen: true);

    if (_currentState == VerificationState.loading) {
      if (userProvider.verificationStatus == 'success') {
        if (mounted) {
          setState(() {
            _currentState = VerificationState.success;
            _successTier = userProvider.userTier ?? 'N/A';
          });
        }
      } else if (userProvider.verificationStatus == 'failed') {
        if (mounted) {
          setState(() {
            _currentState = VerificationState.failure;
            _errorMessage = userProvider.verificationError ?? 'Verification failed.';
          });
        }
      }
    }
  }

  Future<void> _launchURL(String url) async {
    final l10n = AppLocalizations.of(context)!;
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.couldNotLaunch(url))),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          l10n.accountVerification,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D1117), Color(0xFF161B22), Color.fromARGB(255, 20, 29, 110)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        // --- THAY ĐỔI NẰM Ở ĐÂY ---
        child: SafeArea( // 1. Thêm SafeArea ở đây
          child: Padding(   // 2. Để Padding và nội dung bên trong nó
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: _buildContent(l10n),
          ),
        ),
        // --- KẾT THÚC THAY ĐỔI ---
      ),
    );
  }

  Widget _buildContent(AppLocalizations l10n) {
    switch (_currentState) {
      case VerificationState.loading:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 20),
              Text(l10n.processingYourAccount, style: const TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
        );
      case VerificationState.success:
        return _buildSuccessView(l10n);
      case VerificationState.failure:
        return _buildFailureView(l10n);
      case VerificationState.initial:
      case VerificationState.imageSelected:
      default:
        return _buildInitialView(l10n);
    }
  }

  Widget _buildInitialView(AppLocalizations l10n) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 350,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: _pickedImageFile == null
                  ? Image.asset('assets/images/exness_example.png', fit: BoxFit.contain)
                  : ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(File(_pickedImageFile!.path), fit: BoxFit.contain),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              l10n.accountVerificationPrompt,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, height: 1.5, fontSize: 14),
            ),
            const SizedBox(height: 30),
            _buildActionButton(
              text: l10n.selectPhotoFromLibrary,
              onPressed: _pickImage,
              isPrimary: false,
            ),
            const SizedBox(height: 16),
            _buildActionButton(
              text: l10n.send,
              onPressed: _pickedImageFile != null ? _uploadImage : null,
              isPrimary: true,
            ),
          ],
        ),
      ),
    );
  }

  // Các hàm build view còn lại giữ nguyên...
  Widget _buildSuccessView(AppLocalizations l10n) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.check_circle, color: Colors.green, size: 80),
        const SizedBox(height: 20),
        Text(
          l10n.accountVerifiedSuccessfully,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          '${l10n.yourAccountIs} ${_successTier.toUpperCase()}',
          style: const TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 30),
        _buildTierBenefitsCard(_successTier, l10n),
        const SizedBox(height: 40),
        TextButton(
          onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
          child: Text(
            '${l10n.returnToHomePage} >',
            style: const TextStyle(color: Colors.blueAccent, fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildFailureView(AppLocalizations l10n) {
    final bool isAffiliateError = _errorMessage.toLowerCase().contains("not under minvest's affiliate link");

    if (isAffiliateError) {
      return _buildAffiliateErrorView(l10n);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.error, color: Colors.red, size: 80),
        const SizedBox(height: 20),
        Text(l10n.verificationFailed, style: const TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Text(
            _errorMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70)
        ),
        const SizedBox(height: 40),
        _buildActionButton(
          text: l10n.reuploadImage,
          onPressed: () {
            setState(() {
              _pickedImageFile = null;
              _currentState = VerificationState.initial;
            });
          },
          isPrimary: true,
        ),
      ],
    );
  }

  Widget _buildAffiliateErrorView(AppLocalizations l10n) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/minvest_logo.png', height: 60),
        const SizedBox(height: 24),
        Text(
          l10n.accountNotLinked,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Text(
          l10n.accountNotLinkedDesc,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white70, height: 1.5, fontSize: 14),
        ),
        const SizedBox(height: 32),
        _buildActionButton(
          text: l10n.registerExnessViaMinvest,
          onPressed: () => _launchURL(_exnessSignUpUrl),
          isPrimary: true,
        ),
        const SizedBox(height: 16),
        _buildActionButton(
          text: l10n.iHaveRegisteredReupload,
          onPressed: () {
            setState(() {
              _pickedImageFile = null;
              _currentState = VerificationState.initial;
            });
          },
          isPrimary: false,
        ),
      ],
    );
  }

  Widget _buildTierBenefitsCard(String tier, AppLocalizations l10n) {
    final Map<String, String> tierInfo = _getTierInfo(tier, l10n);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF151a2e),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blueGrey.withOpacity(0.2)),
      ),
      child: Column(
        children: tierInfo.entries.map((entry) => _buildBenefitRow(entry.key, entry.value)).toList(),
      ),
    );
  }

  Widget _buildBenefitRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Expanded(child: Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14))),
          const SizedBox(width: 16),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Map<String, String> _getTierInfo(String tier, AppLocalizations l10n) {
    switch (tier.toLowerCase()) {
      case 'demo': return {l10n.signalTime: '8h-17h', l10n.lotPerWeek: '0.05', l10n.signalQty: '7-8 per day'};
      case 'vip': return {l10n.signalTime: '8h-17h', l10n.lotPerWeek: '0.3', l10n.signalQty: 'full'};
      case 'elite': return {l10n.signalTime: 'fulltime', l10n.lotPerWeek: '0.5', l10n.signalQty: 'full'};
      default: return {l10n.signalTime: 'N/A', l10n.lotPerWeek: 'N/A', l10n.signalQty: 'N/A'};
    }
  }

  Widget _buildActionButton({required String text, required VoidCallback? onPressed, required bool isPrimary}) {
    final bool isEnabled = onPressed != null;
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          disabledBackgroundColor: Colors.grey.withOpacity(0.2),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: isEnabled && isPrimary ? const LinearGradient(colors: [Color(0xFF172AFE), Color(0xFF3C4BFE), Color(0xFF5E69FD)], begin: Alignment.centerLeft, end: Alignment.centerRight) : null,
            color: isEnabled && !isPrimary ? const Color(0xFF151a2e) : null,
            borderRadius: BorderRadius.circular(12),
            border: isEnabled && !isPrimary ? Border.all(color: Colors.blueAccent) : null,
          ),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isEnabled ? Colors.white : Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}