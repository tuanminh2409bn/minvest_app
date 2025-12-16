import 'dart:ui_web' as ui_web;
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

class OrbEffect extends StatefulWidget {
  const OrbEffect({super.key});

  @override
  State<OrbEffect> createState() => _OrbEffectState();
}

class _OrbEffectState extends State<OrbEffect> {
  // Tạo key duy nhất để tránh xung đột nếu dùng nhiều lần
  final String _viewId = 'orb-effect-view';

  @override
  void initState() {
    super.initState();
    // Đăng ký view factory một lần
    ui_web.platformViewRegistry.registerViewFactory(_viewId, (int viewId) {
      final iframe = web.document.createElement('iframe') as web.HTMLIFrameElement;
      iframe.src = 'orb_effect.html';
      iframe.style.border = 'none';
      iframe.style.width = '100%';
      iframe.style.height = '100%';
      iframe.style.backgroundColor = 'transparent';
      // QUAN TRỌNG: Cho phép click xuyên qua iframe
      iframe.style.pointerEvents = 'none'; 
      // Đặt ID để tìm và gửi message sau này
      iframe.id = 'orb-iframe'; 
      return iframe;
    });
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: _viewId);
  }
}
