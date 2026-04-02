abstract class LocalStorageRepository {
  Set<String> getLikedVideoIds();
  Future<void> saveLikedVideoIds(Set<String> ids);

  Set<String> getBookmarkedVideoIds();
  Future<void> saveBookmarkedVideoIds(Set<String> ids);

  Set<String> getFollowedUserIds();
  Future<void> saveFollowedUserIds(Set<String> ids);
}
