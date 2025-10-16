// lib/app/main_screen_web.dart

import 'package:flutter/material.dart';
import 'package:minvest_forex_app/core/providers/user_provider.dart';
import 'package:minvest_forex_app/features/auth/screens/profile_screen.dart';
import 'package:minvest_forex_app/features/chat/providers/chat_provider.dart';
import 'package:minvest_forex_app/features/signals/screens/signal_screen.dart';
import 'package:minvest_forex_app/features/chat/screens/chat_screen.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  // ▼▼▼ THAY ĐỔI 1: Đổi tên State để khớp với GlobalKey ▼▼▼
  State<MainScreen> createState() => MainScreenWebState();
}

// ▼▼▼ THAY ĐỔI 2: Đổi tên State thành public để GlobalKey có thể truy cập ▼▼▼
class MainScreenWebState extends State<MainScreen> {
  int _selectedIndex = 0;

  // ▼▼▼ THAY ĐỔI 3: Thêm hàm điều khiển từ bên ngoài ▼▼▼
  void switchToTab(int index) {
    if (mounted && index >= 0 && index < _pages.length) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  // Danh sách trang không đổi
  static const List<Widget> _pages = <Widget>[
    SignalScreen(),  // Index 0
    ChatScreen(),    // Index 1
    ProfileScreen(), // Index 2
  ];

  @override
  Widget build(BuildContext context) {
    final userRole = context.watch<UserProvider>().role;
    final unreadChatCount = context.watch<ChatProvider>().unreadRoomsCount;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 640) {
          return _buildWideLayout(context, userRole, unreadChatCount);
        } else {
          return _buildNarrowLayout(context, userRole, unreadChatCount);
        }
      },
    );
  }

  Widget _buildWideLayout(BuildContext context, String? userRole, int unreadChatCount) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Row(
        children: <Widget>[
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() { _selectedIndex = index; });
            },
            labelType: NavigationRailLabelType.all,
            backgroundColor: const Color(0xFF0D1117),
            indicatorColor: const Color(0xFF161B22),
            selectedIconTheme: const IconThemeData(color: Colors.white),
            unselectedIconTheme: IconThemeData(color: Colors.grey.shade600),
            selectedLabelTextStyle: const TextStyle(color: Colors.white),
            unselectedLabelTextStyle: TextStyle(color: Colors.grey.shade600),
            destinations: <NavigationRailDestination>[
              NavigationRailDestination(
                icon: const Icon(Icons.signal_cellular_alt),
                label: Text(l10n.tabSignal),
              ),
              NavigationRailDestination(
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Icons.chat_bubble_outline),
                    if (userRole == 'support' && unreadChatCount > 0)
                      Positioned(
                        top: -4, right: -8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                          constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                          child: Text(
                            '$unreadChatCount',
                            style: const TextStyle(color: Colors.white, fontSize: 10),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
                selectedIcon: const Icon(Icons.chat_bubble),
                label: Text(l10n.tabChat),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.person_outline),
                selectedIcon: const Icon(Icons.person),
                label: Text(l10n.tabProfile),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1, color: Colors.black),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: _pages,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNarrowLayout(BuildContext context, String? userRole, int unreadChatCount) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.signal_cellular_alt),
            label: l10n.tabSignal,
          ),
          BottomNavigationBarItem(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.chat_bubble_outline),
                if (userRole == 'support' && unreadChatCount > 0)
                  Positioned(
                    top: -4, right: -8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                      constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                      child: Text(
                        '$unreadChatCount',
                        style: const TextStyle(color: Colors.white, fontSize: 10),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            activeIcon: const Icon(Icons.chat_bubble),
            label: l10n.tabChat,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            activeIcon: const Icon(Icons.person),
            label: l10n.tabProfile,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() { _selectedIndex = index; });
        },
        backgroundColor: Colors.black.withOpacity(0.8),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.shade600,
        selectedFontSize: 12,
        unselectedFontSize: 12,
      ),
    );
  }
}