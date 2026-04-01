import 'package:flutter/material.dart';

import 'package:supersent_tiktoc_clone/app/theme/app_colors.dart';
import 'package:supersent_tiktoc_clone/app/theme/app_text_styles.dart';

class MusicInfo extends StatefulWidget {
  const MusicInfo({required this.musicName, super.key});

  final String musicName;

  @override
  State<MusicInfo> createState() => _MusicInfoState();
}

class _MusicInfoState extends State<MusicInfo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1, 0),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.music_note, color: AppColors.white, size: 16),
        const SizedBox(width: 6),
        Expanded(
          child: ClipRect(
            child: SlideTransition(
              position: _animation,
              child: Row(
                children: [
                  Text(
                    '${widget.musicName}    ${widget.musicName}',
                    style: AppTextStyles.musicInfo,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
