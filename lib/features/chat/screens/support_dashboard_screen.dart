import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minvest_forex_app/features/chat/models/chat_room_model.dart';
import 'package:minvest_forex_app/features/chat/screens/support_chat_screen.dart';
import 'package:minvest_forex_app/features/chat/services/chat_service.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';

class SupportDashboardScreen extends StatefulWidget {
  const SupportDashboardScreen({super.key});

  @override
  State<SupportDashboardScreen> createState() => _SupportDashboardScreenState();
}

class _SupportDashboardScreenState extends State<SupportDashboardScreen> {
  final ChatService _chatService = ChatService();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final supportUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        title: Text(l10n.tabChat),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<List<ChatRoom>>(
        stream: _chatService.getChatRoomsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Chưa có cuộc trò chuyện nào',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          final chatRooms = snapshot.data!;

          return ListView.builder(
            itemCount: chatRooms.length,
            itemBuilder: (context, index) {
              final room = chatRooms[index];
              return _buildChatRoomTile(room, supportUser?.uid);
            },
          );
        },
      ),
    );
  }

  Widget _buildChatRoomTile(ChatRoom room, String? currentSupportId) {
    final String formattedTime =
    DateFormat('HH:mm dd/MM').format(room.lastMessageTimestamp.toDate());

    // Logic xác định người gửi cuối cùng
    final bool isLastMessageFromSupport = room.lastMessageSenderId == currentSupportId;

    // Xây dựng chuỗi tin nhắn hiển thị
    String subtitleText = room.lastMessageText;
    if (isLastMessageFromSupport) {
      subtitleText = 'Bạn: $subtitleText';
    }

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blueGrey,
        child: Text(
          room.userName.isNotEmpty ? room.userName[0].toUpperCase() : 'U',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      // Luôn hiển thị tên người dùng
      title: Text(
        room.userName,
        style: TextStyle(
          fontWeight: !room.isReadBySupport ? FontWeight.bold : FontWeight.normal,
          color: Colors.white,
        ),
      ),
      // Hiển thị tin nhắn cuối cùng với tiền tố "Bạn:" nếu cần
      subtitle: Text(
        subtitleText,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: !room.isReadBySupport ? Colors.white70 : Colors.grey,
        ),
      ),
      trailing: Text(
        formattedTime,
        style: const TextStyle(color: Colors.grey, fontSize: 12),
      ),
      onTap: () {
        if (!room.isReadBySupport) {
          _chatService.markAsReadBySupport(room.userId);
        }
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SupportChatScreen(
              userId: room.userId,
              userName: room.userName,
            ),
          ),
        );
      },
    );
  }
}