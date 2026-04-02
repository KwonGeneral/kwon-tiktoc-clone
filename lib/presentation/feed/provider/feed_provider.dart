import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:kwon_tiktoc_clone/core/constants/app_constants.dart';
import 'package:kwon_tiktoc_clone/core/di/providers.dart';
import 'package:kwon_tiktoc_clone/domain/entity/video.dart';
import 'package:kwon_tiktoc_clone/domain/repository/local_storage_repository.dart';
import 'package:kwon_tiktoc_clone/domain/usecase/get_video_feed.dart';
import 'package:kwon_tiktoc_clone/domain/usecase/toggle_bookmark.dart';
import 'package:kwon_tiktoc_clone/domain/usecase/toggle_like.dart';
import 'package:kwon_tiktoc_clone/presentation/feed/provider/feed_state.dart';

part 'feed_provider.g.dart';

@Riverpod(keepAlive: true)
class FeedNotifier extends _$FeedNotifier {
  late final LocalStorageRepository _storage;

  @override
  Future<FeedState> build() async {
    _storage = ref.read(localStorageRepositoryProvider);
    return _loadInitial();
  }

  List<Video> _applyLocalStates(List<Video> videos) {
    final likedIds = _storage.getLikedVideoIds();
    final bookmarkedIds = _storage.getBookmarkedVideoIds();

    return videos.map((video) {
      final wasLiked = likedIds.contains(video.id);
      final wasBookmarked = bookmarkedIds.contains(video.id);
      if (!wasLiked && !wasBookmarked) return video;
      return video.copyWith(
        isLiked: wasLiked || video.isLiked,
        likeCount: wasLiked && !video.isLiked
            ? video.likeCount + 1
            : video.likeCount,
        isBookmarked: wasBookmarked || video.isBookmarked,
        bookmarkCount: wasBookmarked && !video.isBookmarked
            ? video.bookmarkCount + 1
            : video.bookmarkCount,
      );
    }).toList();
  }

  Future<FeedState> _loadInitial() async {
    final repository = ref.read(videoRepositoryProvider);
    final getVideoFeed = GetVideoFeed(repository);
    final videos = await getVideoFeed(page: 0);
    final localVideos = _applyLocalStates(videos);
    final followedUserIds = _storage.getFollowedUserIds();

    return FeedState(
      videos: localVideos,
      currentPage: 0,
      hasMore: videos.length >= AppConstants.videoPageSize,
      followedUserIds: followedUserIds,
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

    // 로컬 저장
    final likedIds = _storage.getLikedVideoIds();
    if (likedIds.contains(videoId)) {
      likedIds.remove(videoId);
    } else {
      likedIds.add(videoId);
    }
    await _storage.saveLikedVideoIds(likedIds);

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
        bookmarkCount: video.isBookmarked
            ? video.bookmarkCount - 1
            : video.bookmarkCount + 1,
      );
    }).toList();
    state = AsyncData(currentState.copyWith(videos: updatedVideos));

    // 로컬 저장
    final bookmarkedIds = _storage.getBookmarkedVideoIds();
    if (bookmarkedIds.contains(videoId)) {
      bookmarkedIds.remove(videoId);
    } else {
      bookmarkedIds.add(videoId);
    }
    await _storage.saveBookmarkedVideoIds(bookmarkedIds);

    // 서버 동기화
    final repository = ref.read(videoRepositoryProvider);
    final toggleBookmark = ToggleBookmark(repository);
    await toggleBookmark(videoId);
  }

  Future<void> loadMore() async {
    final currentState = state.valueOrNull;
    if (currentState == null) return;
    if (currentState.isLoadingMore || !currentState.hasMore) return;

    state = AsyncData(
      currentState.copyWith(isLoadingMore: true, loadMoreError: null),
    );

    try {
      final repository = ref.read(videoRepositoryProvider);
      final getVideoFeed = GetVideoFeed(repository);
      final nextPage = currentState.currentPage + 1;
      final newVideos = await getVideoFeed(page: nextPage);
      final localNewVideos = _applyLocalStates(newVideos);

      final updatedState = state.valueOrNull;
      if (updatedState == null) return;

      state = AsyncData(
        updatedState.copyWith(
          videos: [...updatedState.videos, ...localNewVideos],
          currentPage: nextPage,
          hasMore: newVideos.length >= AppConstants.videoPageSize,
          isLoadingMore: false,
        ),
      );
    } on Exception catch (e) {
      final updatedState = state.valueOrNull;
      if (updatedState == null) return;

      state = AsyncData(
        updatedState.copyWith(
          isLoadingMore: false,
          loadMoreError: e.toString(),
        ),
      );
    }
  }

  Future<void> toggleFollow(String userId) async {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    final updatedFollowed = {...currentState.followedUserIds};
    if (updatedFollowed.contains(userId)) {
      updatedFollowed.remove(userId);
    } else {
      updatedFollowed.add(userId);
    }
    state = AsyncData(currentState.copyWith(followedUserIds: updatedFollowed));

    // 로컬 저장
    await _storage.saveFollowedUserIds(updatedFollowed);
  }

  void incrementCommentCount(String videoId) {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    final updatedVideos = currentState.videos.map((video) {
      if (video.id != videoId) return video;
      return video.copyWith(commentCount: video.commentCount + 1);
    }).toList();
    state = AsyncData(currentState.copyWith(videos: updatedVideos));
  }
}
