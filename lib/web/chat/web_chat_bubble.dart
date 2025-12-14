import 'package:flutter/material.dart';
import 'package:minvest_forex_app/web/chat/web_chat_content_widget.dart';

class WebChatBubble extends StatefulWidget {
  const WebChatBubble({super.key});

  @override
  State<WebChatBubble> createState() => _WebChatBubbleState();
}

class _WebChatBubbleState extends State<WebChatBubble> with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleChat() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Sử dụng Stack để popup nằm đè lên trên và căn chỉnh vị trí
    // Tuy nhiên, widget này dự kiến sẽ được đặt trong một Stack lớn của trang
    // hoặc dùng làm FloatingActionButton.
    // Để đảm bảo vị trí, chúng ta dùng Align hoặc Positioned nếu cha là Stack.
    // Ở đây tôi giả định widget này được đặt ở góc màn hình thông qua Stack cha.
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Cửa sổ Chat
        if (_isOpen || _animationController.isAnimating)
          ScaleTransition(
            scale: _scaleAnimation,
            alignment: Alignment.bottomRight,
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: Container(
                width: 320,
                height: 450,
                margin: const EdgeInsets.only(bottom: 16, right: 4), // Cách nút một chút
                decoration: BoxDecoration(
                  color: const Color(0xFF0D1117), // Nền tối khớp với theme
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                  border: Border.all(
                    color: const Color(0xFF30363D),
                    width: 1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Column(
                    children: [
                      // Header của popup
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        color: const Color(0xFF161B22),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 4,
                              backgroundColor: Colors.green, // Online indicator
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Minvest Support',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: _toggleChat,
                              child: const Icon(Icons.close, size: 20, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 1, color: Color(0xFF30363D)),
                      // Nội dung Chat
                      const Expanded(
                        child: WebChatContentWidget(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        
        // Nút Icon Chat
        FloatingActionButton(
          onPressed: _toggleChat,
          backgroundColor: const Color(0xFF3C4BFE), // Màu thương hiệu
          child: Icon(
            _isOpen ? Icons.keyboard_arrow_down : Icons.chat_bubble_outline,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
