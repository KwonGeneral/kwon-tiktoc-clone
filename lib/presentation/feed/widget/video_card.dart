import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

import 'package:supersent_tiktoc_clone/app/theme/app_colors.dart';
import 'package:supersent_tiktoc_clone/domain/entity/video.dart';
import 'package:supersent_tiktoc_clone/presentation/feed/provider/video_player_manager.dart';
import 'package:supersent_tiktoc_clone/presentation/feed/widget/video_overlay.dart';

class VideoCard extends ConsumerWidget {
  const VideoCard({
    required this.video,
    required this.index,
    super.key,
  });

  final Video video;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Manager의 state를 watch하여 controller 변경 시 rebuild
    final controllers = ref.watch(videoPlayerManagerProvider);
    final controller = controllers[index];

    return GestureDetector(
      onTap: () {
        ref.read(videoPlayerManagerProvider.notifier).togglePlayPause(index);
      },
      child: Container(
        color: AppColors.black,
        child: _buildContent(controller),
      ),
    );
  }

  Widget _buildContent(VideoPlayerController? controller) {
    if (controller == null || !controller.value.isInitialized) {
      return _buildLoading();
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        // 비디오 플레이어
        SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: controller.value.size.width,
              height: controller.value.size.height,
              child: VideoPlayer(controller),
            ),
          ),
        ),

        // 버퍼링 인디케이터
        if (controller.value.isBuffering)
          const CircularProgressIndicator(
            color: AppColors.white,
            strokeWidth: 2,
          ),

        // 일시정지 아이콘
        if (!controller.value.isPlaying && !controller.value.isBuffering)
          const Icon(
            Icons.play_arrow_rounded,
            color: AppColors.whiteSecondary,
            size: 72,
          ),

        // 오버레이 UI
        Positioned.fill(
          child: VideoOverlay(video: video),
        ),
      ],
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.white,
        strokeWidth: 2,
      ),
    );
  }
}
