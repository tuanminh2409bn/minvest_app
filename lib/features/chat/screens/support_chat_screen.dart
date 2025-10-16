//lib/features/chat/screens/support_chat_screen.dart

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minvest_forex_app/features/chat/models/chat_message_model.dart';
import 'package:minvest_forex_app/features/chat/models/chat_room_model.dart';
import 'package:minvest_forex_app/features/chat/models/chat_user_model.dart';
import 'package:minvest_forex_app/features/chat/services/chat_service.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';

class SupportChatScreen extends StatefulWidget {
  final String userId;
  final String userName;

  const SupportChatScreen({
    super.key,
    required this.userId,
    required this.userName,
  });

  @override
  State<SupportChatScreen> createState() => _SupportChatScreenState();
}

class _SupportChatScreenState extends State<SupportChatScreen> {
  final ChatService _chatService = ChatService();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  ChatUserModel? _chatUser;
  Timer? _typingTimer;
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _messageController.addListener(_onTyping);
  }

  @override
  void dispose() {
    _messageController.removeListener(_onTyping);
    _typingTimer?.cancel();
    super.dispose();
  }

  void _onTyping() {
    if (!_isTyping) {
      _isTyping = true;
      _chatService.updateTypingStatus(
        chatRoomId: widget.userId,
        typingUserId: 'support',
        isTyping: true,
      );
    }
    _typingTimer?.cancel();
    _typingTimer = Timer(const Duration(milliseconds: 1500), () {
      _isTyping = false;
      _chatService.updateTypingStatus(
        chatRoomId: widget.userId,
        typingUserId: 'support',
        isTyping: false,
      );
    });
  }

  Future<void> _loadUserData() async {
    final userDetails = await _chatService.getUserDetails(widget.userId);
    if (mounted) {
      setState(() {
        _chatUser = userDetails;
      });
    }
  }

  void _sendTextMessage() {
    final supportUser = FirebaseAuth.instance.currentUser;
    final l10n = AppLocalizations.of(context)!;
    if (_messageController.text.isNotEmpty && supportUser != null) {
      _chatService.sendTextMessage(
        userId: widget.userId,
        text: _messageController.text,
        senderId: supportUser.uid,
        senderName: supportUser.displayName ?? l10n.chatDefaultSupportName,
        isSentBySupport: true,
      );
      _messageController.clear();
      _typingTimer?.cancel();
      if (_isTyping) {
        _isTyping = false;
        _chatService.updateTypingStatus(
          chatRoomId: widget.userId,
          typingUserId: 'support',
          isTyping: false,
        );
      }
    }
  }

  void _sendImageMessage() {
    _chatService.pickAndSendImage(
      chatRoomId: widget.userId,
      isSentBySupport: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final supportUser = FirebaseAuth.instance.currentUser;
    final l10n = AppLocalizations.of(context)!;
    if (supportUser == null) return const Scaffold();

    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.userName),
            if (_chatUser != null)
              Text(
                _chatUser!.subscriptionTier.toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<ChatMessage>>(
              stream: _chatService.getMessagesStream(widget.userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text(l10n.chatNoMessages));
                }

                final messages = snapshot.data!;
                return ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  itemCount: messages.length,
                  padding: const EdgeInsets.all(16.0),
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isMyMessage = message.senderId == supportUser.uid;
                    return _buildMessageBubble(message, isMyMessage);
                  },
                );
              },
            ),
          ),
          StreamBuilder<ChatRoom?>(
            stream: _chatService.getChatRoomStream(widget.userId),
            builder: (context, snapshot) {
              final isUserTyping = snapshot.data?.isUserTyping ?? false;
              if (isUserTyping) {
                return _TypingIndicator(text: l10n.chatUserIsTyping(widget.userName));
              }
              return const SizedBox.shrink();
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