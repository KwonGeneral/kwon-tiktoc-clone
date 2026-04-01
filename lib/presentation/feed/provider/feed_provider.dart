import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:supersent_tiktoc_clone/core/constants/app_constants.dart';
import 'package:supersent_tiktoc_clone/core/di/providers.dart';
import 'package:supersent_tiktoc_clone/presentation/feed/provider/feed_state.dart';

part 'feed_provider.g.dart';

@Riverpod(keepAlive: true)
class FeedNotifier extends _$FeedNotifier {
  @override
  Future<FeedState> build() async {
    return _loadInitial();
  }

  Future<FeedState> _loadInitial() async {
    final getVideoFeed = ref.read(getVideoFeedProvider);
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
}
