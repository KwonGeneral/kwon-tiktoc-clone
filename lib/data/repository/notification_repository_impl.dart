import 'package:kwon_tiktoc_clone/domain/entity/notification.dart';
import 'package:kwon_tiktoc_clone/domain/repository/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  static final _mockNotifications = <Notification>[
    // 팔로우 알림
    Notification(
      id: 'noti_1',
      type: NotificationType.follow,
      message: '님이 회원님을 팔로우하기 시작했습니다.',
      userId: 'user_1',
      userNickname: 'dance_queen',
      createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
    ),
    Notification(
      id: 'noti_2',
      type: NotificationType.follow,
      message: '님이 회원님을 팔로우하기 시작했습니다.',
      userId: 'user_6',
      userNickname: 'comedy_king',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),

    // 좋아요 알림
    Notification(
      id: 'noti_3',
      type: NotificationType.like,
      message: '님이 회원님의 동영상을 좋아합니다.',
      userId: 'user_2',
      userNickname: 'travel_diary',
      relatedVideoId: 'video_0',
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    Notification(
      id: 'noti_4',
      type: NotificationType.like,
      message: '님이 회원님의 동영상을 좋아합니다.',
      userId: 'user_3',
      userNickname: 'cooking_master',
      relatedVideoId: 'video_1',
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    Notification(
      id: 'noti_5',
      type: NotificationType.like,
      message: '님이 회원님의 동영상을 좋아합니다.',
      userId: 'user_5',
      userNickname: 'fitness_pro',
      relatedVideoId: 'video_2',
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),

    // 댓글 알림
    Notification(
      id: 'noti_6',
      type: NotificationType.comment,
      message: '님이 댓글을 남겼습니다: "정말 멋져요! 🔥"',
      userId: 'user_4',
      userNickname: 'pet_lover',
      relatedVideoId: 'video_0',
      createdAt: DateTime.now().subtract(const Duration(hours: 4)),
    ),
    Notification(
      id: 'noti_7',
      type: NotificationType.comment,
      message: '님이 댓글을 남겼습니다: "어떻게 촬영한 거예요?"',
      userId: 'user_7',
      userNickname: 'music_vibes',
      relatedVideoId: 'video_3',
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
    ),
    Notification(
      id: 'noti_8',
      type: NotificationType.comment,
      message: '님이 댓글을 남겼습니다: "대박 ㅋㅋㅋ"',
      userId: 'user_8',
      userNickname: 'art_studio',
      relatedVideoId: 'video_5',
      createdAt: DateTime.now().subtract(const Duration(hours: 8)),
    ),

    // 시스템 알림
    Notification(
      id: 'noti_9',
      type: NotificationType.system,
      message: '계정 관련 새 소식: 새 장치에서 로그인되었습니다.',
      userId: '',
      userNickname: '시스템 알림',
      createdAt: DateTime.now().subtract(const Duration(hours: 14)),
    ),

    // 추가 알림
    Notification(
      id: 'noti_10',
      type: NotificationType.follow,
      message: '님이 회원님을 팔로우하기 시작했습니다.',
      userId: 'user_9',
      userNickname: 'nature_walk',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Notification(
      id: 'noti_11',
      type: NotificationType.like,
      message: '님이 회원님의 동영상을 좋아합니다.',
      userId: 'user_10',
      userNickname: 'street_food',
      relatedVideoId: 'video_4',
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
    ),
    Notification(
      id: 'noti_12',
      type: NotificationType.comment,
      message: '님이 댓글을 남겼습니다: "저도 해보고 싶어요!"',
      userId: 'user_11',
      userNickname: 'yoga_life',
      relatedVideoId: 'video_6',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  @override
  Future<List<Notification>> getNotifications() async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    return List.unmodifiable(_mockNotifications);
  }

  @override
  Future<List<Notification>> getNotificationsByType(
    NotificationType type,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    return _mockNotifications.where((n) => n.type == type).toList();
  }
}
