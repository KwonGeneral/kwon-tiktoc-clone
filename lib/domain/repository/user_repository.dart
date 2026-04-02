import 'package:kwon_tiktoc_clone/domain/entity/user.dart';

abstract interface class UserRepository {
  Future<User> getUserById(String id);
  Future<User> getCurrentUser();
}
