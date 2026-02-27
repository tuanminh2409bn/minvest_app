import 'dart:ui';
import 'package:flutter/material.dart';

class LiquidGlassNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const LiquidGlassNavBar({
    super.key,
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
