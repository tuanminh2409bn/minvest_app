// lib/features/chat/screens/chat_screen.dart

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minvest_forex_app/core/providers/user_provider.dart';
import 'package:minvest_forex_app/features/chat/models/chat_message_model.dart';
import 'package:minvest_forex_app/features/chat/models/chat_room_model.dart';
import 'package:minvest_forex_app/features/chat/screens/support_dashboard_screen.dart';
import 'package:minvest_forex_app/features/chat/services/chat_service.dart';
import 'package:provider/provider.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  final ChatService _chatService = ChatService();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  Timer? _typingTimer;
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _messageController.addListener(_onTyping);
    WidgetsBinding.instance.addObserver(this);
    _markAsReadIfVisible();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _markAsReadIfVisible();
    }
  }

  void _markAsReadIfVisible() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _chatService.markAsReadByUser(user.uid);
    }
  }

  @override
  void dispose() {
    _messageController.removeListener(_onTyping);
    _typingTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _onTyping() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    if (!_isTyping) {
      _isTyping = true;
      _chatService.updateTypingStatus(
        chatRoomId: user.uid,
        typingUserId: user.uid,
        isTyping: true,
      );
    }

    _typingTimer?.cancel();
    _typingTimer = Timer(const Duration(milliseconds: 1500), () {
      _isTyping = false;
      _chatService.updateTypingStatus(
        chatRoomId: user.uid,
        typingUserId: user.uid,
        isTyping: false,
      );
    });
  }

  void _sendTextMessage() {
    final user = FirebaseAuth.instance.currentUser;
    final l10n = AppLocalizations.of(context)!;
    if (_messageController.text.isNotEmpty && user != null) {
      _chatService.sendTextMessage(
        userId: user.uid,
        text: _messageController.text,
        senderId: user.uid,
        senderName: user.displayName ?? l10n.chatDefaultUserName,
        isSentBySupport: false,
      );
      _messageController.clear();
      _typingTimer?.cancel();
      if (_isTyping) {
        _isTyping = false;
        _chatService.updateTypingStatus(
          chatRoomId: user.uid,
          typingUserId: user.uid,
          isTyping: false,
        );
      }
    }
  }

  void _sendImageMessage() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    _chatService.pickAndSendImage(
      chatRoomId: user.uid,
      isSentBySupport: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final user = FirebaseAuth.instance.currentUser;
    final userRole = context.watch<UserProvider>().role;

    if (user == null) {
      return Center(
        child: Text(
          l10n.chatLoginPrompt,
          style: TextStyle(color: Colors.grey[400]),
        ),
      );
    }

    if (userRole == 'support') {
      return const SupportDashboardScreen();
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        title: Text(l10n.tabChat),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          const _WelcomeHeader(),
          Expanded(
            child: StreamBuilder<List<ChatMessage>>(
              stream: _chatService.getMessagesStream(user.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                // Logic cũ hiển thị "Bắt đầu cuộc trò chuyện" nếu không có tin nhắn sẽ bị ẩn
                // bởi lời chào mừng, điều này là hợp lý.
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  // Trả về một widget trống vì lời chào đã hiển thị rồi
                  return const SizedBox.shrink();
                }

                final messages = snapshot.data!;
                return ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  itemCount: messages.length,
                  padding: const EdgeInsets.all(16.0),
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isMyMessage = message.senderId == user.uid;
                    return _buildMessageBubble(message, isMyMessage);
                  },
                );
              },
            ),
          ),
          StreamBuilder<ChatRoom?>(
            stream: _chatService.getChatRoomStream(user.uid),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return const SizedBox.shrink();
              }
              final room = snapshot.data!;
              final isSupportTyping = room.isSupportTyping;
              final isMyLastMessage = room.lastMessageSenderId == user.uid;
              final isSeenBySupport = room.isReadBySupport;

              Widget statusWidget = const SizedBox.shrink();
              if (isSupportTyping) {
                statusWidget = _TypingIndicator(text: l10n.chatSupportIsTyping);
              } else if (isMyLastMessage && isSeenBySupport) {
                statusWidget = _SeenIndicator(text: l10n.chatSeen);
              }

              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: statusWidget,
              );
            },
          ),
          _buildMessageComposer(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message, bool isMyMessage) {
    final alignment = isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final color = isMyMessage ? Colors.blue.shade700 : const Color(0xFF2A2D3A);

    Widget messageContent;
    if (message.type == MessageType.image && message.imageUrl != null) {
      messageContent = ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          message.imageUrl!,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.error, color: Colors.red);
          },
        ),
      );
    } else {
      messageContent = Text(
        message.text ?? '',
        style: const TextStyle(color: Colors.white, fontSize: 16),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            padding: message.type == MessageType.image
                ? const EdgeInsets.all(4)
                : const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(16),
            ),
            child: messageContent,
          ),
        ],
      ),
    );
  }

  Widget _buildMessageComposer() {
    final l10n = AppLocalizations.of(context)!;
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        color: const Color(0xFF161B22),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.attach_file, color: Colors.grey),
              onPressed: _sendImageMessage,
            ),
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: l10n.chatTypeMessage,
                  filled: true,
                  fillColor: const Color(0xFF2A2D3A),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                onSubmitted: (_) => _sendTextMessage(),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.send, color: Colors.blueAccent),
              onPressed: _sendTextMessage,
            ),
          ],
        ),
      ),
    );
  }
}

class _WelcomeHeader extends StatelessWidget {
  const _WelcomeHeader();

  @override
  Widget build(BuildContext context) {
    // Lấy instance của AppLocalizations để truy cập các chuỗi đa ngôn ngữ
    final l10n = AppLocalizations.of(context)!;

    final defaultTextStyle = TextStyle(
      color: Colors.white.withOpacity(0.8),
      fontSize: 14,
      height: 1.5, // Giãn dòng cho dễ đọc
    );
    final boldTextStyle = defaultTextStyle.copyWith(fontWeight: FontWeight.bold);

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
      width: double.infinity,
      color: const Color(0xFF161B22), // Màu nền hơi khác một chút
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: defaultTextStyle,
          children: [
            // Sử dụng các key từ file ngôn ngữ thay vì văn bản cố định
            TextSpan(text: "${l10n.chatWelcomeTitle}\n"),
            TextSpan(text: "${l10n.chatWelcomeBody1}\n"),
            TextSpan(text: l10n.chatWelcomeBody2),
            TextSpan(
              text: "0969.15.6969",
              style: boldTextStyle,
            ),
            TextSpan(text: l10n.chatWelcomeBody3),
          ],
        ),
      ),
    );
  }
}

class _TypingIndicator extends StatelessWidget {
  final String text;
  const _TypingIndicator({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2D3A),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SeenIndicator extends StatelessWidget {
  final String text;
  const _SeenIndicator({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            text,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}