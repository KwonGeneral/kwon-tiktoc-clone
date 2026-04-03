abstract class LocalStorageRepository {
  Set<String> getLikedVideoIds();
  Future<void> saveLikedVideoIds(Set<String> ids);

  Set<String> getBookmarkedVideoIds();
  Future<void> saveBookmarkedVideoIds(Set<String> ids);

  Set<String> getFollowedUserIds();
  Future<void> saveFollowedUserIds(Set<String> ids);

  Set<String> getLikedCommentIds();
  Future<void> saveLikedCommentIds(Set<String> ids);

  Set<String> getDislikedCommentIds();
  Future<void> saveDislikedCommentIds(Set<String> ids);

  String getUserCommentsJson();
  Future<void> saveUserCommentsJson(String json);

  String getProfileNickname();
  Future<void> saveProfileNickname(String nickname);

  String getProfileUsername();
  Future<void> saveProfileUsername(String username);

  String getProfileBio();
  Future<void> saveProfileBio(String bio);

  bool getNotificationEnabled();
  Future<void> saveNotificationEnabled({required bool enabled});

  String getProfileImageUrl();
  Future<void> saveProfileImageUrl(String url);

  int getLastVideoIndex();
  Future<void> saveLastVideoIndex(int index);

  String getLastVideoThumbnailUrl();
  Future<void> saveLastVideoThumbnailUrl(String url);
}
