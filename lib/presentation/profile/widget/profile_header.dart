import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/route/route_paths.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../core/constants/app_strings.dart';
import '../../../domain/entity/user.dart';
import '../provider/profile_provider.dart';

class ProfileHeader extends ConsumerWidget {
  const ProfileHeader({required this.user, super.key});

  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileImageState = ref.watch(profileImageNotifierProvider);
    final isUploading = profileImageState is AsyncLoading;

    return Column(
      children: [
        const SizedBox(height: 8),
        _buildAvatar(context, ref, isUploading),
        const SizedBox(height: 12),
        _buildNameRow(context),
        const SizedBox(height: 4),
        Text('@${user.id}', style: AppTextStyles.profileId),
      ],
    );
  }

  Widget _buildAvatar(BuildContext context, WidgetRef ref, bool isUploading) {
    return GestureDetector(
      onTap: isUploading ? null : () => _showImagePickerSheet(context, ref),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          CircleAvatar(
            radius: 44,
            backgroundColor: AppColors.gray,
            backgroundImage: user.avatarUrl.isNotEmpty
                ? NetworkImage(user.avatarUrl)
                : null,
            child: isUploading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                      strokeWidth: 2,
                    ),
                  )
                : user.avatarUrl.isEmpty
                    ? const Icon(
                        Icons.person,
                        size: 44,
                        color: AppColors.whiteSecondary,
                      )
                    : null,
          ),
          Positioned(
            bottom: -6,
            child: Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, size: 16, color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showImagePickerSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.commentBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.whiteDisabled,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              AppStrings.profileImageTitle,
              style: AppTextStyles.username.copyWith(color: AppColors.white),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(
                Icons.photo_library_outlined,
                color: AppColors.white,
              ),
              title: Text(
                AppStrings.profileImageGallery,
                style: AppTextStyles.description.copyWith(
                  color: AppColors.white,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ref, ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.camera_alt_outlined,
                color: AppColors.white,
              ),
              title: Text(
                AppStrings.profileImageCamera,
                style: AppTextStyles.description.copyWith(
                  color: AppColors.white,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ref, ImageSource.camera);
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(WidgetRef ref, ImageSource source) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: source,
      maxWidth: 600,
      maxHeight: 600,
      imageQuality: 85,
    );
    if (image == null) return;

    await ref
        .read(profileImageNotifierProvider.notifier)
        .upload(image.path);
  }

  Widget _buildNameRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(user.nickname, style: AppTextStyles.profileName),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () => context.push(
            RoutePaths.profileEdit,
            extra: {
              'nickname': user.nickname,
              'bio': user.bio,
            },
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.gray,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              AppStrings.profileEdit,
              style: AppTextStyles.profileLabel.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
