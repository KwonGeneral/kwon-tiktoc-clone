import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kwon_tiktoc_clone/domain/entity/video.dart';
import 'package:kwon_tiktoc_clone/presentation/feed/provider/feed_provider.dart';
import 'package:kwon_tiktoc_clone/presentation/feed/widget/comment_bottom_sheet.dart';
import 'package:kwon_tiktoc_clone/presentation/feed/widget/music_info.dart';
import 'package:kwon_tiktoc_clone/presentation/feed/widget/side_action_bar.dart';
import 'package:kwon_tiktoc_clone/presentation/feed/widget/top_tab_bar.dart';
import 'package:kwon_tiktoc_clone/presentation/feed/widget/video_description.dart';

class VideoOverlay extends ConsumerWidget {
  const VideoOverlay({required this.video, super.key});

  final Video video;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        // 상단 탭바
        const Positioned(top: 0, left: 0, right: 0, child: TopTabBar()),

        // 우측 사이드 액션바
        Positioned(
          right: 0,
          bottom: 100,
          child: SideActionBar(
            video: video,
            isFollowing:
                ref
                    .watch(feedNotifierProvider)
                    .valueOrNull
                    ?.followedUserIds
                    .contains(video.userId) ??
                false,
            onLikeTap: () {
              ref.read(feedNotifierProvider.notifier).toggleLike(video.id);
            },
            onBookmarkTap: () {
              ref.read(feedNotifierProvider.notifier).toggleBookmark(video.id);
            },
            onCommentTap: () {
              CommentBottomSheet.show(context, video.id);
            },
            onFollowTap: () {
              ref
                  .read(feedNotifierProvider.notifier)
                  .toggleFollow(video.userId);
            },
          ),
        ),

        // 하단 영역 (유저 정보 + 음악 정보)
        Positioned(
          left: 12,
          right: 72,
          bottom: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              VideoDescription(video: video),
              const SizedBox(height: 8),
              MusicInfo(musicName: video.musicName),
            ],
          ),
        ),
      ],
    );
  }
}
