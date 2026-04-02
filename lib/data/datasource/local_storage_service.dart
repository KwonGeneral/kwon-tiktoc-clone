import 'package:shared_preferences/shared_preferences.dart';

import 'package:kwon_tiktoc_clone/domain/repository/local_storage_repository.dart';

class LocalStorageService implements LocalStorageRepository {
  static const _likedVideoIdsKey = 'liked_video_ids';
  static const _bookmarkedVideoIdsKey = 'bookmarked_video_ids';
  static const _followedUserIdsKey = 'followed_user_ids';

  final SharedPreferences _prefs;

  LocalStorageService(this._prefs);

  @override
  Set<String> getLikedVideoIds() {
    return _prefs.getStringList(_likedVideoIdsKey)?.toSet() ?? {};
  }

  @override
  Future<void> saveLikedVideoIds(Set<String> ids) {
    return _prefs.setStringList(_likedVideoIdsKey, ids.toList());
  }

  @override
  Set<String> getBookmarkedVideoIds() {
    return _prefs.getStringList(_bookmarkedVideoIdsKey)?.toSet() ?? {};
  }

  @override
  Future<void> saveBookmarkedVideoIds(Set<String> ids) {
    return _prefs.setStringList(_bookmarkedVideoIdsKey, ids.toList());
  }

  @override
  Set<String> getFollowedUserIds() {
    return _prefs.getStringList(_followedUserIdsKey)?.toSet() ?? {};
  }

  @override
  Future<void> saveFollowedUserIds(Set<String> ids) {
    return _prefs.setStringList(_followedUserIdsKey, ids.toList());
  }
}
