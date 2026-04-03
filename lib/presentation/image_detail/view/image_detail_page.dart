import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:kwon_tiktoc_clone/app/theme/app_colors.dart';
import 'package:kwon_tiktoc_clone/app/theme/app_font_sizes.dart';
import 'package:kwon_tiktoc_clone/core/constants/app_strings.dart';
import 'package:kwon_tiktoc_clone/domain/entity/post_image.dart';

class ImageDetailPage extends StatelessWidget {
  const ImageDetailPage({super.key, required this.postImage});

  final PostImage postImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          AppStrings.imageDetailTitle,
          style: TextStyle(
            color: AppColors.white,
            fontSize: AppFontSizes.subtitle,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: InteractiveViewer(
              minScale: 0.5,
              maxScale: 3.0,
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: postImage.fullUrl,
                  fit: BoxFit.contain,
                  placeholder: (_, _) => const Center(
                    child: CircularProgressIndicator(color: AppColors.white),
                  ),
                  errorWidget: (_, _, _) => const Center(
                    child: Icon(
                      Icons.broken_image,
                      color: AppColors.whiteSecondary,
                      size: 48,
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (postImage.caption.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: AppColors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (postImage.nickname.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        postImage.nickname,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: AppFontSizes.bodyMd,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  Text(
                    postImage.caption,
                    style: const TextStyle(
                      color: AppColors.whiteSecondary,
                      fontSize: AppFontSizes.bodyMd,
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
