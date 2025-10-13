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
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Danh sách trang không đổi
  static const List<Widget> _pages = <Widget>[
    SignalScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // ▼▼▼ BƯỚC 1: LẤY DỮ LIỆU TỪ PROVIDER ▼▼▼
    // Chúng ta đặt ở đây để cả hai hàm build layout đều có thể sử dụng
    final userRole = context.watch<UserProvider>().role;
    final unreadChatCount = context.watch<ChatProvider>().unreadRoomsCount;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 640) {
          // Truyền dữ liệu provider vào hàm build
          return _buildWideLayout(context, userRole, unreadChatCount);
        } else {
          // Truyền dữ liệu provider vào hàm build
          return _buildNarrowLayout(context, userRole, unreadChatCount);
        }
      },
    );
  }

  // Giao diện cho màn hình rộng (Web/Desktop)
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
              // Item Signal
              NavigationRailDestination(
                icon: const Icon(Icons.signal_cellular_alt),
                label: Text(l10n.tabSignal),
              ),
              // ▼▼▼ BƯỚC 2: CẬP NHẬT ITEM CHAT CHO NAVIGATION RAIL ▼▼▼
              NavigationRailDestination(
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Icons.chat_bubble_outline),
                    if (userRole == 'support' && unreadChatCount > 0)
                      Positioned(
                        top: -4,
                        right: -8,
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
              // Item Profile
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

  // Giao diện cho màn hình hẹp
  Widget _buildNarrowLayout(BuildContext context, String? userRole, int unreadChatCount) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          // Item Signal
          BottomNavigationBarItem(
            icon: const Icon(Icons.signal_cellular_alt),
            label: l10n.tabSignal,
          ),
          // ▼▼▼ BƯỚC 3: CẬP NHẬT ITEM CHAT CHO BOTTOM NAVIGATION BAR ▼▼▼
          BottomNavigationBarItem(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.chat_bubble_outline),
                if (userRole == 'support' && unreadChatCount > 0)
                  Positioned(
                    top: -4,
                    right: -8,
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
          // Item Profile
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