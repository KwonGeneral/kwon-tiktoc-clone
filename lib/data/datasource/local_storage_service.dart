import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _likedVideoIdsKey = 'liked_video_ids';
  static const _bookmarkedVideoIdsKey = 'bookmarked_video_ids';
  static const _followedUserIdsKey = 'followed_user_ids';

  final SharedPreferences _prefs;

  LocalStorageService(this._prefs);

  // Liked Videos
  Set<String> getLikedVideoIds() {
    return _prefs.getStringList(_likedVideoIdsKey)?.toSet() ?? {};
  }

  Future<void> saveLikedVideoIds(Set<String> ids) {
    return _prefs.setStringList(_likedVideoIdsKey, ids.toList());
  }

  // Bookmarked Videos
  Set<String> getBookmarkedVideoIds() {
    return _prefs.getStringList(_bookmarkedVideoIdsKey)?.toSet() ?? {};
  }

  Future<void> saveBookmarkedVideoIds(Set<String> ids) {
    return _prefs.setStringList(_bookmarkedVideoIdsKey, ids.toList());
  }

  // Followed Users
  Set<String> getFollowedUserIds() {
    return _prefs.getStringList(_followedUserIdsKey)?.toSet() ?? {};
  }

  Future<void> saveFollowedUserIds(Set<String> ids) {
    return _prefs.setStringList(_followedUserIdsKey, ids.toList());
  }
}
