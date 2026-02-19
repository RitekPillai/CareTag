import 'dart:convert';

class NewsArticle {
  final String title;
  final String? description;
  final String? imageUrl;
  final DateTime pubDate;
  final String? sourceName;
  final String link;

  NewsArticle({
    required this.title,
    this.description,
    this.imageUrl,
    required this.pubDate,
    this.sourceName,
    required this.link,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? 'No Title',
      description: json['description'],
      imageUrl: json['image_url'],
      pubDate: json['pubDate'] != null
          ? DateTime.parse(json['pubDate'])
          : DateTime.now(),
      sourceName: json['source_id'],
      link: json['link'] ?? '',
    );
  }

  String get timeAgo {
    final duration = DateTime.now().difference(pubDate);

    if (duration.inDays > 0) {
      return "${duration.inDays}d ago";
    } else if (duration.inHours > 0) {
      return "${duration.inHours}h ago";
    } else if (duration.inMinutes > 0) {
      return "${duration.inMinutes}m ago";
    } else {
      return "Just now";
    }
  }
}

class NewsResponse {
  final String status;
  final int totalResults;
  final List<NewsArticle> articles;
  final String? nextPage;

  NewsResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
    this.nextPage,
  });

  factory NewsResponse.fromRawJson(String str) =>
      NewsResponse.fromJson(json.decode(str));

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    return NewsResponse(
      status: json['status'] ?? 'error',
      totalResults: json['totalResults'] ?? 0,
      nextPage: json['nextPage'],
      articles: json['results'] != null
          ? List<NewsArticle>.from(
              json['results'].map((x) => NewsArticle.fromJson(x)),
            )
          : [],
    );
  }
}
