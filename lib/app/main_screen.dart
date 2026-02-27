// lib/app/main_screen.dart

import 'dart:ui';
import 'package:flutter/material.dart';
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
    }
  }

  final List<Widget> _pages = [
    const SignalScreen(),         // index 0
    const ChartScreen(),          // index 1
    const SignalHistoryScreen(),  // index 2
    const ProfileScreen(),        // index 3
  ];

  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
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
              child: _LiquidGlassNavBar(
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

class _LiquidGlassNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const _LiquidGlassNavBar({
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth - 48,
      height: 68,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withValues(alpha: 0.12),
                  Colors.white.withValues(alpha: 0.04),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                width: 1.5,
                color: Colors.white.withValues(alpha: 0.15),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(0, Icons.grid_view_rounded, 'Signals'),
                _buildNavItem(1, Icons.show_chart_rounded, 'Charts'),
                _buildNavItem(2, Icons.history_rounded, 'History'),
                _buildNavItem(3, Icons.person_rounded, 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 65,
        height: 68,
        color: Colors.transparent,
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.4),
          size: 26,
        ),
      ),
    );
  }
}
