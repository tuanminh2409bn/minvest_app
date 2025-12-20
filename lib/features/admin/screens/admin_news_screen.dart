import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minvest_forex_app/features/news/models/news_model.dart';
import 'package:minvest_forex_app/features/news/services/news_service.dart';
import 'package:minvest_forex_app/features/admin/widgets/news_editor_dialog.dart';

class AdminNewsScreen extends StatefulWidget {
  const AdminNewsScreen({super.key});

  @override
  State<AdminNewsScreen> createState() => _AdminNewsScreenState();
}

class _AdminNewsScreenState extends State<AdminNewsScreen> {
  final NewsService _newsService = NewsService();

  void _openEditor({NewsArticle? article}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => NewsEditorDialog(
        article: article,
        onSubmit: (newArticle) async {
          if (article == null) {
            await _newsService.createNews(newArticle);
          } else {
            await _newsService.updateNews(newArticle);
          }
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(article == null ? 'Đã tạo bài viết' : 'Đã cập nhật bài viết')),
            );
          }
        },
      ),
    );
  }

  void _deleteArticle(String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: const Text('Bạn có chắc chắn muốn xóa bài viết này không?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Hủy')),
          FilledButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await _newsService.deleteNews(id);
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Đã xóa bài viết')),
                );
              }
            },
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý Tin tức'),
        actions: [
          FilledButton.icon(
            onPressed: () => _openEditor(),
            icon: const Icon(Icons.add),
            label: const Text('Thêm bài mới'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: StreamBuilder<List<NewsArticle>>(
        stream: _newsService.streamAllNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          }
          final articles = snapshot.data ?? [];
          if (articles.isEmpty) {
            return const Center(child: Text('Chưa có bài viết nào.'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: DataTable(
                columnSpacing: 20,
                horizontalMargin: 12,
                columns: const [
                  DataColumn(label: Text('Tiêu đề')),
                  DataColumn(label: Text('Danh mục')),
                  DataColumn(label: Text('Tác giả')),
                  DataColumn(label: Text('Ngày đăng')),
                  DataColumn(label: Text('Trạng thái')),
                  DataColumn(label: Text('Hành động')),
                ],
                rows: articles.map((article) {
                  final date = article.publishedAt != null
                      ? DateFormat('dd/MM/yyyy HH:mm').format(article.publishedAt!.toDate())
                      : 'N/A';
                  return DataRow(
                    cells: [
                      DataCell(
                        SizedBox(
                          width: 300,
                          child: Text(
                            article.title,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      DataCell(Text(article.category)),
                      DataCell(Text(article.author)),
                      DataCell(Text(date)),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: article.status == 'published'
                                ? Colors.green.withOpacity(0.2)
                                : Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: article.status == 'published' ? Colors.green : Colors.grey,
                            ),
                          ),
                          child: Text(
                            article.status.toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              color: article.status == 'published' ? Colors.green : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              tooltip: 'Sửa',
                              onPressed: () => _openEditor(article: article),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              tooltip: 'Xóa',
                              onPressed: () => _deleteArticle(article.id),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
