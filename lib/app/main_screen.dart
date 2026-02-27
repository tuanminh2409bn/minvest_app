// lib/app/main_screen.dart

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:minvest_forex_app/app/widgets/liquid_glass_nav_bar.dart';
import 'package:minvest_forex_app/features/auth/screens/profile_screen_mobile.dart';
import 'package:minvest_forex_app/features/chart/screens/chart_screen.dart';
import 'package:minvest_forex_app/features/signals/screens/signal_screen.dart';
import 'package:minvest_forex_app/features/signals/screens/signal_history_screen.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import 'package:minvest_forex_app/core/providers/user_provider.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  late PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void switchToTab(int index) {
    if (mounted && index >= 0 && index < _pages.length) {
      _pageController.jumpToPage(index);
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  final List<Widget> _pages = [
    const SignalScreen(),         // index 0
    const ChartScreen(),          // index 1
    const SignalHistoryScreen(),  // index 2
    const ProfileScreen(),        // index 3
  ];

  void _onItemTapped(int index) {
    switchToTab(index);
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Nội dung các trang
          PageView(
            controller: _pageController,
            children: _pages,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            physics: const NeverScrollableScrollPhysics(),
          ),

          // Menu lơ lửng Liquid Glass
          Positioned(
            bottom: bottomPadding > 0 ? bottomPadding : 20,
            left: 0,
            right: 0,
            child: Center(
              child: LiquidGlassNavBar(
                selectedIndex: _selectedIndex,
                onTap: _onItemTapped,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
