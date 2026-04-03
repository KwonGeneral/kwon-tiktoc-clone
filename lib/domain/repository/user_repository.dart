import 'package:kwon_tiktoc_clone/domain/entity/user.dart';

abstract interface class UserRepository {
  Future<User> getUserById(String id);
  Future<User> getCurrentUser();
  Future<List<User>> getRecommendedUsers();
  Future<String?> getProfileImageUrl(String userId);
  Future<String> uploadProfileImage({
    required String imagePath,
    required String userId,
  });
}
