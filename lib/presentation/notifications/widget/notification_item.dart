import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/utils/format_utils.dart';
import '../../../domain/entity/notification.dart' as domain;

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    required this.notification,
    required this.onTap,
    super.key,
  });

  final domain.Notification notification;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 아바타
            CircleAvatar(
              radius: 22,
              backgroundColor: _getAvatarColor(),
              child: notification.type == domain.NotificationType.system
                  ? const Icon(
                      Icons.security,
                      color: AppColors.white,
                      size: 20,
                    )
                  : Text(
                      notification.userNickname.isNotEmpty
                          ? notification.userNickname[0].toUpperCase()
                          : '?',
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            const SizedBox(width: 12),

            // 내용
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      children: [
                        if (notification.type != domain.NotificationType.system)
                          TextSpan(
                            text: notification.userNickname,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        TextSpan(
                          text: notification.message,
                          style: const TextStyle(
                            color: AppColors.whiteSecondary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    FormatUtils.timeAgo(notification.createdAt),
                    style: const TextStyle(
                      color: AppColors.whiteDisabled,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            // 타입 아이콘
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Icon(
                _getTypeIcon(),
                color: AppColors.whiteDisabled,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getAvatarColor() {
    return switch (notification.type) {
      domain.NotificationType.follow => AppColors.secondary,
      domain.NotificationType.like => AppColors.primary,
      domain.NotificationType.comment => AppColors.commentPurple,
      domain.NotificationType.system => AppColors.gray,
    };
  }

  IconData _getTypeIcon() {
    return switch (notification.type) {
      domain.NotificationType.follow => Icons.person_add,
      domain.NotificationType.like => Icons.favorite,
      domain.NotificationType.comment => Icons.chat_bubble,
      domain.NotificationType.system => Icons.info_outline,
    };
  }
}
