import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:supersent_tiktoc_clone/core/constants/app_constants.dart';
import 'package:supersent_tiktoc_clone/core/di/providers.dart';
import 'package:supersent_tiktoc_clone/domain/usecase/get_video_feed.dart';
import 'package:supersent_tiktoc_clone/domain/usecase/toggle_bookmark.dart';
import 'package:supersent_tiktoc_clone/domain/usecase/toggle_like.dart';
import 'package:supersent_tiktoc_clone/presentation/feed/provider/feed_state.dart';

part 'feed_provider.g.dart';

@Riverpod(keepAlive: true)
class FeedNotifier extends _$FeedNotifier {
  @override
  Future<FeedState> build() async {
    return _loadInitial();
  }

  Future<FeedState> _loadInitial() async {
    final repository = ref.read(videoRepositoryProvider);
    final getVideoFeed = GetVideoFeed(repository);
    final videos = await getVideoFeed(page: 0);

    return FeedState(
      videos: videos,
      currentPage: 0,
      hasMore: videos.length >= AppConstants.videoPageSize,
    );
  }

  void updateCurrentIndex(int index) {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    state = AsyncData(currentState.copyWith(currentIndex: index));
  }

  Future<void> toggleLike(String videoId) async {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    // 낙관적 업데이트
    final updatedVideos = currentState.videos.map((video) {
      if (video.id != videoId) return video;
      return video.copyWith(
        isLiked: !video.isLiked,
        likeCount: video.isLiked ? video.likeCount - 1 : video.likeCount + 1,
      );
    }).toList();
    state = AsyncData(currentState.copyWith(videos: updatedVideos));

    // 서버 동기화
    final repository = ref.read(videoRepositoryProvider);
    final toggleLike = ToggleLike(repository);
    await toggleLike(videoId);
  }

  Future<void> toggleBookmark(String videoId) async {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    // 낙관적 업데이트
    final updatedVideos = currentState.videos.map((video) {
      if (video.id != videoId) return video;
      return video.copyWith(
        isBookmarked: !video.isBookmarked,
        bookmarkCount:
            video.isBookmarked
                ? video.bookmarkCount - 1
                : video.bookmarkCount + 1,
      );
    }).toList();
    state = AsyncData(currentState.copyWith(videos: updatedVideos));

    // 서버 동기화
    final repository = ref.read(videoRepositoryProvider);
    final toggleBookmark = ToggleBookmark(repository);
    await toggleBookmark(videoId);
  }

  void toggleFollow(String userId) {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    final updatedFollowed = {...currentState.followedUserIds};
    if (updatedFollowed.contains(userId)) {
      updatedFollowed.remove(userId);
    } else {
      updatedFollowed.add(userId);
    }
    state = AsyncData(
      currentState.copyWith(followedUserIds: updatedFollowed),
    );
  }

}
