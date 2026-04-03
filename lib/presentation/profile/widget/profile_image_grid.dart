import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:kwon_tiktoc_clone/app/theme/app_colors.dart';
import 'package:kwon_tiktoc_clone/domain/entity/post_image.dart';

class ProfileImageGrid extends StatelessWidget {
  const ProfileImageGrid({
    required this.images,
    this.onImageTap,
    this.onImageLongPress,
    super.key,
  });

  final List<PostImage> images;
  final void Function(PostImage image)? onImageTap;
  final void Function(PostImage image)? onImageLongPress;

  /// 외부에서 단일 이미지 썸네일을 사용할 수 있는 static builder
  static Widget buildThumbnail(PostImage image) =>
      _ImageThumbnail(image: image);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(1),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        final image = images[index];
        return GestureDetector(
          onTap: () => onImageTap?.call(image),
          onLongPress: () => onImageLongPress?.call(image),
          child: _ImageThumbnail(image: image),
        );
      },
    );
  }
}

class _ImageThumbnail extends StatelessWidget {
  const _ImageThumbnail({required this.image});

  final PostImage image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CachedNetworkImage(
          imageUrl: image.thumbUrl,
          fit: BoxFit.cover,
          placeholder: (_, _) => Container(
            color: AppColors.gray,
            child: const Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.whiteSecondary,
                ),
              ),
            ),
          ),
          errorWidget: (_, _, _) => Container(
            color: AppColors.gray,
            child: const Center(
              child: Icon(
                Icons.broken_image,
                color: AppColors.whiteSecondary,
                size: 28,
              ),
            ),
          ),
        ),
        // 이미지 아이콘 표시 (영상과 구분)
        const Positioned(
          top: 4,
          right: 4,
          child: Icon(Icons.image, color: AppColors.white, size: 16),
        ),
      ],
    );
  }
}
