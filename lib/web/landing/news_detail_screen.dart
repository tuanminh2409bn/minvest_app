import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:intl/intl.dart';
import 'package:minvest_forex_app/features/news/models/news_model.dart';
import 'package:minvest_forex_app/features/news/services/news_service.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import 'package:minvest_forex_app/web/chat/web_chat_bubble.dart';
import 'package:minvest_forex_app/web/theme/breakpoints.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import 'widgets/navbar.dart';
import 'sections/footer_section.dart';

class NewsDetailScreen extends StatefulWidget {
  final NewsArticle article;
  const NewsDetailScreen({super.key, required this.article});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  final NewsService _newsService = NewsService();
  late QuillController _quillController;

  @override
  void initState() {
    super.initState();
    _quillController = QuillController(
      document: _parseContent(widget.article.content),
      selection: const TextSelection.collapsed(offset: 0),
      readOnly: true,
    );
  }

  Document _parseContent(String content) {
    try {
      dynamic json = jsonDecode(content);
      List<dynamic> ops = [];

      if (json is List) {
        ops = json;
      } else if (json is Map && json.containsKey('ops')) {
        ops = json['ops'];
      } else {
        // Unknown format, treat as plain text
        return Document()..insert(0, content);
      }

      final List<dynamic> newOps = [];
      for (var op in ops) {
        if (op is Map && op.containsKey('insert') && op['insert'] is String) {
          final String text = op['insert'];
          final Map<String, dynamic>? attributes = op.containsKey('attributes') ? op['attributes'] : null;
          
          final parts = _splitTextAndImages(text, attributes);
          newOps.addAll(parts);
        } else {
          newOps.add(op);
        }
      }
      
      // Ensure the document ends with a newline
      if (newOps.isEmpty) {
        newOps.add({'insert': '\n'});
      } else {
        final lastOp = newOps.last;
        if (lastOp is Map && lastOp.containsKey('insert')) {
          final insert = lastOp['insert'];
          if (insert is String) {
            if (!insert.endsWith('\n')) {
              lastOp['insert'] = '$insert\n';
            }
          } else {
            // Last op is an embed (e.g. image), so we need a newline after it
            newOps.add({'insert': '\n'});
          }
        }
      }
      
      return Document.fromJson(newOps);

    } catch (e) {
      // Fallback for plain text content
      final ops = _splitTextAndImages(content, null);
      // Ensure fallback also ends with newline
      if (ops.isEmpty) {
        ops.add({'insert': '\n'});
      } else {
        final lastOp = ops.last;
        if (lastOp is Map && lastOp.containsKey('insert')) {
           final insert = lastOp['insert'];
           if (insert is String) {
             if (!insert.endsWith('\n')) {
               lastOp['insert'] = '$insert\n';
             }
           } else {
             ops.add({'insert': '\n'});
           }
        }
      }
      return Document.fromJson(ops);
    }
  }

  List<dynamic> _splitTextAndImages(String text, Map<String, dynamic>? attributes) {
    final List<dynamic> ops = [];
    // Regex to find image URLs. 
    // Captures http/https urls ending with standard image extensions, AND optionally query parameters (e.g. ?token=...)
    final RegExp exp = RegExp(r'(https?://\S+\.(?:png|jpg|jpeg|gif|webp|bmp)(?:\?\S*)?)', caseSensitive: false);
    
    int start = 0;
    for (final Match match in exp.allMatches(text)) {
      // Text before match
      if (match.start > start) {
        ops.add({
          'insert': text.substring(start, match.start),
          if (attributes != null) 'attributes': attributes,
        });
      }
      
      // The image
      // Note: Quill renders block embeds on their own line usually.
      // We insert a newline before if needed? No, let Quill handle it.
      // But typically image embeds are standalone blocks.
      final String url = match.group(0)!;
      ops.add({'insert': {'image': url}});
      
      start = match.end;
    }
    
    // Remaining text
    if (start < text.length) {
      ops.add({
        'insert': text.substring(start),
        if (attributes != null) 'attributes': attributes,
      });
    }
    
    if (ops.isEmpty) {
      // If regex failed (no matches) but we called this, it means the whole text was analyzed.
      // Logic above handles matches. If no matches, start remains 0.
      // So this block is likely not reached unless text is empty.
      if (text.isNotEmpty) {
         ops.add({
          'insert': text,
          if (attributes != null) 'attributes': attributes,
        });
      }
    }
    
    return ops;
  }

  @override
  void dispose() {
    _quillController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DateTime? published = widget.article.publishedAt is Timestamp ? (widget.article.publishedAt as Timestamp).toDate() : null;
    final String publishedText = published != null ? DateFormat('MMM d, yyyy • HH:mm').format(published) : '';

    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.tablet;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: isMobile ? const TextScaler.linear(0.6) : const TextScaler.linear(1.0),
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        floatingActionButton: const WebChatBubble(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
                            Text(AppLocalizations.of(context)!.returnToHomePage, style: AppTextStyles.caption.copyWith(color: Colors.white70)),
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
                        widget.article.title,
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
                                _heroImage(widget.article.thumbnailUrl),
                                const SizedBox(height: 14),
                                if (widget.article.subtitle.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Text(
                                      widget.article.subtitle,
                                      style: AppTextStyles.caption.copyWith(color: Colors.white70, height: 1.4, fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                _buildContent(),
                                const SizedBox(height: 18),
                                _MostPopularList(
                                  currentId: widget.article.id,
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
                                    _heroImage(widget.article.thumbnailUrl),
                                    const SizedBox(height: 14),
                                    if (widget.article.subtitle.isNotEmpty)
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 12),
                                        child: Text(
                                          widget.article.subtitle,
                                          style: AppTextStyles.caption.copyWith(color: Colors.white70, height: 1.4, fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                    _buildContent(),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 18),
                              SizedBox(
                                width: 260,
                                child: _MostPopularList(
                                  currentId: widget.article.id,
                                  newsService: _newsService,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 28),
                      _RelatedArticles(
                        currentId: widget.article.id,
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
      ),
    );
  }

  Widget _buildContent() {
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      child: MouseRegion(
        cursor: SystemMouseCursors.basic,
        child: AbsorbPointer(
          child: QuillEditor.basic(
            controller: _quillController,
            config: QuillEditorConfig(
              placeholder: 'No content',
              autoFocus: false,
              expands: false,
              padding: EdgeInsets.zero,
              enableInteractiveSelection: false,
              embedBuilders: [
                _ImageEmbedBuilder(),
              ],
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

class _ImageEmbedBuilder extends EmbedBuilder {
  @override
  String get key => BlockEmbed.imageType;

  @override
  Widget build(BuildContext context, EmbedContext embedContext) {
    final String url = embedContext.node.value.data.toString().trim();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          url,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => Text(
            'Lỗi tải ảnh: $url',
            style: const TextStyle(color: Colors.red, fontSize: 12),
          ),
        ),
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
        Text(AppLocalizations.of(context)!.mostPopular, style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),), const SizedBox(height: 12),
        StreamBuilder<List<NewsArticle>>(
          stream: newsService.streamNews(limit: 5),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final articles = (snapshot.data ?? []).where((a) => a.id != currentId).toList();
            if (articles.isEmpty) {
              return Text(AppLocalizations.of(context)!.noPosts, style: AppTextStyles.caption.copyWith(color: Colors.white54));
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
              AppLocalizations.of(context)!.relatedArticles,
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
            AppLocalizations.of(context)!.seeDetails,
            style: AppTextStyles.caption.copyWith(color: Colors.white, fontSize: 11.5),
          ),
        ],
      ),
    );
  }
}
