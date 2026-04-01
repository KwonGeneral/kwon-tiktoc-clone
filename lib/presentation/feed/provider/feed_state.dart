import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:supersent_tiktoc_clone/domain/entity/video.dart';

part 'feed_state.freezed.dart';

@freezed
sealed class FeedState with _$FeedState {
  const factory FeedState({
    @Default([]) List<Video> videos,
    @Default(0) int currentIndex,
    @Default(0) int currentPage,
    @Default(false) bool hasMore,
    @Default({}) Set<String> followedUserIds,
  }) = _FeedState;
}
