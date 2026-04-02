import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/route/route_paths.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../domain/entity/notification.dart' as domain;
import '../../../presentation/feed/provider/feed_provider.dart';
import '../provider/notifications_provider.dart';
import '../widget/notification_category_tile.dart';
import '../widget/notification_item.dart';
import '../widget/recommended_account_tile.dart';

class NotificationsPage extends ConsumerStatefulWidget {
  const NotificationsPage({super.key});

  @override
  ConsumerState<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends ConsumerState<NotificationsPage> {
  final Set<String> _dismissedAccountIds = {};

  @override
  Widget build(BuildContext context) {
    final notificationsAsync = ref.watch(notificationsNotifierProvider);
    final followedUserIds =
        ref.watch(feedNotifierProvider).valueOrNull?.followedUserIds ?? {};

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        centerTitle: true,
        title: const Text(
          AppStrings.notificationsTitle,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: notificationsAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.white),
        ),
        error: (e, _) => Center(
          child: Text(
            e.toString(),
            style: const TextStyle(color: AppColors.whiteSecondary),
          ),
        ),
        data: (state) => ListView(
          children: [
            // 카테고리 섹션
            _buildCategorySection(state.notifications),

            const Divider(color: AppColors.divider, height: 1),

            // 추천 계정 헤더
            _buildRecommendedHeader(),

            // 추천 계정 목록
            ...state.recommendedUsers
                .where((u) => !_dismissedAccountIds.contains(u.id))
                .map(
                  (user) => RecommendedAccountTile(
                    user: user,
                    isFollowed: followedUserIds.contains(user.id),
                    onToggleFollow: () {
                      ref
                          .read(feedNotifierProvider.notifier)
                          .toggleFollow(user.id);
                    },
                    onDismiss: () {
                      setState(() => _dismissedAccountIds.add(user.id));
                    },
                    onTap: () {
                      context.push(RoutePaths.userProfilePath(user.id));
                    },
                  ),
                ),

            const Divider(color: AppColors.divider, height: 1),

            // 개별 알림 목록
            ...state.notifications.map(
              (notification) => NotificationItem(
                notification: notification,
                onTap: () => _handleNotificationTap(notification),
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(List<domain.Notification> notifications) {
    final followCount =
        notifications.where((n) => n.type == domain.NotificationType.follow).length;
    final activityCount = notifications
        .where(
          (n) =>
              n.type == domain.NotificationType.like ||
              n.type == domain.NotificationType.comment,
        )
        .length;
    final hasSystem =
        notifications.any((n) => n.type == domain.NotificationType.system);

    return Column(
      children: [
        NotificationCategoryTile(
          icon: Icons.person_add,
          iconColor: AppColors.white,
          iconBackgroundColor: AppColors.secondary,
          title: AppStrings.notificationsNewFollowers,
          subtitle: AppStrings.notificationsNewFollowersSub,
          showBadge: followCount > 0,
          onTap: () {},
        ),
        NotificationCategoryTile(
          icon: Icons.favorite,
          iconColor: AppColors.white,
          iconBackgroundColor: AppColors.primary,
          title: AppStrings.notificationsActivity,
          subtitle: AppStrings.notificationsActivitySub,
          showBadge: activityCount > 0,
          onTap: () {},
        ),
        if (hasSystem)
          NotificationCategoryTile(
            icon: Icons.security,
            iconColor: AppColors.white,
            iconBackgroundColor: AppColors.gray,
            title: AppStrings.notificationsSystem,
            subtitle: notifications
                .firstWhere(
                  (n) => n.type == domain.NotificationType.system,
                )
                .message,
            showBadge: true,
            onTap: () {},
          ),
      ],
    );
  }

  Widget _buildRecommendedHeader() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Row(
        children: [
          Text(
            AppStrings.notificationsRecommendedAccounts,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 4),
          Icon(Icons.info_outline, color: AppColors.whiteDisabled, size: 16),
        ],
      ),
    );
  }

  void _handleNotificationTap(domain.Notification notification) {
    switch (notification.type) {
      case domain.NotificationType.follow:
        if (notification.userId.isNotEmpty) {
          context.push(RoutePaths.userProfilePath(notification.userId));
        }
      case domain.NotificationType.like:
      case domain.NotificationType.comment:
        if (notification.userId.isNotEmpty) {
          context.push(RoutePaths.userProfilePath(notification.userId));
        }
      case domain.NotificationType.system:
        break;
    }
  }
}
