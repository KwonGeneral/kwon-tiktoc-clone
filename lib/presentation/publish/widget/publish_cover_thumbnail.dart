import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_compress/video_compress.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/constants/app_strings.dart';

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
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (_thumbnail != null)
            Image.file(_thumbnail!, fit: BoxFit.cover)
          else
            const Center(
              child: Icon(Icons.videocam, color: Colors.grey, size: 32),
            ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              color: AppColors.overlay,
              child: const Text(
                AppStrings.publishCoverEdit,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
