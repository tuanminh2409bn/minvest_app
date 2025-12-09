import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:minvest_forex_app/features/news/models/news_model.dart';
import 'package:minvest_forex_app/features/news/services/news_service.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import 'widgets/navbar.dart';
import 'sections/footer_section.dart';
import 'news_detail_screen.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final NewsService _newsService = NewsService();
  final List<String> _tabs = const ['All Articles', 'Investor', 'Knowledge', 'Technical Analysis'];
  String _selectedTab = 'All Articles';

  String? get _categoryFilter => _selectedTab == 'All Articles' ? null : _selectedTab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 12),
                  const LandingNavBar(),
                  const SizedBox(height: 32),
                  _header(),
                  const SizedBox(height: 24),
                  _categoryTabs(),
                  const SizedBox(height: 12),
                  const Divider(color: Colors.white12, height: 1),
                  const SizedBox(height: 24),
                  StreamBuilder<List<NewsArticle>>(
                    stream: _newsService.streamNews(category: _categoryFilter, limit: 20),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final articles = snapshot.data ?? [];
                      return _NewsLayout(
                        articles: articles,
                        selectedCategory: _selectedTab,
                      );
                    },
                  ),
                  const SizedBox(height: 64),
                  const FooterSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Column(
      children: [
        Text(
          'Financial News Hub',
          style: AppTextStyles.h1.copyWith(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Critical updates. Market reactions. No noise – just what investors need to know.',
          style: AppTextStyles.body.copyWith(color: AppColors.textSecondary, fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _categoryTabs() {
    return Wrap(
      spacing: 20,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: _tabs.map((t) {
        final isActive = t == _selectedTab;
        return InkWell(
          onTap: () => setState(() => _selectedTab = t),
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: Text(
              t,
              style: AppTextStyles.body.copyWith(
                color: isActive ? const Color(0xFF3FA9F5) : Colors.white,
                fontSize: 14,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _NewsLayout extends StatelessWidget {
  final List<NewsArticle> articles;
  final String selectedCategory;
  const _NewsLayout({required this.articles, required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    if (articles.isEmpty) {
      return Column(
        children: [
          Text(
            'Chưa có bài viết cho mục $selectedCategory',
            style: AppTextStyles.body.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 24),
        ],
      );
    }

    NewsArticle mainArticle = articles.first;
    final featured = articles.where((a) => a.isFeatured).toList();
    if (featured.isNotEmpty) {
      mainArticle = featured.first;
    }
    final sideArticles = articles.where((a) => a.id != mainArticle.id).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool stacked = constraints.maxWidth < 960;
        final double rightColumnWidth = stacked ? constraints.maxWidth : 520;
        final double leftColumnWidth = stacked ? constraints.maxWidth : constraints.maxWidth - rightColumnWidth - 16;
        if (stacked) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _FeaturedArticleCard(article: mainArticle),
              const SizedBox(height: 16),
              ...sideArticles.map(
                (a) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _ArticleCard(article: a),
                ),
              ),
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: leftColumnWidth,
              child: _FeaturedArticleCard(article: mainArticle),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: rightColumnWidth,
              child: Column(
                children: sideArticles
                    .map(
                      (a) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _ArticleCard(article: a),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _FeaturedArticleCard extends StatelessWidget {
  final NewsArticle article;
  const _FeaturedArticleCard({required this.article});

  @override
  Widget build(BuildContext context) {
    final DateTime? published = article.publishedAt is Timestamp ? (article.publishedAt as Timestamp).toDate() : null;
    final String dateText = published != null ? DateFormat('MMM d, yyyy').format(published) : '';
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => NewsDetailScreen(article: article)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 280,
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(8),
              image: article.thumbnailUrl.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(article.thumbnailUrl),
                      fit: BoxFit.cover,
                      onError: (_, __) {},
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            article.title,
            style: AppTextStyles.body.copyWith(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            article.subtitle.isNotEmpty ? article.subtitle : article.title,
            style: AppTextStyles.body.copyWith(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            article.subtitle.isNotEmpty ? article.subtitle : article.content,
            style: AppTextStyles.caption.copyWith(color: Colors.white, fontSize: 13, height: 1.35),
          ),
          const SizedBox(height: 10),
          if (dateText.isNotEmpty)
            Text(
              dateText,
              style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 12),
            ),
          const SizedBox(height: 10),
          Text(
            'Read more →',
            style: AppTextStyles.caption.copyWith(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _ArticleCard extends StatelessWidget {
  final NewsArticle article;
  const _ArticleCard({required this.article});

  @override
  Widget build(BuildContext context) {
    final DateTime? published = article.publishedAt is Timestamp ? (article.publishedAt as Timestamp).toDate() : null;
    final String dateText = published != null ? DateFormat('MMM d, yyyy').format(published) : '';
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => NewsDetailScreen(article: article)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(6),
              image: article.thumbnailUrl.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(article.thumbnailUrl),
                      fit: BoxFit.cover,
                      onError: (_, __) {},
                    )
                  : null,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.article, color: Colors.white70, size: 14),
                    const SizedBox(width: 6),
                    Text(
                      article.category,
                      style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 12),
                    ),
                    if (dateText.isNotEmpty) ...[
                      const SizedBox(width: 12),
                      const Icon(Icons.calendar_month, color: Colors.white70, size: 12),
                      const SizedBox(width: 4),
                      Text(
                        dateText,
                        style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  article.title,
                  style: AppTextStyles.body.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  article.subtitle.isNotEmpty ? article.subtitle : article.content,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.caption.copyWith(color: Colors.white, fontSize: 12, height: 1.35),
                ),
                const SizedBox(height: 8),
                Text(
                  'Read more →',
                  style: AppTextStyles.caption.copyWith(color: Colors.white, fontSize: 11.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
