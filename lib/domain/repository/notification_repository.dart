import 'package:kwon_tiktoc_clone/domain/entity/notification.dart';

abstract interface class NotificationRepository {
  Future<List<Notification>> getNotifications();
  Future<List<Notification>> getNotificationsByType(NotificationType type);
}
