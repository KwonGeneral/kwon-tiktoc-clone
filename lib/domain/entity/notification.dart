import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification.freezed.dart';

enum NotificationType { like, comment, follow, system }

@freezed
sealed class Notification with _$Notification {
  const factory Notification({
    required String id,
    required NotificationType type,
    required String message,
    required String userId,
    required String userNickname,
    @Default('') String userAvatarUrl,
    @Default('') String relatedVideoId,
    @Default(false) bool isRead,
    required DateTime createdAt,
  }) = _Notification;
}
