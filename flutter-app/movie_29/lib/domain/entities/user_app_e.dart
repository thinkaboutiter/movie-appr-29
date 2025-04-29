class UserAppE {
  final String id;
  final String name;
  final String? avatarUrl;
  final List<String> watchlistIds;

  UserAppE({
    required this.id,
    required this.name,
    this.avatarUrl,
    this.watchlistIds = const [],
  });

  factory UserAppE.fromJson(Map<String, dynamic> json) {
    return UserAppE(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      avatarUrl: json['avatarUrl'],
      watchlistIds: List<String>.from(json['watchlistIds'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatarUrl': avatarUrl,
      'watchlistIds': watchlistIds,
    };
  }

  UserAppE copyWith({
    String? id,
    String? name,
    String? avatarUrl,
    List<String>? watchlistIds,
  }) {
    return UserAppE(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      watchlistIds: watchlistIds ?? this.watchlistIds,
    );
  }

  UserAppE addToWatchlist(String movieId) {
    if (watchlistIds.contains(movieId)) return this;
    return copyWith(watchlistIds: [...watchlistIds, movieId]);
  }

  UserAppE removeFromWatchlist(String movieId) {
    return copyWith(
      watchlistIds: watchlistIds.where((id) => id != movieId).toList(),
    );
  }
}
