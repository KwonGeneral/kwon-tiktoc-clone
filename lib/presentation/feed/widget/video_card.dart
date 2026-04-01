import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'package:supersent_tiktoc_clone/app/theme/app_colors.dart';
import 'package:supersent_tiktoc_clone/domain/entity/video.dart';

class VideoCard extends StatefulWidget {
  const VideoCard({
    required this.video,
    super.key,
  });

  final Video video;

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late final VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.video.videoUrl),
    )..initialize().then((_) {
        if (mounted) {
          setState(() {
            _isInitialized = true;
          });
          _controller.setLooping(true);
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.black,
      child: _isInitialized ? _buildVideoPlayer() : _buildLoading(),
    );
  }

  Widget _buildVideoPlayer() {
    return Center(
      child: AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: VideoPlayer(_controller),
      ),
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
