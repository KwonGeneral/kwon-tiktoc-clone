abstract final class RoutePaths {
  static const feed = '/feed';
  static const friends = '/friends';
  static const discover = '/discover';
  static const camera = '/camera';
  static const notifications = '/notifications';
  static const profile = '/profile';
  static const userProfile = '/user/:userId';

  static const publish = '/publish';
  static const publishImage = '/publish-image';
  static const imageDetail = '/image/:imageId';
  static const profileEdit = '/profile/edit';
  static const settings = '/settings';
  static const followList = '/follow-list';

  static String userProfilePath(String userId) => '/user/$userId';
  static String imageDetailPath(String imageId) => '/image/$imageId';
}
