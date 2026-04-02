import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../domain/entity/user.dart';

class FriendListTile extends StatelessWidget {
  const FriendListTile({
    required this.user,
    required this.isFollowed,
    required this.onToggleFollow,
    required this.onRemove,
    super.key,
  });

  final User user;
  final bool isFollowed;
  final VoidCallback onToggleFollow;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          // 아바타
          CircleAvatar(
            radius: 26,
            backgroundColor: AppColors.gray,
            backgroundImage:
                user.avatarUrl.isNotEmpty ? NetworkImage(user.avatarUrl) : null,
            child: user.avatarUrl.isEmpty
                ? Text(
                    user.nickname.isNotEmpty
                        ? user.nickname[0].toUpperCase()
                        : '?',
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 12),

          // 이름 + 부가 정보
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
                      const Icon(Icons.verified, color: AppColors.secondary, size: 14),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  isFollowed
                      ? AppStrings.friendsMutualFollow
                      : '${AppStrings.friendsFollowedBy}${user.nickname}',
                  style: const TextStyle(
                    color: AppColors.whiteSecondary,
                    fontSize: 13,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // 제거 버튼
          _ActionButton(
            label: AppStrings.friendsRemove,
            onTap: onRemove,
            isPrimary: false,
          ),
          const SizedBox(width: 8),

          // 팔로우 버튼
          _ActionButton(
            label: isFollowed
                ? AppStrings.friendsFollowing
                : AppStrings.friendsFollow,
            onTap: onToggleFollow,
            isPrimary: !isFollowed,
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.onTap,
    required this.isPrimary,
  });

  final String label;
  final VoidCallback onTap;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 76,
      height: 34,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: isPrimary ? AppColors.primary : Colors.transparent,
          side: BorderSide(
            color: isPrimary ? AppColors.primary : AppColors.whiteDisabled,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isPrimary ? AppColors.white : AppColors.whiteSecondary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
