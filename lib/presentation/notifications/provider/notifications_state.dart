import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:kwon_tiktoc_clone/domain/entity/notification.dart';
import 'package:kwon_tiktoc_clone/domain/entity/user.dart';

part 'notifications_state.freezed.dart';

@freezed
sealed class NotificationsState with _$NotificationsState {
  const factory NotificationsState({
    @Default([]) List<Notification> notifications,
    @Default([]) List<User> recommendedUsers,
  }) = _NotificationsState;
}
