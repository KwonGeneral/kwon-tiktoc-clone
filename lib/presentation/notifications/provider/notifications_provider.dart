import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:kwon_tiktoc_clone/core/di/providers.dart';
import 'package:kwon_tiktoc_clone/presentation/notifications/provider/notifications_state.dart';

part 'notifications_provider.g.dart';

@riverpod
class NotificationsNotifier extends _$NotificationsNotifier {
  @override
  Future<NotificationsState> build() async {
    final notificationRepo = ref.watch(notificationRepositoryProvider);
    final userRepo = ref.watch(userRepositoryProvider);

    final notifications = await notificationRepo.getNotifications();
    final recommendedUsers = await userRepo.getRecommendedUsers();

    // 추천 계정은 3명만 표시
    final recommended = recommendedUsers.length > 3
        ? recommendedUsers.sublist(0, 3)
        : recommendedUsers;

    return NotificationsState(
      notifications: notifications,
      recommendedUsers: recommended,
    );
  }
}
