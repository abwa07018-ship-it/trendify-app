class VideoModel {
  final String id;
  final String userId;
  final String username;
  final String videoUrl;
  final String caption;
  final List<String> tags;
  final StyleFilterMeta styleFilter;
  final bool hasTrendBadge;
  final VideoStats stats;
  final DateTime createdAt;

  VideoModel({
    required this.id,
    required this.userId,
    required this.username,
    required this.videoUrl,
    required this.caption,
    required this.tags,
    required this.styleFilter,
    required this.hasTrendBadge,
    required this.stats,
    required this.createdAt,
  });
}

class StyleFilterMeta {
  final bool applied;
  final String styleName;
  final String modelVersion;

  StyleFilterMeta({
    required this.applied,
    required this.styleName,
    required this.modelVersion,
  });
}

class VideoStats {
  final int views;
  final int likes;
  final int shares;
  final int comments;

  VideoStats({
    required this.views,
    required this.likes,
    required this.shares,
    required this.comments,
  });
}
