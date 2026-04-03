import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:kwon_tiktoc_clone/app/route/route_paths.dart';
import 'package:kwon_tiktoc_clone/app/theme/app_colors.dart';
import 'package:kwon_tiktoc_clone/app/theme/app_text_styles.dart';
import 'package:kwon_tiktoc_clone/core/constants/app_strings.dart';
import 'package:kwon_tiktoc_clone/presentation/feed/provider/feed_provider.dart';

/// 팔로잉/팔로워 목록 탭 종류
enum FollowListTab { following, followers }

class FollowListPage extends ConsumerStatefulWidget {
  const FollowListPage({
    required this.initialTab,
    super.key,
  });

  final FollowListTab initialTab;

  @override
  ConsumerState<FollowListPage> createState() => _FollowListPageState();
}

class _FollowListPageState extends ConsumerState<FollowListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialTab == FollowListTab.following ? 0 : 1,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => context.pop(),
        ),
        title: Text(
          _tabController.index == 0
              ? AppStrings.profileFollowing
              : AppStrings.profileFollowers,
          style: AppTextStyles.profileName,
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          onTap: (_) => setState(() {}),
          indicatorColor: AppColors.white,
          labelColor: AppColors.white,
          unselectedLabelColor: AppColors.whiteSecondary,
          tabs: const [
            Tab(text: AppStrings.profileFollowing),
            Tab(text: AppStrings.profileFollowers),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _FollowingList(),
          _FollowerList(),
        ],
      ),
    );
  }
}

/// 팔로잉 목록: 내가 팔로우한 유저들
class _FollowingList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedState = ref.watch(feedNotifierProvider).valueOrNull;
    if (feedState == null) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.white),
      );
    }

    final followedUserIds = feedState.followedUserIds;
    if (followedUserIds.isEmpty) {
      return const Center(
        child: Text(
          '팔로잉한 유저가 없습니다',
          style: TextStyle(color: AppColors.whiteSecondary, fontSize: 14),
        ),
      );
    }

    // 팔로우한 유저 정보를 영상 데이터에서 추출
    final userMap = <String, _UserInfo>{};
    for (final video in feedState.videos) {
      if (followedUserIds.contains(video.userId) &&
          !userMap.containsKey(video.userId)) {
        userMap[video.userId] = _UserInfo(
          userId: video.userId,
          nickname: video.nickname,
          username: video.username,
          avatarUrl: video.avatarUrl,
        );
      }
    }

    final users = userMap.values.toList();

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return _FollowUserTile(
          user: user,
          isFollowing: true,
          onFollowTap: () {
            ref
                .read(feedNotifierProvider.notifier)
                .toggleFollow(user.userId);
          },
          onTap: () {
            context.push(RoutePaths.userProfilePath(user.userId));
          },
        );
      },
    );
  }
}

/// 팔로워 목록: Mock 팔로워 (기본 8명 유저를 팔로워로 설정)
class _FollowerList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedState = ref.watch(feedNotifierProvider).valueOrNull;
    if (feedState == null) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.white),
      );
    }

    // 피드 영상에서 유니크 유저 추출 (최대 8명을 Mock 팔로워로)
    final userMap = <String, _UserInfo>{};
    for (final video in feedState.videos) {
      if (!userMap.containsKey(video.userId)) {
        userMap[video.userId] = _UserInfo(
          userId: video.userId,
          nickname: video.nickname,
          username: video.username,
          avatarUrl: video.avatarUrl,
        );
      }
      if (userMap.length >= 8) break;
    }

    final users = userMap.values.toList();

    if (users.isEmpty) {
      return const Center(
        child: Text(
          '팔로워가 없습니다',
          style: TextStyle(color: AppColors.whiteSecondary, fontSize: 14),
        ),
      );
    }

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        final isFollowing =
            feedState.followedUserIds.contains(user.userId);
        return _FollowUserTile(
          user: user,
          isFollowing: isFollowing,
          onFollowTap: () {
            ref
                .read(feedNotifierProvider.notifier)
                .toggleFollow(user.userId);
          },
          onTap: () {
            context.push(RoutePaths.userProfilePath(user.userId));
          },
        );
      },
    );
  }
}

/// 유저 정보 (영상에서 추출)
class _UserInfo {
  const _UserInfo({
    required this.userId,
    required this.nickname,
    required this.username,
    required this.avatarUrl,
  });

  final String userId;
  final String nickname;
  final String username;
  final String avatarUrl;
}

/// 팔로우 유저 타일
class _FollowUserTile extends StatelessWidget {
  const _FollowUserTile({
    required this.user,
    required this.isFollowing,
    required this.onFollowTap,
    required this.onTap,
  });

  final _UserInfo user;
  final bool isFollowing;
  final VoidCallback onFollowTap;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: AppColors.gray,
        backgroundImage: user.avatarUrl.isNotEmpty
            ? NetworkImage(user.avatarUrl)
            : null,
        child: user.avatarUrl.isEmpty
            ? const Icon(Icons.person, color: AppColors.whiteSecondary, size: 22)
            : null,
      ),
      title: Text(
        user.nickname,
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        '@${user.username}',
        style: const TextStyle(
          color: AppColors.whiteSecondary,
          fontSize: 13,
        ),
      ),
      trailing: GestureDetector(
        onTap: onFollowTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          decoration: BoxDecoration(
            color: isFollowing ? AppColors.gray : AppColors.primary,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            isFollowing
                ? AppStrings.userProfileFollowing
                : AppStrings.userProfileFollow,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
