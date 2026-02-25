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
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import 'package:minvest_forex_app/web/theme/breakpoints.dart';

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

  String _getTabTitle(BuildContext context, String tab) {
    switch (tab) {
      case 'All Articles':
        return AppLocalizations.of(context)!.newsTabAllArticles;
      case 'Investor':
        return AppLocalizations.of(context)!.newsTabInvestor;
      case 'Knowledge':
        return AppLocalizations.of(context)!.newsTabKnowledge;
      case 'Technical Analysis':
        return AppLocalizations.of(context)!.newsTabTechnicalAnalysis;
      default:
        return tab;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.tablet;

        return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: isMobile ? const TextScaler.linear(0.9) : const TextScaler.linear(1.0),
            ),
            child: Scaffold(        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1230),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 12),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8), // Giảm từ 16 xuống 8
                    child: LandingNavBar(),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8), // Giảm từ 16 xuống 8
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _header(context),
                        const SizedBox(height: 24),
                        _categoryTabs(context),
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
                              getTabTitle: (tab) => _getTabTitle(context, tab),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 64),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context)!.financialNewsHub,
          style: AppTextStyles.h1.copyWith(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          AppLocalizations.of(context)!.financialNewsHubDesc,
          style: AppTextStyles.body.copyWith(color: AppColors.textSecondary, fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _categoryTabs(BuildContext context) {
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
              _getTabTitle(context, t),
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
  final String Function(String) getTabTitle;
  const _NewsLayout({
    required this.articles,
    required this.selectedCategory,
    required this.getTabTitle,
  });

  @override
  Widget build(BuildContext context) {
    if (articles.isEmpty) {
      return Column(
        children: [
          Text(
            AppLocalizations.of(context)!.noArticlesForCategory(getTabTitle(selectedCategory)),
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
    // Take next 3 articles for the side column
    final sideArticles = articles.where((a) => a.id != mainArticle.id).take(3).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        // Breakpoint for the strict pixel layout (needs roughly 1150px space)
        final bool isDesktop = constraints.maxWidth >= 1150;

        if (!isDesktop) {
          // Responsive / Mobile Layout fallback
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _FeaturedArticleCard(article: mainArticle, isDesktop: false),
              const SizedBox(height: 24),
              ...sideArticles.map(
                (a) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _ArticleCard(article: a, isDesktop: false),
                ),
              ),
            ],
          );
        }

        // Strict Desktop Layout
        return SizedBox(
          height: 750,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left Column - Main Article (Always first)
              SizedBox(
                width: 403.49,
                height: 750,
                child: _FeaturedArticleCard(article: mainArticle, isDesktop: true),
              ),
              // Right Column - Subsequent Articles (Top to bottom)
              if (sideArticles.isNotEmpty)
                SizedBox(
                  width: 783.67,
                  height: 750,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < sideArticles.length; i++) ...[
                        _ArticleCard(article: sideArticles[i], isDesktop: true),
                        if (i < sideArticles.length - 1) const SizedBox(height: 15),
                      ],
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _FeaturedArticleCard extends StatefulWidget {
  final NewsArticle article;
  final bool isDesktop;
  const _FeaturedArticleCard({required this.article, required this.isDesktop});

  @override
  State<_FeaturedArticleCard> createState() => _FeaturedArticleCardState();
}

class _FeaturedArticleCardState extends State<_FeaturedArticleCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final DateTime? published = widget.article.publishedAt is Timestamp
        ? (widget.article.publishedAt as Timestamp).toDate()
        : null;
    final String dateText =
        published != null ? DateFormat('MMM d, yyyy').format(published) : '';

    final double imgWidth = widget.isDesktop ? 381.46 : double.infinity;
    final double imgHeight = widget.isDesktop ? 426.89 : 280;

    return RepaintBoundary(
      child: MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => NewsDetailScreen(article: widget.article)),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(12), // Padding for border spacing
          decoration: BoxDecoration(
            color: Colors.black, // Set background to black
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.transparent, // Always transparent
              width: 1.5,
            ),
            boxShadow: _isHovered 
              ? [
                  BoxShadow(
                    color: const Color(0xFF289EFF).withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                  )
                ] 
              : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: imgWidth,
                  height: imgHeight,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    image: widget.article.thumbnailUrl.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(widget.article.thumbnailUrl),
                            fit: BoxFit.cover,
                            onError: (_, __) {},
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Date & Category
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3FA9F5).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      widget.article.category.toUpperCase(),
                      style: AppTextStyles.caption.copyWith(
                        color: const Color(0xFF3FA9F5),
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  if (dateText.isNotEmpty) ...[
                    const SizedBox(width: 12),
                    const Icon(Icons.access_time, color: Colors.white54, size: 14),
                    const SizedBox(width: 6),
                    Text(
                      dateText,
                      style: AppTextStyles.caption.copyWith(color: Colors.white54),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 12),
              // Title
              Text(
                widget.article.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.h3.copyWith(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              // Content / Subtitle
              widget.isDesktop
                  ? Expanded(
                      child: Text(
                        widget.article.subtitle.isNotEmpty
                            ? widget.article.subtitle
                            : widget.article.content,
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.body.copyWith(
                          color: Colors.white70,
                          height: 1.5,
                        ),
                      ),
                    )
                  : Text(
                      widget.article.subtitle.isNotEmpty
                          ? widget.article.subtitle
                          : widget.article.content,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.body.copyWith(
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
              const SizedBox(height: 12),
              // Read More
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.seeDetails,
                    style: AppTextStyles.body.copyWith(
                      color: const Color(0xFF3FA9F5),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, color: Color(0xFF3FA9F5), size: 16),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class _ArticleCard extends StatefulWidget {
  final NewsArticle article;
  final bool isDesktop;
  const _ArticleCard({required this.article, required this.isDesktop});

  @override
  State<_ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<_ArticleCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final DateTime? published = widget.article.publishedAt is Timestamp
        ? (widget.article.publishedAt as Timestamp).toDate()
        : null;
    final String dateText =
        published != null ? DateFormat('MMM d, yyyy').format(published) : '';

    final double imgWidth = widget.isDesktop ? 226.85 : 120;
    final double imgHeight = widget.isDesktop ? 205 : 120;
    final double? cardHeight = widget.isDesktop ? 240 : null;

    Widget content() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Category & Date
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3FA9F5).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    widget.article.category.toUpperCase(),
                    style: AppTextStyles.caption.copyWith(
                      color: const Color(0xFF3FA9F5),
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                    ),
                  ),
                ),
                if (dateText.isNotEmpty) ...[
                  const SizedBox(width: 12),
                  const Icon(Icons.access_time, color: Colors.white54, size: 14),
                  const SizedBox(width: 6),
                  Text(
                    dateText,
                    style: AppTextStyles.caption.copyWith(color: Colors.white54, fontSize: 13), // Increased size
                  ),
                ],
              ],
            ),
            const SizedBox(height: 12),
            // Title
            Text(
              widget.article.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.h3.copyWith(
                color: Colors.white,
                fontSize: 20, // Increased to 20
                fontWeight: FontWeight.w700,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 8),
            // Excerpt
            Text(
              widget.article.subtitle.isNotEmpty
                  ? widget.article.subtitle
                  : widget.article.content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.body.copyWith(
                color: Colors.white70,
                fontSize: 14, // Increased to 14
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            // Read More with Arrow
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.seeDetails,
                  style: AppTextStyles.caption.copyWith(
                    color: const Color(0xFF3FA9F5),
                    fontWeight: FontWeight.w600,
                    fontSize: 13, // Slightly bigger
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.arrow_forward, color: Color(0xFF3FA9F5), size: 16),
              ],
            ),
          ],
        );

    return RepaintBoundary(
      child: MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => NewsDetailScreen(article: widget.article)),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.isDesktop ? 783.67 : null, // Restore width here
          height: cardHeight,
          margin: const EdgeInsets.only(bottom: 0),
          padding: const EdgeInsets.all(12), // Padding for border
          decoration: BoxDecoration(
            color: Colors.black, // Set background to black
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.transparent, // Always transparent
              width: 1.5,
            ),
            boxShadow: _isHovered 
              ? [
                  BoxShadow(
                    color: const Color(0xFF289EFF).withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                  )
                ] 
              : [],
          ),
          child: widget.isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: imgWidth,
                        height: imgHeight,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1A1A),
                          image: widget.article.thumbnailUrl.isNotEmpty
                              ? DecorationImage(
                                  image: NetworkImage(widget.article.thumbnailUrl),
                                  fit: BoxFit.cover,
                                  onError: (_, __) {},
                                )
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(child: content()),
                  ],
                )
              : Row( // Mobile Layout
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1A1A),
                          image: widget.article.thumbnailUrl.isNotEmpty
                              ? DecorationImage(
                                  image: NetworkImage(widget.article.thumbnailUrl),
                                  fit: BoxFit.cover,
                                  onError: (_, __) {},
                                )
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.article.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.body.copyWith(
                              color: Colors.white,
                              fontSize: 16, // Mobile title size
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            dateText,
                            style: AppTextStyles.caption.copyWith(color: Colors.white54, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    ));
  }
}