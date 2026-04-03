import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:kwon_tiktoc_clone/app/route/route_paths.dart';
import 'package:kwon_tiktoc_clone/app/theme/app_colors.dart';
import 'package:kwon_tiktoc_clone/core/constants/app_strings.dart';
import 'package:kwon_tiktoc_clone/domain/entity/notification.dart' as domain;
import 'package:kwon_tiktoc_clone/presentation/feed/provider/feed_provider.dart';
import 'package:kwon_tiktoc_clone/presentation/notifications/provider/notifications_provider.dart';
import 'package:kwon_tiktoc_clone/presentation/notifications/widget/notification_category_tile.dart';
import 'package:kwon_tiktoc_clone/presentation/notifications/widget/notification_item.dart';
import 'package:kwon_tiktoc_clone/presentation/notifications/widget/recommended_account_tile.dart';

/// 알림 필터 카테고리
enum _NotificationFilter { all, followers, activity, system }

class NotificationsPage extends ConsumerStatefulWidget {
  const NotificationsPage({super.key});

  @override
  ConsumerState<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends ConsumerState<NotificationsPage> {
  final Set<String> _dismissedAccountIds = {};
  _NotificationFilter _filter = _NotificationFilter.all;

  List<domain.Notification> _applyFilter(List<domain.Notification> all) {
    return switch (_filter) {
      _NotificationFilter.all => all,
      _NotificationFilter.followers => all
          .where((n) => n.type == domain.NotificationType.follow)
          .toList(),
      _NotificationFilter.activity => all
          .where(
            (n) =>
                n.type == domain.NotificationType.like ||
                n.type == domain.NotificationType.comment,
          )
          .toList(),
      _NotificationFilter.system => all
          .where((n) => n.type == domain.NotificationType.system)
          .toList(),
    };
  }

  void _selectFilter(_NotificationFilter filter) {
    setState(() {
      _filter = _filter == filter ? _NotificationFilter.all : filter;
    });
  }

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
            onPressed: () {
              // 검색 기능 (현재 미구현 — 탭 시 피드백)
            },
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
        data: (state) {
          final filtered = _applyFilter(state.notifications);

          return ListView(
            children: [
              // 카테고리 섹션
              _buildCategorySection(state.notifications),

              const Divider(color: AppColors.divider, height: 1),

              // 필터 활성화 시 헤더 표시
              if (_filter != _NotificationFilter.all)
                _buildFilterHeader(),

              // 필터 미적용 시 추천 계정 표시
              if (_filter == _NotificationFilter.all) ...[
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
              ],

              // 개별 알림 목록
              if (filtered.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: Text(
                      AppStrings.notificationsFilterEmpty,
                      style: TextStyle(
                        color: AppColors.whiteDisabled,
                        fontSize: 14,
                      ),
                    ),
                  ),
                )
              else
                ...filtered.map(
                  (notification) => NotificationItem(
                    notification: notification,
                    onTap: () => _handleNotificationTap(notification),
                  ),
                ),

              const SizedBox(height: 100),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCategorySection(List<domain.Notification> notifications) {
    final followCount = notifications
        .where((n) => n.type == domain.NotificationType.follow)
        .length;
    final activityCount = notifications
        .where(
          (n) =>
              n.type == domain.NotificationType.like ||
              n.type == domain.NotificationType.comment,
        )
        .length;
    final hasSystem = notifications.any(
      (n) => n.type == domain.NotificationType.system,
    );

    return Column(
      children: [
        NotificationCategoryTile(
          icon: Icons.person_add,
          iconColor: AppColors.white,
          iconBackgroundColor: _filter == _NotificationFilter.followers
              ? AppColors.secondary.withValues(alpha: 0.8)
              : AppColors.secondary,
          title: AppStrings.notificationsNewFollowers,
          subtitle: AppStrings.notificationsNewFollowersSub,
          showBadge: followCount > 0,
          onTap: () => _selectFilter(_NotificationFilter.followers),
        ),
        NotificationCategoryTile(
          icon: Icons.favorite,
          iconColor: AppColors.white,
          iconBackgroundColor: _filter == _NotificationFilter.activity
              ? AppColors.primary.withValues(alpha: 0.8)
              : AppColors.primary,
          title: AppStrings.notificationsActivity,
          subtitle: AppStrings.notificationsActivitySub,
          showBadge: activityCount > 0,
          onTap: () => _selectFilter(_NotificationFilter.activity),
        ),
        if (hasSystem)
          NotificationCategoryTile(
            icon: Icons.security,
            iconColor: AppColors.white,
            iconBackgroundColor: _filter == _NotificationFilter.system
                ? AppColors.gray.withValues(alpha: 0.8)
                : AppColors.gray,
            title: AppStrings.notificationsSystem,
            subtitle: notifications
                .firstWhere((n) => n.type == domain.NotificationType.system)
                .message,
            showBadge: true,
            onTap: () => _selectFilter(_NotificationFilter.system),
          ),
      ],
    );
  }

  Widget _buildFilterHeader() {
    final label = switch (_filter) {
      _NotificationFilter.followers => AppStrings.notificationsNewFollowers,
      _NotificationFilter.activity => AppStrings.notificationsActivity,
      _NotificationFilter.system => AppStrings.notificationsSystem,
      _NotificationFilter.all => '',
    };

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => setState(() => _filter = _NotificationFilter.all),
            child: const Text(
              AppStrings.notificationsShowAll,
              style: TextStyle(color: AppColors.whiteSecondary, fontSize: 13),
            ),
          ),
        ],
      ),
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
