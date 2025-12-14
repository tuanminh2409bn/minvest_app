import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minvest_forex_app/features/chat/models/chat_message_model.dart';
import 'package:minvest_forex_app/features/chat/models/chat_room_model.dart';
import 'package:minvest_forex_app/features/chat/services/chat_service.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';

class WebChatContentWidget extends StatefulWidget {
  const WebChatContentWidget({super.key});

  @override
  State<WebChatContentWidget> createState() => _WebChatContentWidgetState();
}

class _WebChatContentWidgetState extends State<WebChatContentWidget> {
  final ChatService _chatService = ChatService();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  Timer? _typingTimer;
  bool _isTyping = false;
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser;
    // Lắng nghe thay đổi trạng thái đăng nhập
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (mounted) {
        setState(() {
          _currentUser = user;
        });
        if (user != null) {
          _markAsReadIfVisible(user.uid);
        }
      }
    });

    _messageController.addListener(_onTyping);
    if (_currentUser != null) {
      _markAsReadIfVisible(_currentUser!.uid);
    }
  }

  void _markAsReadIfVisible(String uid) {
    _chatService.markAsReadByUser(uid);
  }

  @override
  void dispose() {
    _messageController.removeListener(_onTyping);
    _typingTimer?.cancel();
    super.dispose();
  }

  void _onTyping() {
    if (_currentUser == null) return;
    final uid = _currentUser!.uid;

    if (!_isTyping) {
      _isTyping = true;
      _chatService.updateTypingStatus(
        chatRoomId: uid,
        typingUserId: uid,
        isTyping: true,
      );
    }

    _typingTimer?.cancel();
    _typingTimer = Timer(const Duration(milliseconds: 1500), () {
      if (mounted && _currentUser != null) {
        _isTyping = false;
        _chatService.updateTypingStatus(
          chatRoomId: uid,
          typingUserId: uid,
          isTyping: false,
        );
      }
    });
  }

  void _sendTextMessage() {
    if (_currentUser == null) return;
    final uid = _currentUser!.uid;
    final l10n = AppLocalizations.of(context)!;

    if (_messageController.text.isNotEmpty) {
      _chatService.sendTextMessage(
        userId: uid,
        text: _messageController.text,
        senderId: uid,
        senderName: _currentUser!.displayName ?? l10n.chatDefaultUserName,
        isSentBySupport: false,
      );
      _messageController.clear();
      _typingTimer?.cancel();
      if (_isTyping) {
        _isTyping = false;
        _chatService.updateTypingStatus(
          chatRoomId: uid,
          typingUserId: uid,
          isTyping: false,
        );
      }
    }
  }

  void _sendImageMessage() {
    if (_currentUser == null) return;
    _chatService.pickAndSendImage(
      chatRoomId: _currentUser!.uid,
      isSentBySupport: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (_currentUser == null) {
      return _buildLoginPrompt(l10n);
    }

    return Column(
      children: [
        Expanded(
          child: StreamBuilder<List<ChatMessage>>(
            stream: _chatService.getMessagesStream(_currentUser!.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final messages = snapshot.data ?? [];
              
              // Luôn hiển thị Welcome Header ở đầu list (cuối danh sách vì reverse: true)
              return ListView.builder(
                controller: _scrollController,
                reverse: true,
                itemCount: messages.length + 1, // +1 cho header
                padding: const EdgeInsets.all(12.0),
                itemBuilder: (context, index) {
                  if (index == messages.length) {
                    return const _WebWelcomeHeader();
                  }
                  final message = messages[index];
                  final isMyMessage = message.senderId == _currentUser!.uid;
                  return _buildMessageBubble(message, isMyMessage);
                },
              );
            },
          ),
        ),
        _buildTypingIndicator(l10n),
        _buildMessageComposer(l10n),
      ],
    );
  }

  Widget _buildLoginPrompt(AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.chat_bubble_outline, size: 48, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              l10n.chatLoginPrompt,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/signin');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3C4BFE),
                foregroundColor: Colors.white,
              ),
              child: Text(l10n.signIn),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypingIndicator(AppLocalizations l10n) {
    return StreamBuilder<ChatRoom?>(
      stream: _chatService.getChatRoomStream(_currentUser!.uid),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return const SizedBox.shrink();
        }
        final room = snapshot.data!;
        
        if (room.isSupportTyping) {
          return Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                l10n.chatSupportIsTyping,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildMessageBubble(ChatMessage message, bool isMyMessage) {
    final alignment = isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final bgColor = isMyMessage ? const Color(0xFF3C4BFE) : const Color(0xFF2A2D3A);
    final textColor = Colors.white;

    Widget messageContent;
    if (message.type == MessageType.image && message.imageUrl != null) {
      messageContent = ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          message.imageUrl!,
          fit: BoxFit.cover,
          width: 150,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const SizedBox(
              width: 150, 
              height: 100, 
              child: Center(child: CircularProgressIndicator(strokeWidth: 2))
            );
          },
          errorBuilder: (_, __, ___) => const Icon(Icons.error, color: Colors.red),
        ),
      );
    } else {
      messageContent = Text(
        message.text ?? '',
        style: TextStyle(color: textColor, fontSize: 14),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 240),
            padding: message.type == MessageType.image
                ? const EdgeInsets.all(4)
                : const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12),
                topRight: const Radius.circular(12),
                bottomLeft: isMyMessage ? const Radius.circular(12) : const Radius.circular(2),
                bottomRight: isMyMessage ? const Radius.circular(2) : const Radius.circular(12),
              ),
            ),
            child: messageContent,
          ),
          // Có thể thêm "Seen" indicator ở đây nếu cần, nhưng cho popup nhỏ thì có thể bỏ qua cho gọn
        ],
      ),
    );
  }

  Widget _buildMessageComposer(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Color(0xFF161B22),
        border: Border(top: BorderSide(color: Color(0xFF30363D))),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.image_outlined, color: Colors.grey, size: 20),
            onPressed: _sendImageMessage,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _messageController,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: l10n.chatTypeMessage,
                hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFF0D1117),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: (_) => _sendTextMessage(),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.send, color: Color(0xFF3C4BFE), size: 20),
            onPressed: _sendTextMessage,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}

class _WebWelcomeHeader extends StatelessWidget {
  const _WebWelcomeHeader();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF30363D)),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xFF3C4BFE),
            radius: 20,
            child: Icon(Icons.support_agent, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.chatWelcomeTitle,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            l10n.chatWelcomeBody1,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
