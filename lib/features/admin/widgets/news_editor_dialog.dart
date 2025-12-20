import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minvest_forex_app/features/news/models/news_model.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsEditorDialog extends StatefulWidget {
  final NewsArticle? article; // Null if creating new
  final Future<void> Function(NewsArticle article) onSubmit;

  const NewsEditorDialog({super.key, this.article, required this.onSubmit});

  @override
  State<NewsEditorDialog> createState() => _NewsEditorDialogState();
}

class _NewsEditorDialogState extends State<NewsEditorDialog> {
  final _titleCtrl = TextEditingController();
  final _subtitleCtrl = TextEditingController();
  final _thumbnailCtrl = TextEditingController();
  final _tagsCtrl = TextEditingController();
  final _authorCtrl = TextEditingController(text: 'Admin');
  
  late QuillController _quillController;
  
  String _category = 'News';
  bool _isFeatured = false;
  String _status = 'published';
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    if (widget.article != null) {
      final a = widget.article!;
      _titleCtrl.text = a.title;
      _subtitleCtrl.text = a.subtitle;
      _thumbnailCtrl.text = a.thumbnailUrl;
      _tagsCtrl.text = a.tags.join(', ');
      _authorCtrl.text = a.author;
      _category = a.category;
      _isFeatured = a.isFeatured;
      _status = a.status;
      
      _quillController = QuillController(
        document: _parseContent(a.content),
        selection: const TextSelection.collapsed(offset: 0),
      );
    } else {
      _quillController = QuillController.basic();
    }
  }

  Document _parseContent(String content) {
    try {
      final json = jsonDecode(content);
      return Document.fromJson(json);
    } catch (e) {
      // Fallback for plain text content
      return Document()..insert(0, content);
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _subtitleCtrl.dispose();
    _thumbnailCtrl.dispose();
    _tagsCtrl.dispose();
    _authorCtrl.dispose();
    _quillController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light().copyWith(
        textTheme: GoogleFonts.beVietnamProTextTheme(ThemeData.light().textTheme),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.black,
          selectionColor: Colors.black.withOpacity(0.12),
          selectionHandleColor: Colors.black,
        ),
      ),
      child: AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: Text(
          widget.article == null ? 'Tạo bài News' : 'Chỉnh sửa bài News',
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          width: 900,
          height: 700,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Side: Meta Data
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _input(_titleCtrl, 'Tiêu đề', maxLines: 2),
                      const SizedBox(height: 10),
                      _input(_subtitleCtrl, 'Mô tả ngắn', maxLines: 3),
                      const SizedBox(height: 10),
                      _input(_thumbnailCtrl, 'Thumbnail URL (hoặc để trống)'),
                      const SizedBox(height: 10),
                      _input(_authorCtrl, 'Tác giả'),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: _category,
                        dropdownColor: Colors.white,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          labelText: 'Danh mục',
                          labelStyle: TextStyle(color: Colors.black87),
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(value: 'News', child: Text('News')),
                          DropdownMenuItem(value: 'Investor', child: Text('Investor')),
                          DropdownMenuItem(value: 'Knowledge', child: Text('Knowledge')),
                          DropdownMenuItem(value: 'Technical Analysis', child: Text('Technical Analysis')),
                        ],
                        onChanged: (v) => setState(() => _category = v ?? 'News'),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: _status,
                        dropdownColor: Colors.white,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          labelText: 'Trạng thái',
                          labelStyle: TextStyle(color: Colors.black87),
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(value: 'published', child: Text('Published')),
                          DropdownMenuItem(value: 'draft', child: Text('Draft')),
                        ],
                        onChanged: (v) => setState(() => _status = v ?? 'published'),
                      ),
                      const SizedBox(height: 10),
                      CheckboxListTile(
                        value: _isFeatured,
                        onChanged: (v) => setState(() => _isFeatured = v ?? false),
                        title: const Text('Featured', style: TextStyle(color: Colors.black)),
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: Colors.black,
                        checkColor: Colors.white,
                      ),
                      _input(_tagsCtrl, 'Tags (phân tách bởi dấu phẩy)'),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              const VerticalDivider(width: 1, color: Colors.grey),
              const SizedBox(width: 20),
              // Right Side: Rich Text Editor
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Nội dung bài viết', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    QuillSimpleToolbar(
                      controller: _quillController,
                      config: QuillSimpleToolbarConfig(
                        showFontFamily: false,
                        showFontSize: false, 
                        showSearchButton: false,
                        showSubscript: false,
                        showSuperscript: false,
                        showCodeBlock: false,
                        showInlineCode: false,
                      ),
                    ),
                    const Divider(color: Colors.grey),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: QuillEditor.basic(
                          controller: _quillController,
                          config: QuillEditorConfig(
                            placeholder: 'Nhập nội dung bài viết...', 
                            embedBuilders: [
                              _ImageEmbedBuilder(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: _submitting ? null : () => Navigator.pop(context),
            child: const Text('Hủy', style: TextStyle(color: Colors.black54)),
          ),
          ElevatedButton(
            onPressed: _submitting ? null : _submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
            child: _submitting
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                : Text(widget.article == null ? 'Đăng bài' : 'Lưu thay đổi'),
          ),
        ],
      ),
    );
  }

  Widget _input(TextEditingController ctrl, String label, {int maxLines = 1}) {
    return TextField(
      controller: ctrl,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black87),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade400)),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 1.5)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
    );
  }

  Future<void> _submit() async {
    if (_titleCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tiêu đề không được để trống')));
      return;
    }
    
    setState(() => _submitting = true);

    // Convert Quill document to JSON string
    final contentJson = jsonEncode(_quillController.document.toDelta().toJson());

    final article = NewsArticle(
      id: widget.article?.id ?? '',
      title: _titleCtrl.text.trim(),
      subtitle: _subtitleCtrl.text.trim(),
      content: contentJson, // Storing JSON here
      thumbnailUrl: _thumbnailCtrl.text.trim(),
      category: _category,
      author: _authorCtrl.text.trim().isEmpty ? 'Admin' : _authorCtrl.text.trim(),
      tags: _tagsCtrl.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList(),
      isFeatured: _isFeatured,
      status: _status,
      publishedAt: widget.article?.publishedAt ?? Timestamp.now(),
    );

    try {
      await widget.onSubmit(article);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Lỗi: $e')));
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }
}

class _ImageEmbedBuilder extends EmbedBuilder {
  @override
  String get key => BlockEmbed.imageType;

  @override
  Widget build(BuildContext context, EmbedContext embedContext) {
    final String url = embedContext.node.value.data;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Image.network(
        url,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => Text('Lỗi tải ảnh: $url'),
      ),
    );
  }
}
