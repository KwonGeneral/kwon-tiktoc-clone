import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_compress/video_compress.dart';

import 'package:kwon_tiktoc_clone/app/theme/app_colors.dart';

class PublishCoverThumbnail extends StatefulWidget {
  const PublishCoverThumbnail({super.key, required this.videoFilePath});

  final String videoFilePath;

  @override
  State<PublishCoverThumbnail> createState() => _PublishCoverThumbnailState();
}

class _PublishCoverThumbnailState extends State<PublishCoverThumbnail> {
  File? _thumbnail;

  @override
  void initState() {
    super.initState();
    _generateThumbnail();
  }

  Future<void> _generateThumbnail() async {
    try {
      final file = await VideoCompress.getFileThumbnail(
        widget.videoFilePath,
        quality: 50,
        position: -1,
      );
      if (mounted) {
        setState(() => _thumbnail = file);
      }
    } catch (_) {
      // 썸네일 생성 실패 시 기본 아이콘 표시
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      child: _thumbnail != null
          ? Image.file(_thumbnail!, fit: BoxFit.cover)
          : const Center(
              child: Icon(Icons.videocam, color: AppColors.grey, size: 32),
            ),
    );
  }
}
