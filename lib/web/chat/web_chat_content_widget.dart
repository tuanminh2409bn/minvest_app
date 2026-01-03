import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:minvest_forex_app/features/chat/models/chat_message_model.dart';
import 'package:minvest_forex_app/features/chat/models/chat_room_model.dart';
import 'package:minvest_forex_app/features/chat/services/chat_service.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

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
  
  // Support Logic
  bool _isSupport = false;
  String? _selectedChatRoomId;

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser;
    _checkUserRole();

    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (mounted) {
        setState(() {
          _currentUser = user;
        });
        if (user != null) {
          _checkUserRole();
        } else {
          setState(() {
            _isSupport = false;
            _selectedChatRoomId = null;
          });
        }
      }
    });

    _messageController.addListener(_onTyping);
  }

  Future<void> _checkUserRole() async {
    if (_currentUser == null) return;
    try {
      final doc = await FirebaseFirestore.instance.collection('users').doc(_currentUser!.uid).get();
      final role = doc.data()?['role'];
      if (mounted) {
        setState(() {
          // Chỉ role 'support' mới được quản lý chat
          _isSupport = role == 'support';
          // Nếu là user thường (hoặc admin), luôn mark as read phòng của chính mình
          if (!_isSupport) {
            _markAsReadIfVisible(_currentUser!.uid);
          }
        });
      }
    } catch (e) {
      print('Error checking role: $e');
    }
  }

  void _markAsReadIfVisible(String uid) {
    if (_isSupport) {
      _chatService.markAsReadBySupport(uid);
    } else {
      _chatService.markAsReadByUser(uid);
    }
  }

  @override
  void dispose() {
    _messageController.removeListener(_onTyping);
    _typingTimer?.cancel();
    super.dispose();
  }

  void _onTyping() {
    if (_currentUser == null) return;
    // Nếu là support thì roomId là phòng đang chọn, nếu user thì là uid của mình
    final roomId = _isSupport ? _selectedChatRoomId : _currentUser!.uid;
    if (roomId == null) return;

    if (!_isTyping) {
      _isTyping = true;
      _chatService.updateTypingStatus(
        chatRoomId: roomId,
        typingUserId: _currentUser!.uid,
        isTyping: true,
      );
    }

    _typingTimer?.cancel();
    _typingTimer = Timer(const Duration(milliseconds: 1500), () {
      if (mounted && _currentUser != null) {
        _isTyping = false;
        _chatService.updateTypingStatus(
          chatRoomId: roomId,
          typingUserId: _currentUser!.uid,
          isTyping: false,
        );
      }
    });
  }

  void _sendTextMessage() {
    if (_currentUser == null) return;
    final roomId = _isSupport ? _selectedChatRoomId : _currentUser!.uid;
    if (roomId == null) return;

    final l10n = AppLocalizations.of(context)!;

    if (_messageController.text.isNotEmpty) {
      _chatService.sendTextMessage(
        userId: roomId,
        text: _messageController.text,
        senderId: _currentUser!.uid,
        senderName: _currentUser!.displayName ?? (_isSupport ? l10n.chatDefaultSupportName : l10n.chatDefaultUserName),
        isSentBySupport: _isSupport,
      );
      _messageController.clear();
      _typingTimer?.cancel();
      if (_isTyping) {
        _isTyping = false;
        _chatService.updateTypingStatus(
          chatRoomId: roomId,
          typingUserId: _currentUser!.uid,
          isTyping: false,
        );
      }
    }
  }

  void _sendImageMessage() {
    if (_currentUser == null) return;
    final roomId = _isSupport ? _selectedChatRoomId : _currentUser!.uid;
    if (roomId == null) return;

    _chatService.pickAndSendImage(
      chatRoomId: roomId,
      isSentBySupport: _isSupport,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (_currentUser == null) {
      return _buildLoginPrompt(l10n);
    }

    // Nếu là Support và CHƯA chọn phòng chat -> Hiển thị danh sách
    if (_isSupport && _selectedChatRoomId == null) {
      return _buildChatRoomList(l10n);
    }

    // Ngược lại (User thường HOẶC Support đã chọn phòng) -> Hiển thị khung chat
    return _buildChatInterface(l10n);
  }

  Widget _buildChatRoomList(AppLocalizations l10n) {
    return StreamBuilder<List<ChatRoom>>(
      stream: _chatService.getChatRoomsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final rooms = snapshot.data ?? [];
        if (rooms.isEmpty) {
          return Center(
            child: Text(
              "Chưa có tin nhắn nào",
              style: TextStyle(color: Colors.white.withOpacity(0.5)),
            ),
          );
        }

        return ListView.separated(
          itemCount: rooms.length,
          separatorBuilder: (ctx, i) => const Divider(height: 1, color: Color(0xFF30363D)),
          itemBuilder: (context, index) {
            final room = rooms[index];
            final isUnread = !room.isReadBySupport;
            final time = room.lastMessageTimestamp != null 
                ? _formatTime(room.lastMessageTimestamp!.toDate()) 
                : '';

            return ListTile(
              tileColor: isUnread ? const Color(0xFF1C2128) : Colors.transparent,
              leading: CircleAvatar(
                backgroundColor: const Color(0xFF3C4BFE),
                child: Text(
                  (room.userName ?? 'U').substring(0, 1).toUpperCase(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(
                room.userName ?? 'User ${room.userId.substring(0, 5)}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14,
                ),
                maxLines: 1, overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                room.lastMessageText ?? '',
                style: TextStyle(
                  color: isUnread ? Colors.white70 : Colors.grey,
                  fontWeight: isUnread ? FontWeight.w500 : FontWeight.normal,
                  fontSize: 12,
                ),
                maxLines: 1, overflow: TextOverflow.ellipsis,
              ),
              trailing: Text(
                time,
                style: const TextStyle(color: Colors.grey, fontSize: 10),
              ),
              onTap: () {
                setState(() {
                  _selectedChatRoomId = room.userId;
                });
                _markAsReadIfVisible(room.userId);
              },
            );
          },
        );
      },
    );
  }

  String _formatTime(DateTime date) {
    final now = DateTime.now();
    if (now.difference(date).inDays > 0) {
      return '${date.day}/${date.month}';
    }
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  Widget _buildChatInterface(AppLocalizations l10n) {
    // Xác định ID phòng chat: Nếu là support thì lấy phòng đang chọn, user thì lấy chính mình
    final roomId = _isSupport ? _selectedChatRoomId! : _currentUser!.uid;

    return Column(
      children: [
        // Header phụ cho Support để back về danh sách
        if (_isSupport)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            color: const Color(0xFF161B22),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                  onPressed: () => setState(() => _selectedChatRoomId = null),
                ),
                const SizedBox(width: 4),
                const Text(
                  "Danh sách tin nhắn",
                  style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

        Expanded(
          child: StreamBuilder<List<ChatMessage>>(
            stream: _chatService.getMessagesStream(roomId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final messages = snapshot.data ?? [];
              
              return ListView.builder(
                controller: _scrollController,
                reverse: true,
                itemCount: messages.length + 1, // +1 cho header
                padding: const EdgeInsets.all(12.0),
                itemBuilder: (context, index) {
                  if (index == messages.length) {
                    // Chỉ hiện Welcome Header cho User, Support không cần thiết lắm hoặc có thể custom
                    return _isSupport ? const SizedBox(height: 20) : const _WebWelcomeHeader();
                  }
                  final message = messages[index];
                  // Logic hiển thị tin nhắn của "tôi"
                  final isMyMessage = message.senderId == _currentUser!.uid;
                  return _buildMessageBubble(message, isMyMessage);
                },
              );
            },
          ),
        ),
        _buildTypingIndicator(l10n, roomId),
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

  Widget _buildTypingIndicator(AppLocalizations l10n, String roomId) {
    return StreamBuilder<ChatRoom?>(
      stream: _chatService.getChatRoomStream(roomId),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return const SizedBox.shrink();
        }
        final room = snapshot.data!;
        
        // Logic hiển thị:
        // - Nếu mình là User: xem support có gõ không (isSupportTyping)
        // - Nếu mình là Support: xem user có gõ không (isUserTyping - cần thêm field này vào model nếu chưa có, hoặc dùng logic typingStatus map)
        
        // Tuy nhiên ChatService hiện tại dùng map `typingStatus`.
        // Cần kiểm tra kỹ model. Giả sử model ChatRoom có getter helper.
        // Tạm thời dùng logic đơn giản:
        // Nếu là Support -> Check xem User có đang gõ không?
        // Nếu là User -> Check xem Support có đang gõ không?

        bool isOtherTyping = false;
        if (_isSupport) {
           // Check user typing (User ID là roomId)
           isOtherTyping = room.typingStatus?[roomId] == true;
        } else {
           // Check support typing (Tìm bất kỳ key nào khác mình đang true? Hoặc quy ước support ID?)
           // Đơn giản hóa: Web chat thường support dùng tool riêng, hoặc ở đây ta check map
           // Giả sử support có ID cố định hoặc check bất kỳ ai khác mình.
           room.typingStatus?.forEach((key, value) {
             if (key != _currentUser!.uid && value == true) isOtherTyping = true;
           });
        }
        
        if (isOtherTyping) {
          return Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _isSupport ? "${room.userName} đang gõ..." : l10n.chatSupportIsTyping,
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
              style: const TextStyle(fontSize: 14, color: Colors.white), // Thêm color white để dễ nhìn nền tối
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
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'BeVietnamPro'),
              children: [
                TextSpan(text: l10n.leaveMessagePart1),
                TextSpan(
                  text: l10n.chatWhatsApp,
                  style: const TextStyle(
                    color: Color(0xFF3C4BFE),
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      final uri = Uri.parse('https://wa.me/84969156969');
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      }
                    },
                ),
                TextSpan(text: l10n.leaveMessagePart2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
