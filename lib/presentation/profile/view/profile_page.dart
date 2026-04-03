import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:kwon_tiktoc_clone/app/route/route_paths.dart';
import 'package:kwon_tiktoc_clone/app/theme/app_colors.dart';
import 'package:kwon_tiktoc_clone/app/theme/app_text_styles.dart';
import 'package:kwon_tiktoc_clone/core/constants/app_strings.dart';
import 'package:kwon_tiktoc_clone/presentation/profile/view/follow_list_page.dart';
import 'package:kwon_tiktoc_clone/domain/entity/post_image.dart';
import 'package:kwon_tiktoc_clone/domain/entity/video.dart';
import 'package:kwon_tiktoc_clone/presentation/feed/provider/feed_provider.dart';
import 'package:kwon_tiktoc_clone/presentation/feed/provider/feed_state.dart';
import 'package:kwon_tiktoc_clone/presentation/profile/provider/profile_provider.dart';
import 'package:kwon_tiktoc_clone/presentation/publish/provider/publish_image_provider.dart' show postImageListNotifierProvider;
import 'package:kwon_tiktoc_clone/presentation/profile/widget/profile_header.dart';
import 'package:kwon_tiktoc_clone/presentation/profile/widget/profile_image_grid.dart';
import 'package:kwon_tiktoc_clone/presentation/profile/widget/profile_stats.dart';
import 'package:kwon_tiktoc_clone/presentation/profile/widget/profile_tab_bar.dart';
import 'package:kwon_tiktoc_clone/presentation/profile/widget/profile_video_grid.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(currentUserProvider);

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: _buildAppBar(),
      body: userAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.white),
        ),
        error: (error, _) => const Center(
          child: Text(AppStrings.feedError, style: AppTextStyles.description),
        ),
        data: (user) => SingleChildScrollView(
          child: Column(
            children: [
              ProfileHeader(user: user),
              const SizedBox(height: 16),
              ProfileStats(
                user: user,
                onFollowingTap: () => context.push(
                  RoutePaths.followList,
                  extra: FollowListTab.following,
                ),
                onFollowersTap: () => context.push(
                  RoutePaths.followList,
                  extra: FollowListTab.followers,
                ),
              ),
              const SizedBox(height: 16),
              _buildBioRow(user.bio, user.nickname),
              const SizedBox(height: 16),
              ProfileTabBar(
                selectedIndex: _selectedTabIndex,
                onTap: (index) => setState(() => _selectedTabIndex = index),
              ),
              _buildTabContent(),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.black,
      elevation: 0,
      automaticallyImplyLeading: false,
      actions: [
        GestureDetector(
          onTap: () => context.push(RoutePaths.settings),
          child: const Icon(Icons.menu, color: AppColors.white, size: 24),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildBioRow(String bio, String nickname) {
    if (bio.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Text(
          bio,
          style: AppTextStyles.description.copyWith(
            color: AppColors.whiteSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: GestureDetector(
              onTap: () => context.push(
                RoutePaths.profileEdit,
                extra: {'nickname': nickname, 'bio': ''},
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.gray,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  AppStrings.profileAddBio,
                  style: AppTextStyles.profileLabel.copyWith(
                    color: AppColors.whiteSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.gray,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.favorite,
                    size: 14,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      AppStrings.profileInterests,
                      style: AppTextStyles.profileLabel.copyWith(
                        color: AppColors.whiteSecondary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTabIndex) {
      case 0:
        return _buildMyVideosTab();
      case 1:
        return _buildBookmarksTab();
      case 2:
        return _buildLikesTab();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildMyVideosTab() {
    final videos = ref.watch(myVideosProvider);
    final images = ref.watch(myPostImagesProvider);
    if (videos.isEmpty && images.isEmpty) {
      return _buildEmptyState(
        icon: Icons.photo_camera_back_outlined,
        message: AppStrings.profileEmptyMyVideos,
        showUploadButton: true,
      );
    }

    // 비디오와 이미지를 createdAt 기준 내림차순 통합
    final items = <_ProfileGridItem>[
      for (final v in videos) _ProfileGridItem.video(v),
      for (final img in images) _ProfileGridItem.image(img),
    ]..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(1),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 9 / 16,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return item.when(
          video: (video) => GestureDetector(
            onTap: () => _navigateToVideo(video),
            onLongPress: () => _showDeleteVideoDialog(video),
            child: ProfileVideoGrid.buildThumbnail(video),
          ),
          image: (image) => GestureDetector(
            onTap: () => _navigateToImageDetail(image),
            onLongPress: () => _showDeleteImageDialog(image),
            child: ProfileImageGrid.buildThumbnail(image),
          ),
        );
      },
    );
  }

  Widget _buildBookmarksTab() {
    final videos = ref.watch(bookmarkedVideosProvider);
    if (videos.isEmpty) {
      return _buildEmptyState(
        icon: Icons.bookmark_border,
        message: AppStrings.profileEmptyBookmarks,
      );
    }
    return ProfileVideoGrid(
      key: const ValueKey('bookmarks'),
      videos: videos,
      onVideoTap: _navigateToVideo,
    );
  }

  Widget _buildLikesTab() {
    final videos = ref.watch(likedVideosProvider);
    if (videos.isEmpty) {
      return _buildEmptyState(
        icon: Icons.favorite_border,
        message: AppStrings.profileEmptyLikes,
      );
    }
    return ProfileVideoGrid(
      key: const ValueKey('likes'),
      videos: videos,
      onVideoTap: _navigateToVideo,
    );
  }

  void _navigateToVideo(Video video) {
    final feedState = ref.read(feedNotifierProvider).valueOrNull;
    if (feedState == null) return;

    final index = feedState.videos.indexWhere((v) => v.id == video.id);
    if (index < 0) return;

    // 추천 탭으로 전환하여 전체 영상 목록과 index가 정확히 일치하도록 처리
    if (feedState.selectedTab != FeedTab.recommend) {
      ref.read(feedNotifierProvider.notifier).selectTab(FeedTab.recommend);
    }
    ref.read(feedNotifierProvider.notifier).updateCurrentIndex(index);
    context.go(RoutePaths.feed);
  }

  void _navigateToImageDetail(PostImage image) {
    context.push(RoutePaths.imageDetailPath(image.id), extra: image);
  }

  Future<void> _showDeleteVideoDialog(Video video) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.darkGray,
        title: const Text('영상 삭제', style: TextStyle(color: AppColors.white)),
        content: const Text(
          '이 영상을 삭제하시겠습니까?\n삭제하면 복구할 수 없습니다.',
          style: TextStyle(color: AppColors.whiteSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('취소', style: TextStyle(color: AppColors.whiteSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('삭제', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      ref.read(feedNotifierProvider.notifier).deleteVideo(video.id);
    }
  }

  Future<void> _showDeleteImageDialog(PostImage image) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.darkGray,
        title: const Text('이미지 삭제', style: TextStyle(color: AppColors.white)),
        content: const Text(
          '이 이미지를 삭제하시겠습니까?\n삭제하면 복구할 수 없습니다.',
          style: TextStyle(color: AppColors.whiteSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('취소', style: TextStyle(color: AppColors.whiteSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('삭제', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      ref.read(postImageListNotifierProvider.notifier).deleteImage(image.id);
    }
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String message,
    bool showUploadButton = false,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 64,
              color: AppColors.whiteSecondary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: AppTextStyles.description,
              textAlign: TextAlign.center,
            ),
            if (showUploadButton) ...[
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => context.push(RoutePaths.camera),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    AppStrings.profileUpload,
                    style: AppTextStyles.description.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// 프로필 그리드에서 비디오/이미지를 통합 정렬하기 위한 간단한 union 타입
class _ProfileGridItem {
  _ProfileGridItem.video(Video video)
      : _video = video,
        _image = null,
        createdAt = video.createdAt;

  _ProfileGridItem.image(PostImage image)
      : _video = null,
        _image = image,
        createdAt = image.createdAt;

  final Video? _video;
  final PostImage? _image;
  final DateTime createdAt;

  T when<T>({
    required T Function(Video video) video,
    required T Function(PostImage image) image,
  }) {
    if (_video != null) return video(_video);
    return image(_image!);
  }
}
