import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

import 'package:kwon_tiktoc_clone/app/theme/app_colors.dart';
import 'package:kwon_tiktoc_clone/domain/entity/video.dart';
import 'package:kwon_tiktoc_clone/presentation/feed/provider/comment_provider.dart';
import 'package:kwon_tiktoc_clone/presentation/feed/provider/feed_provider.dart';
import 'package:kwon_tiktoc_clone/presentation/feed/provider/video_player_manager.dart';
import 'package:kwon_tiktoc_clone/presentation/feed/widget/comment_bottom_sheet.dart';
import 'package:kwon_tiktoc_clone/presentation/feed/widget/like_animation.dart';
import 'package:kwon_tiktoc_clone/presentation/feed/widget/video_overlay.dart';

class VideoCard extends ConsumerStatefulWidget {
  const VideoCard({required this.video, required this.index, super.key});

  final Video video;
  final int index;

  @override
  ConsumerState<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends ConsumerState<VideoCard>
    with SingleTickerProviderStateMixin {
  bool _showLikeAnimation = false;
  late final AnimationController _commentAnimController;
  late final Animation<double> _commentSlideAnimation;
  bool _showCommentView = false;
  bool _animScheduled = false;

  @override
  void initState() {
    super.initState();
    _commentAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _commentSlideAnimation = CurvedAnimation(
      parent: _commentAnimController,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
    _commentAnimController.addListener(_onAnimationTick);
    _commentAnimController.addStatusListener((status) {
      _animScheduled = false;
      if (status == AnimationStatus.dismissed && mounted) {
        setState(() => _showCommentView = false);
      }
    });
  }

  void _handleDoubleTap() {
    if (!widget.video.isLiked) {
      ref.read(feedNotifierProvider.notifier).toggleLike(widget.video.id);
    }
    setState(() => _showLikeAnimation = true);
  }

  void _onAnimationTick() {
    // AnimatedBuilder가 아닌 위젯 영역은 최소한만 갱신
  }

  @override
  void dispose() {
    _commentAnimController.removeListener(_onAnimationTick);
    _commentAnimController.dispose();
    super.dispose();
  }

  void _openCommentAnim() {
    setState(() => _showCommentView = true);
    _commentAnimController.forward();
  }

  void _closeCommentAnim() {
    _commentAnimController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final controllers = ref.watch(videoPlayerManagerProvider);
    final controller = controllers[widget.index];
    final commentState = ref.watch(commentNotifierProvider);
    final isCommentOpen =
        commentState.isOpen && commentState.videoId == widget.video.id;

    // 댓글 열기/닫기 애니메이션 트리거 (중복 스케줄 방지)
    if (isCommentOpen && !_showCommentView && !_animScheduled) {
      _animScheduled = true;
      WidgetsBinding.instance.addPostFrameCallback((_) => _openCommentAnim());
    } else if (!isCommentOpen && _showCommentView && !_animScheduled) {
      _animScheduled = true;
      WidgetsBinding.instance.addPostFrameCallback((_) => _closeCommentAnim());
    }

    return GestureDetector(
      onTap: () {
        if (isCommentOpen) return;
        ref
            .read(videoPlayerManagerProvider.notifier)
            .togglePlayPause(widget.index);
      },
      onDoubleTap: isCommentOpen ? null : _handleDoubleTap,
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (!_showCommentView) {
            return Container(
              color: AppColors.black,
              child: _buildContent(controller),
            );
          }
          return AnimatedBuilder(
            animation: _commentSlideAnimation,
            builder: (context, _) {
              return Container(
                color: AppColors.black,
                child: _buildWithComments(
                  controller,
                  constraints.maxHeight,
                ),
              );
            },
          );
        },
      ),
    );
  }

  /// 댓글창이 열렸을 때: 영상 축소 + 댓글 (슬라이드 애니메이션)
  Widget _buildWithComments(
    VideoPlayerController? controller,
    double availableHeight,
  ) {
    final videoHeight = availableHeight * 0.38;
    final commentHeight = availableHeight - videoHeight;
    final progress = _commentSlideAnimation.value;
    final currentVideoHeight = availableHeight - (commentHeight * progress);

    return Column(
      children: [
        // 영상 (전체 → 38%로 축소)
        SizedBox(
          height: currentVideoHeight,
          child: Stack(
            children: [
              if (controller != null && controller.value.isInitialized)
                SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: SizedBox(
                      width: controller.value.size.width,
                      height: controller.value.size.height,
                      child: VideoPlayer(controller),
                    ),
                  ),
                )
              else
                _buildLoading(),
              // 닫기 버튼
              if (progress > 0.3)
                Positioned(
                  top: MediaQuery.of(context).padding.top + 8,
                  right: 12,
                  child: Opacity(
                    opacity: ((progress - 0.3) / 0.7).clamp(0.0, 1.0),
                    child: GestureDetector(
                      onTap: () =>
                          ref.read(commentNotifierProvider.notifier).close(),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.black.withValues(alpha: 0.5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: AppColors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        // 댓글 영역 (하단에서 슬라이드 업)
        SizedBox(
          height: commentHeight * progress,
          child: progress > 0.1
              ? ClipRect(
                  child: OverflowBox(
                    alignment: Alignment.topCenter,
                    maxHeight: commentHeight,
                    child: SizedBox(
                      height: commentHeight,
                      child: CommentInlineView(videoId: widget.video.id),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildContent(VideoPlayerController? controller) {
    if (controller == null || !controller.value.isInitialized) {
      if (controller != null && controller.value.hasError) {
        return _buildVideoError();
      }
      return _buildLoading();
    }

    return ValueListenableBuilder<VideoPlayerValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // 비디오 플레이어
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: value.size.width,
                  height: value.size.height,
                  child: VideoPlayer(controller),
                ),
              ),
            ),

            // 버퍼링 인디케이터 (재생 중이 아닐 때만)
            if (value.isBuffering && !value.isPlaying)
              const CircularProgressIndicator(
                color: AppColors.white,
                strokeWidth: 2,
              ),

            // 일시정지 아이콘
            if (!value.isPlaying && !value.isBuffering)
              const Icon(
                Icons.play_arrow_rounded,
                color: AppColors.whiteSecondary,
                size: 72,
              ),

            // 오버레이 UI
            Positioned.fill(child: VideoOverlay(video: widget.video)),

            // 더블탭 좋아요 애니메이션
            if (_showLikeAnimation)
              LikeAnimation(
                onCompleted: () {
                  if (mounted) {
                    setState(() => _showLikeAnimation = false);
                  }
                },
              ),
          ],
        );
      },
    );
  }

  Widget _buildVideoError() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, color: AppColors.whiteSecondary, size: 48),
          SizedBox(height: 8),
          Text(
            '영상을 재생할 수 없습니다',
            style: TextStyle(color: AppColors.whiteSecondary, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    final thumbnailUrl = widget.video.thumbnailUrl;
    final isLocalFile = thumbnailUrl.isNotEmpty && !thumbnailUrl.startsWith('http');
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        if (thumbnailUrl.isNotEmpty)
          isLocalFile
              ? Image.file(
                  File(thumbnailUrl),
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const SizedBox.shrink(),
                )
              : Image.network(
                  thumbnailUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const SizedBox.shrink(),
                ),
        const Center(
          child: CircularProgressIndicator(
            color: AppColors.white,
            strokeWidth: 2,
          ),
        ),
      ],
    );
  }
}
