import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minvest_forex_app/features/news/models/news_model.dart';
import 'package:minvest_forex_app/features/news/services/news_service.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import 'widgets/navbar.dart';
import 'sections/footer_section.dart';

class NewsDetailScreen extends StatelessWidget {
  final NewsArticle article;
  NewsDetailScreen({super.key, required this.article});

  final NewsService _newsService = NewsService();

  @override
  Widget build(BuildContext context) {
    final DateTime? published = article.publishedAt is Timestamp ? (article.publishedAt as Timestamp).toDate() : null;
    final String publishedText = published != null ? DateFormat('MMM d, yyyy • HH:mm').format(published) : '';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const LandingNavBar(),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.arrow_back_ios_new, color: Colors.white70, size: 14),
                          const SizedBox(width: 6),
                          Text('Back', style: AppTextStyles.caption.copyWith(color: Colors.white70)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.calendar_month, size: 14, color: Colors.white54),
                        const SizedBox(width: 6),
                        Text(publishedText, style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      article.title,
                      style: AppTextStyles.h3.copyWith(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 18),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final bool narrow = constraints.maxWidth < 960;
                        if (narrow) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _heroImage(article.thumbnailUrl),
                              const SizedBox(height: 14),
                              Text(
                                article.subtitle.isNotEmpty ? article.subtitle : article.content,
                                style: AppTextStyles.caption.copyWith(color: Colors.white70, height: 1.4),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                article.content,
                                style: AppTextStyles.body.copyWith(color: Colors.white, height: 1.7),
                              ),
                              const SizedBox(height: 18),
                              _MostPopularList(
                                currentId: article.id,
                                newsService: _newsService,
                              ),
                            ],
                          );
                        }
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _heroImage(article.thumbnailUrl),
                                  const SizedBox(height: 14),
                                  Text(
                                    article.subtitle.isNotEmpty ? article.subtitle : article.content,
                                    style: AppTextStyles.caption.copyWith(color: Colors.white70, height: 1.4),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    article.content,
                                    style: AppTextStyles.body.copyWith(color: Colors.white, height: 1.7),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 18),
                            SizedBox(
                              width: 260,
                              child: _MostPopularList(
                                currentId: article.id,
                                newsService: _newsService,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 28),
                    _RelatedArticles(
                      currentId: article.id,
                      newsService: _newsService,
                    ),
                    const SizedBox(height: 40),
                    const FooterSection(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _heroImage(String url) {
    return Container(
      height: 260,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(8),
        image: url.isNotEmpty
            ? DecorationImage(
                image: NetworkImage(url),
                fit: BoxFit.cover,
                onError: (_, __) {},
              )
            : null,
      ),
    );
  }
}

class _MostPopularList extends StatelessWidget {
  final String currentId;
  final NewsService newsService;
  const _MostPopularList({required this.currentId, required this.newsService});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Most popular',
          style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        StreamBuilder<List<NewsArticle>>(
          stream: newsService.streamNews(limit: 5),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final articles = (snapshot.data ?? []).where((a) => a.id != currentId).toList();
            if (articles.isEmpty) {
              return Text('No posts', style: AppTextStyles.caption.copyWith(color: Colors.white54));
            }
            return Column(
              children: articles.map((a) => _PopularItem(article: a)).toList(),
            );
          },
        ),
      ],
    );
  }
}

class _PopularItem extends StatelessWidget {
  final NewsArticle article;
  const _PopularItem({required this.article});

  @override
  Widget build(BuildContext context) {
    final DateTime? published = article.publishedAt is Timestamp ? (article.publishedAt as Timestamp).toDate() : null;
    final String dateText = published != null ? DateFormat('MMM d, yyyy').format(published) : '';
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => NewsDetailScreen(article: article)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            Container(
              width: 88,
              height: 70,
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
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.caption.copyWith(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600, height: 1.3),
                  ),
                  const SizedBox(height: 4),
                  if (dateText.isNotEmpty)
                    Text(
                      dateText,
                      style: AppTextStyles.caption.copyWith(color: Colors.white54, fontSize: 11),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RelatedArticles extends StatelessWidget {
  final String currentId;
  final NewsService newsService;
  const _RelatedArticles({required this.currentId, required this.newsService});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<NewsArticle>>(
      stream: newsService.streamNews(limit: 10),
      builder: (context, snapshot) {
        final articles = (snapshot.data ?? []).where((a) => a.id != currentId).take(3).toList();
        if (articles.isEmpty) {
          return const SizedBox.shrink();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Related articles',
              style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (context, constraints) {
                final isSmall = constraints.maxWidth < 900;
                final double itemWidth = isSmall ? constraints.maxWidth : (constraints.maxWidth - 24) / 3;
                return Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: articles
                      .map(
                        (a) => SizedBox(
                          width: itemWidth,
                          child: _RelatedCard(article: a),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class _RelatedCard extends StatelessWidget {
  final NewsArticle article;
  const _RelatedCard({required this.article});

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
            height: 180,
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(10),
              image: article.thumbnailUrl.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(article.thumbnailUrl),
                      fit: BoxFit.cover,
                      onError: (_, __) {},
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            article.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.caption.copyWith(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            article.subtitle.isNotEmpty ? article.subtitle : article.content,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 11, height: 1.35),
          ),
          const SizedBox(height: 8),
          if (dateText.isNotEmpty)
            Text(
              dateText,
              style: AppTextStyles.caption.copyWith(color: Colors.white54, fontSize: 11),
            ),
          const SizedBox(height: 4),
          Text(
            'Read more →',
            style: AppTextStyles.caption.copyWith(color: Colors.white, fontSize: 11.5),
          ),
        ],
      ),
    );
  }
}
