import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/route/route_paths.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/format_utils.dart';
import '../../../domain/entity/post_image.dart';
import '../../../domain/entity/video.dart';
import '../../feed/provider/feed_provider.dart';
import '../../profile/provider/profile_provider.dart';
import '../../profile/widget/profile_image_grid.dart';
import '../../publish/provider/publish_image_provider.dart';
import '../widget/user_video_grid.dart';

class UserProfilePage extends ConsumerWidget {
  const UserProfilePage({required this.userId, super.key});

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedState = ref.watch(feedNotifierProvider).valueOrNull;
    if (feedState == null) {
      return const Scaffold(
        backgroundColor: AppColors.black,
        body: Center(child: CircularProgressIndicator(color: AppColors.white)),
      );
    }

    // 해당 유저의 영상들
    final userVideos = feedState.videos
        .where((v) => v.userId == userId)
        .toList();
    final firstVideo = userVideos.isNotEmpty ? userVideos.first : null;

    final nickname = firstVideo?.nickname ?? userId;
    final username = firstVideo?.username ?? userId;
    final defaultAvatarUrl = firstVideo?.avatarUrl ?? '';
    final isFollowing = feedState.followedUserIds.contains(userId);

    // API에서 프로필 이미지 조회
    final profileImageAsync = ref.watch(profileImageProvider(userId));
    final avatarUrl = profileImageAsync.valueOrNull ?? defaultAvatarUrl;

    // 총 좋아요 수 합산
    final totalLikes = userVideos.fold<int>(0, (sum, v) => sum + v.likeCount);

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => context.pop(),
        ),
        title: Text(nickname, style: AppTextStyles.profileName),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // 아바타
            CircleAvatar(
              radius: 44,
              backgroundColor: AppColors.gray,
              backgroundImage: avatarUrl.isNotEmpty
                  ? NetworkImage(avatarUrl)
                  : null,
              child: avatarUrl.isEmpty
                  ? const Icon(
                      Icons.person,
                      size: 44,
                      color: AppColors.whiteSecondary,
                    )
                  : null,
            ),
            const SizedBox(height: 8),
            // @username
            Text('@$username', style: AppTextStyles.profileId),
            const SizedBox(height: 16),
            // 팔로잉 / 팔로워 / 좋아요
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStat('-', AppStrings.profileFollowing),
                const SizedBox(width: 24),
                _buildStat('-', AppStrings.profileFollowers),
                const SizedBox(width: 24),
                _buildStat(
                  FormatUtils.compactNumber(totalLikes),
                  AppStrings.profileLikes,
                ),
              ],
            ),
            const SizedBox(height: 16),
            // 팔로우 / 메시지 버튼
            _buildActionButtons(ref, isFollowing),
            const SizedBox(height: 16),
            // 탭바 (동영상)
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.divider, width: 0.5),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.white, width: 1.5),
                  ),
                ),
                child: const Icon(
                  Icons.grid_view,
                  color: AppColors.white,
                  size: 22,
                ),
              ),
            ),
            // 영상 + 이미지 그리드
            _buildUserContent(context, ref, feedState, userVideos),
          ],
        ),
      ),
    );
  }

  Widget _buildUserContent(
    BuildContext context,
    WidgetRef ref,
    dynamic feedState,
    List<Video> userVideos,
  ) {
    final imagesAsync = ref.watch(postImageListNotifierProvider);
    final userImages = imagesAsync.maybeWhen(
      data: (images) => images.where((img) => img.userId == userId).toList(),
      orElse: () => <PostImage>[],
    );

    if (userVideos.isEmpty && userImages.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Column(
          children: [
            Icon(
              Icons.videocam_off_outlined,
              size: 64,
              color: AppColors.whiteSecondary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              AppStrings.feedEmpty,
              style: AppTextStyles.description.copyWith(
                color: AppColors.whiteSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        if (userVideos.isNotEmpty)
          UserVideoGrid(
            videos: userVideos,
            onVideoTap: (video) {
              final index = feedState.videos.indexWhere(
                (v) => v.id == video.id,
              );
              if (index < 0) return;
              ref.read(feedNotifierProvider.notifier).updateCurrentIndex(index);
              context.go(RoutePaths.feed);
            },
          ),
        if (userImages.isNotEmpty)
          ProfileImageGrid(
            images: userImages,
            onImageTap: (image) {
              context.push(RoutePaths.imageDetailPath(image.id), extra: image);
            },
          ),
      ],
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(value, style: AppTextStyles.profileCount),
        const SizedBox(height: 2),
        Text(label, style: AppTextStyles.profileLabel),
      ],
    );
  }

  Widget _buildActionButtons(WidgetRef ref, bool isFollowing) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: GestureDetector(
        onTap: () {
          ref.read(feedNotifierProvider.notifier).toggleFollow(userId);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 10),
          decoration: BoxDecoration(
            color: isFollowing ? AppColors.gray : AppColors.primary,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            isFollowing
                ? AppStrings.userProfileFollowing
                : AppStrings.userProfileFollow,
            style: AppTextStyles.description.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
