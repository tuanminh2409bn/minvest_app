import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minvest_forex_app/features/news/models/news_model.dart';

class NewsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<NewsArticle>> streamNews({
    String? category,
    int limit = 20,
    bool featuredOnly = false,
  }) {
    Query<Map<String, dynamic>> query =
        _firestore.collection('news').where('status', isEqualTo: 'published');

    if (category != null && category.isNotEmpty) {
      query = query.where('category', isEqualTo: category);
    }
    if (featuredOnly) {
      query = query.where('isFeatured', isEqualTo: true);
    }

    query = query.orderBy('publishedAt', descending: true).limit(limit);

    return query.snapshots().map(
      (snap) => snap.docs.map((doc) => NewsArticle.fromFirestore(doc)).toList(),
    );
  }

  Future<String?> createNews(NewsArticle article) async {
    try {
      final docRef = await _firestore.collection('news').add(article.toJson());
      return docRef.id;
    } catch (e) {
      print("Lỗi createNews: $e"); // Debug error
      return null;
    }
  }

  Future<void> updateNews(NewsArticle article) async {
    try {
      await _firestore.collection('news').doc(article.id).update(article.toJson());
    } catch (e) {
      print("Lỗi updateNews: $e");
      rethrow;
    }
  }

  Future<void> deleteNews(String id) async {
    try {
      await _firestore.collection('news').doc(id).delete();
    } catch (e) {
      print("Lỗi deleteNews: $e");
      rethrow;
    }
  }

  // Admin Stream: Get all news including drafts, ordered by date
  Stream<List<NewsArticle>> streamAllNews() {
    return _firestore
        .collection('news')
        .orderBy('publishedAt', descending: true)
        .snapshots()
        .map((snap) =>
            snap.docs.map((doc) => NewsArticle.fromFirestore(doc)).toList());
  }
}
