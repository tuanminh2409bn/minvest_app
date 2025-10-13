import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minvest_forex_app/core/providers/language_provider.dart';
import 'package:minvest_forex_app/features/auth/bloc/auth_bloc.dart';
import 'package:provider/provider.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);

    // Không còn BlocListener ở đây nữa
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D1117), Color(0xFF161B22), Color.fromARGB(255, 20, 29, 110)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 800) {
              return _buildWebLayout(context, languageProvider);
            } else {
              return _buildMobileLayout(context, languageProvider);
            }
          },
        ),
      ),
    );
  }

  Widget _buildWebLayout(BuildContext context, LanguageProvider languageProvider) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64.0, vertical: 32.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.welcomeTo, style: const TextStyle(fontSize: 24, color: Colors.white)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Image.asset('assets/images/minvest_logo.png', height: 180),
                ),
                Text(
                  l10n.appSlogan,
                  style: const TextStyle(fontSize: 20, color: Colors.white, height: 1.5),
                ),
              ],
            ),
          ),
          const SizedBox(width: 64),
          const VerticalDivider(color: Colors.white24, thickness: 1),
          const SizedBox(width: 64),
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: PopupMenuButton<Locale>(
                    onSelected: (Locale locale) => languageProvider.setLocale(locale),
                    itemBuilder: (context) => [
                      const PopupMenuItem(value: Locale('en'), child: Text('English')),
                      const PopupMenuItem(value: Locale('vi'), child: Text('Tiếng Việt')),
                    ],
                    child: Consumer<LanguageProvider>(
                      builder: (context, provider, child) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(4.0),
                          child: Image.asset(
                            provider.locale?.languageCode == 'vi'
                                ? 'assets/images/vn_flag.png'
                                : 'assets/images/us_flag.png',
                            height: 24, width: 36, fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(l10n.signIn, textAlign: TextAlign.center, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 32),
                    _SocialSignInButton(
                      icon: Image.asset('assets/images/google_logo.png', height: 24, width: 24),
                      text: l10n.continueByGoogle,
                      onPressed: () => context.read<AuthBloc>().add(SignInWithGoogleRequested()),
                    ),
                    const SizedBox(height: 16),
                    _SocialSignInButton(
                      icon: Image.asset('assets/images/facebook_logo.png', height: 24, width: 24),
                      text: l10n.continueByFacebook,
                      onPressed: () => context.read<AuthBloc>().add(SignInWithFacebookRequested()),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, LanguageProvider languageProvider) {
    final l10n = AppLocalizations.of(context)!;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Align(
                alignment: Alignment.topRight,
                child: PopupMenuButton<Locale>(
                  onSelected: (Locale locale) => languageProvider.setLocale(locale),
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: Locale('en'), child: Text('English')),
                    const PopupMenuItem(value: Locale('vi'), child: Text('Tiếng Việt')),
                  ],
                  child: Consumer<LanguageProvider>(
                    builder: (context, provider, child) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(4.0),
                        child: Image.asset(
                          provider.locale?.languageCode == 'vi'
                              ? 'assets/images/vn_flag.png'
                              : 'assets/images/us_flag.png',
                          height: 24, width: 36, fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const Spacer(),
            Text(l10n.welcomeTo, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18, color: Colors.white)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Image.asset('assets/images/minvest_logo.png', height: 150),
            ),
            Text(l10n.appSlogan, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, color: Colors.white, height: 1.5)),
            const SizedBox(height: 50),
            Text(l10n.signIn, textAlign: TextAlign.center, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 24),
            _SocialSignInButton(
              icon: Image.asset('assets/images/google_logo.png', height: 24, width: 24),
              text: l10n.continueByGoogle,
              onPressed: () => context.read<AuthBloc>().add(SignInWithGoogleRequested()),
            ),
            const SizedBox(height: 16),
            _SocialSignInButton(
              icon: Image.asset('assets/images/facebook_logo.png', height: 24, width: 24),
              text: l10n.continueByFacebook,
              onPressed: () => context.read<AuthBloc>().add(SignInWithFacebookRequested()),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}

class _SocialSignInButton extends StatelessWidget {
  final Widget icon;
  final String text;
  final VoidCallback onPressed;

  const _SocialSignInButton({
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF0C0938), Color(0xFF141A4C), Color(0xFF1D2B62)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                icon,
                const SizedBox(width: 24),
                Text(
                    text,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}