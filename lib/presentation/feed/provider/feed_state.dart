import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:kwon_tiktoc_clone/domain/entity/video.dart';

part 'feed_state.freezed.dart';

/// 피드 탭 종류
enum FeedTab { following, recommend }

@freezed
sealed class FeedState with _$FeedState {
  const FeedState._();

  const factory FeedState({
    @Default([]) List<Video> videos,
    @Default(0) int currentIndex,
    @Default(0) int currentPage,
    @Default(false) bool hasMore,
    @Default({}) Set<String> followedUserIds,
    @Default(false) bool isLoadingMore,
    String? loadMoreError,
    @Default(FeedTab.recommend) FeedTab selectedTab,
  }) = _FeedState;

  /// 현재 탭에 맞는 영상 목록
  List<Video> get displayVideos {
    if (selectedTab == FeedTab.following) {
      return videos
          .where((v) => followedUserIds.contains(v.userId))
          .toList();
    }
    return videos;
  }
}
