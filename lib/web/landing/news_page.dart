import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';
import '../theme/text_styles.dart';
import 'widgets/navbar.dart';
import 'sections/footer_section.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

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
                  const _NewsLayout(),
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
    final tabs = ['All Articles', 'Investor', 'Knowledge', 'Technical Analysis'];
    return Wrap(
      spacing: 20,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: tabs.map((t) {
        final isActive = t == 'All Articles';
        return Text(
          t,
          style: AppTextStyles.body.copyWith(
            color: isActive ? const Color(0xFF3FA9F5) : Colors.white,
            fontSize: 14,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
          ),
        );
      }).toList(),
    );
  }
}

class _NewsLayout extends StatelessWidget {
  const _NewsLayout();

  @override
  Widget build(BuildContext context) {
    final mainArticle = _Article(
      title: 'Investment Psychology Management – Escaping the Trap of FOMO',
      description:
          'FOMO creeps into every decision, driving you to buy and sell in panic, destroying discipline. Understanding and managing FOMO is the turning point that transforms an investor from a novice rookie into ...',
      date: 'Oct 1, 2025',
      category: 'News',
    );

    final sideArticles = [
      mainArticle.copyWith(category: 'News'),
      mainArticle.copyWith(category: 'Worldwide'),
      mainArticle.copyWith(category: 'Worldwide'),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final double rightColumnWidth = 520;
        final double leftColumnWidth = constraints.maxWidth - rightColumnWidth - 16;
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
  final _Article article;
  const _FeaturedArticleCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 280,
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(8),
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
          'Escaping the Trap of FOMO',
          style: AppTextStyles.body.copyWith(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          article.description,
          style: AppTextStyles.caption.copyWith(color: Colors.white, fontSize: 13, height: 1.35),
        ),
        const SizedBox(height: 10),
        Text(
          'Read more →',
          style: AppTextStyles.caption.copyWith(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}

class _ArticleCard extends StatelessWidget {
  final _Article article;
  const _ArticleCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(6),
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
                  const SizedBox(width: 12),
                  const Icon(Icons.calendar_month, color: Colors.white70, size: 12),
                  const SizedBox(width: 4),
                  Text(
                    article.date,
                    style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 12),
                  ),
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
                article.description,
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
    );
  }
}

class _Article {
  final String title;
  final String description;
  final String date;
  final String category;

  const _Article({
    required this.title,
    required this.description,
    required this.date,
    required this.category,
  });

  _Article copyWith({
    String? title,
    String? description,
    String? date,
    String? category,
  }) {
    return _Article(
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      category: category ?? this.category,
    );
  }
}
