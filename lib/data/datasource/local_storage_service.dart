import 'package:shared_preferences/shared_preferences.dart';

import 'package:kwon_tiktoc_clone/domain/repository/local_storage_repository.dart';

class LocalStorageService implements LocalStorageRepository {
  static const _likedVideoIdsKey = 'liked_video_ids';
  static const _bookmarkedVideoIdsKey = 'bookmarked_video_ids';
  static const _followedUserIdsKey = 'followed_user_ids';
  static const _likedCommentIdsKey = 'liked_comment_ids';
  static const _dislikedCommentIdsKey = 'disliked_comment_ids';
  static const _userCommentsKey = 'user_comments';
  static const _profileNicknameKey = 'profile_nickname';
  static const _profileBioKey = 'profile_bio';
  static const _notificationEnabledKey = 'notification_enabled';

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

  @override
  Set<String> getLikedCommentIds() {
    return _prefs.getStringList(_likedCommentIdsKey)?.toSet() ?? {};
  }

  @override
  Future<void> saveLikedCommentIds(Set<String> ids) {
    return _prefs.setStringList(_likedCommentIdsKey, ids.toList());
  }

  @override
  Set<String> getDislikedCommentIds() {
    return _prefs.getStringList(_dislikedCommentIdsKey)?.toSet() ?? {};
  }

  @override
  Future<void> saveDislikedCommentIds(Set<String> ids) {
    return _prefs.setStringList(_dislikedCommentIdsKey, ids.toList());
  }

  @override
  String getUserCommentsJson() {
    return _prefs.getString(_userCommentsKey) ?? '[]';
  }

  @override
  Future<void> saveUserCommentsJson(String json) {
    return _prefs.setString(_userCommentsKey, json);
  }

  @override
  String getProfileNickname() {
    return _prefs.getString(_profileNicknameKey) ?? '';
  }

  @override
  Future<void> saveProfileNickname(String nickname) {
    return _prefs.setString(_profileNicknameKey, nickname);
  }

  @override
  String getProfileBio() {
    return _prefs.getString(_profileBioKey) ?? '';
  }

  @override
  Future<void> saveProfileBio(String bio) {
    return _prefs.setString(_profileBioKey, bio);
  }

  @override
  bool getNotificationEnabled() {
    return _prefs.getBool(_notificationEnabledKey) ?? true;
  }

  @override
  Future<void> saveNotificationEnabled({required bool enabled}) {
    return _prefs.setBool(_notificationEnabledKey, enabled);
  }
}
