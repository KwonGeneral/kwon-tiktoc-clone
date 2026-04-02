import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/format_utils.dart';
import '../../../domain/entity/user.dart';

class RecommendedAccountTile extends StatelessWidget {
  const RecommendedAccountTile({
    required this.user,
    required this.isFollowed,
    required this.onToggleFollow,
    required this.onDismiss,
    required this.onTap,
    super.key,
  });

  final User user;
  final bool isFollowed;
  final VoidCallback onToggleFollow;
  final VoidCallback onDismiss;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            // 아바타
            CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.gray,
              backgroundImage: user.avatarUrl.isNotEmpty
                  ? NetworkImage(user.avatarUrl)
                  : null,
              child: user.avatarUrl.isEmpty
                  ? Text(
                      user.nickname.isNotEmpty
                          ? user.nickname[0].toUpperCase()
                          : '?',
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),

            // 이름 + 팔로워 수
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          user.nickname,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (user.isVerified) ...[
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.verified,
                          color: AppColors.secondary,
                          size: 14,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${AppStrings.friendsMutualFollow}${FormatUtils.compactNumber(user.followerCount)}',
                    style: const TextStyle(
                      color: AppColors.whiteSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            // 팔로우 버튼
            SizedBox(
              width: 76,
              height: 34,
              child: OutlinedButton(
                onPressed: onToggleFollow,
                style: OutlinedButton.styleFrom(
                  backgroundColor: isFollowed
                      ? Colors.transparent
                      : AppColors.primary,
                  side: BorderSide(
                    color: isFollowed
                        ? AppColors.whiteDisabled
                        : AppColors.primary,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  isFollowed
                      ? AppStrings.friendsFollowing
                      : AppStrings.friendsFollow,
                  style: TextStyle(
                    color: isFollowed
                        ? AppColors.whiteSecondary
                        : AppColors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 8),

            // X 버튼
            GestureDetector(
              onTap: onDismiss,
              child: const Icon(
                Icons.close,
                color: AppColors.whiteDisabled,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
