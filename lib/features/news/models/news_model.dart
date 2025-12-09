import 'package:cloud_firestore/cloud_firestore.dart';

class NewsArticle {
  final String id;
  final String title;
  final String subtitle;
  final String content;
  final String thumbnailUrl;
  final String category;
  final String author;
  final List<String> tags;
  final bool isFeatured;
  final String status; // published / draft
  final Timestamp? publishedAt;

  NewsArticle({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.content,
    required this.thumbnailUrl,
    required this.category,
    required this.author,
    required this.tags,
    required this.isFeatured,
    required this.status,
    required this.publishedAt,
  });

  factory NewsArticle.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return NewsArticle(
      id: doc.id,
      title: data['title'] ?? '',
      subtitle: data['subtitle'] ?? data['excerpt'] ?? '',
      content: data['content'] ?? '',
      thumbnailUrl: data['thumbnailUrl'] ?? '',
      category: data['category'] ?? 'News',
      author: data['author'] ?? 'Admin',
      tags: List<String>.from(data['tags'] ?? const []),
      isFeatured: data['isFeatured'] ?? false,
      status: data['status'] ?? 'draft',
      publishedAt: data['publishedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'content': content,
      'thumbnailUrl': thumbnailUrl,
      'category': category,
      'author': author,
      'tags': tags,
      'isFeatured': isFeatured,
      'status': status,
      'publishedAt': publishedAt ?? FieldValue.serverTimestamp(),
    };
  }

  NewsArticle copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? content,
    String? thumbnailUrl,
    String? category,
    String? author,
    List<String>? tags,
    bool? isFeatured,
    String? status,
    Timestamp? publishedAt,
  }) {
    return NewsArticle(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      content: content ?? this.content,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      category: category ?? this.category,
      author: author ?? this.author,
      tags: tags ?? this.tags,
      isFeatured: isFeatured ?? this.isFeatured,
      status: status ?? this.status,
      publishedAt: publishedAt ?? this.publishedAt,
    );
  }
}
