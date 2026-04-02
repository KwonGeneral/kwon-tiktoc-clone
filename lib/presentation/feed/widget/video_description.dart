import 'package:flutter/material.dart';

import 'package:kwon_tiktoc_clone/app/theme/app_colors.dart';
import 'package:kwon_tiktoc_clone/app/theme/app_text_styles.dart';
import 'package:kwon_tiktoc_clone/core/constants/app_strings.dart';
import 'package:kwon_tiktoc_clone/domain/entity/video.dart';

class VideoDescription extends StatefulWidget {
  const VideoDescription({required this.video, super.key});

  final Video video;

  @override
  State<VideoDescription> createState() => _VideoDescriptionState();
}

class _VideoDescriptionState extends State<VideoDescription> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // 유저명
        Row(
          children: [
            Text(
              '@user_${widget.video.userId}',
              style: AppTextStyles.username,
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.verified,
              color: AppColors.secondary,
              size: 14,
            ),
          ],
        ),
        const SizedBox(height: 6),

        // 설명 텍스트
        GestureDetector(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: _isExpanded
              ? Text(
                  widget.video.description,
                  style: AppTextStyles.description,
                )
              : LayoutBuilder(
                  builder: (context, constraints) {
                    final textPainter = TextPainter(
                      text: TextSpan(
                        text: widget.video.description,
                        style: AppTextStyles.description,
                      ),
                      maxLines: 1,
                      textDirection: TextDirection.ltr,
                    )..layout(maxWidth: constraints.maxWidth);

                    final isOverflow = textPainter.didExceedMaxLines;

                    return Row(
                      children: [
                        Flexible(
                          child: Text(
                            widget.video.description,
                            style: AppTextStyles.description,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isOverflow)
                          Text(
                            ' ${AppStrings.descriptionMore}',
                            style: AppTextStyles.description.copyWith(
                              color: AppColors.whiteSecondary,
                            ),
                          ),
                      ],
                    );
                  },
                ),
        ),
      ],
    );
  }
}
