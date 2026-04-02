abstract final class RoutePaths {
  static const feed = '/feed';
  static const friends = '/friends';
  static const discover = '/discover';
  static const camera = '/camera';
  static const notifications = '/notifications';
  static const profile = '/profile';
  static const userProfile = '/user/:userId';

  static const publish = '/publish';
  static const profileEdit = '/profile/edit';
  static const settings = '/settings';

  static String userProfilePath(String userId) => '/user/$userId';
}
