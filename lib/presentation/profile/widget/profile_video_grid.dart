import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'package:kwon_tiktoc_clone/app/theme/app_colors.dart';
import 'package:kwon_tiktoc_clone/app/theme/app_text_styles.dart';
import 'package:kwon_tiktoc_clone/domain/entity/video.dart';

class ProfileVideoGrid extends StatelessWidget {
  const ProfileVideoGrid({
    required this.videos,
    this.onVideoTap,
    this.onVideoLongPress,
    super.key,
  });

  final List<Video> videos;
  final void Function(Video video)? onVideoTap;
  final void Function(Video video)? onVideoLongPress;

  @override
  Widget build(BuildContext context) {
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
      itemCount: videos.length,
      itemBuilder: (context, index) {
        final video = videos[index];
        return GestureDetector(
          onTap: () => onVideoTap?.call(video),
          onLongPress: () => onVideoLongPress?.call(video),
          child: _VideoThumbnail(key: ValueKey(video.id), video: video),
        );
      },
    );
  }
}

class _VideoThumbnail extends StatefulWidget {
  const _VideoThumbnail({super.key, required this.video});

  final Video video;

  @override
  State<_VideoThumbnail> createState() => _VideoThumbnailState();
}

class _VideoThumbnailState extends State<_VideoThumbnail>
    with AutomaticKeepAliveClientMixin {
  VideoPlayerController? _controller;
  bool _initialized = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initThumbnail();
  }

  Future<void> _initThumbnail() async {
    if (widget.video.videoUrl.isEmpty) return;

    final controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.video.videoUrl),
    );
    _controller = controller;

    try {
      await controller.initialize().timeout(const Duration(seconds: 10));
      if (mounted) {
        setState(() => _initialized = true);
      } else {
        controller.dispose();
        _controller = null;
      }
    } catch (_) {
      if (mounted) {
        // 초기화 실패 시 placeholder 유지
        _controller?.dispose();
        _controller = null;
      } else {
        controller.dispose();
        _controller = null;
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      fit: StackFit.expand,
      children: [
        if (_initialized && _controller != null)
          FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _controller!.value.size.width,
              height: _controller!.value.size.height,
              child: VideoPlayer(_controller!),
            ),
          )
        else if (widget.video.thumbnailUrl.isNotEmpty)
          Image.network(
            widget.video.thumbnailUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => _buildPlaceholder(),
          )
        else
          _buildPlaceholder(),
        // 하단 좋아요 표시
        Positioned(
          left: 4,
          bottom: 4,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.favorite, color: AppColors.white, size: 14),
              const SizedBox(width: 2),
              Text(
                _formatCount(widget.video.likeCount),
                style: AppTextStyles.profileLabel.copyWith(
                  color: AppColors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppColors.gray,
      child: const Center(
        child: Icon(
          Icons.videocam_outlined,
          color: AppColors.whiteSecondary,
          size: 28,
        ),
      ),
    );
  }

  String _formatCount(int count) {
    if (count >= 10000) {
      return '${(count / 10000).toStringAsFixed(1)}만';
    }
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}천';
    }
    return '$count';
  }
}
