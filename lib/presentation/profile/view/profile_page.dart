import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/route/route_paths.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../core/constants/app_strings.dart';
import '../../../domain/entity/video.dart';
import '../../feed/provider/feed_provider.dart';
import '../provider/profile_provider.dart';
import '../widget/profile_header.dart';
import '../widget/profile_stats.dart';
import '../widget/profile_tab_bar.dart';
import '../widget/profile_video_grid.dart';

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
              ProfileStats(user: user),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
    if (videos.isEmpty) {
      return _buildEmptyState(
        icon: Icons.photo_camera_back_outlined,
        message: AppStrings.profileEmptyMyVideos,
        showUploadButton: true,
      );
    }
    return ProfileVideoGrid(videos: videos, onVideoTap: _navigateToVideo);
  }

  Widget _buildBookmarksTab() {
    final videos = ref.watch(bookmarkedVideosProvider);
    if (videos.isEmpty) {
      return _buildEmptyState(
        icon: Icons.bookmark_border,
        message: AppStrings.profileEmptyBookmarks,
      );
    }
    return ProfileVideoGrid(videos: videos, onVideoTap: _navigateToVideo);
  }

  Widget _buildLikesTab() {
    final videos = ref.watch(likedVideosProvider);
    if (videos.isEmpty) {
      return _buildEmptyState(
        icon: Icons.favorite_border,
        message: AppStrings.profileEmptyLikes,
      );
    }
    return ProfileVideoGrid(videos: videos, onVideoTap: _navigateToVideo);
  }

  void _navigateToVideo(Video video) {
    final feedState = ref.read(feedNotifierProvider).valueOrNull;
    if (feedState == null) return;

    final index = feedState.videos.indexWhere((v) => v.id == video.id);
    if (index < 0) return;

    ref.read(feedNotifierProvider.notifier).updateCurrentIndex(index);
    context.go(RoutePaths.feed);
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    AppStrings.profileUpload,
                    style: AppTextStyles.description
                        .copyWith(fontWeight: FontWeight.w600),
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
