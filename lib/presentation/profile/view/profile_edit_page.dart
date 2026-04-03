import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import 'package:kwon_tiktoc_clone/app/theme/app_colors.dart';
import 'package:kwon_tiktoc_clone/app/theme/app_text_styles.dart';
import 'package:kwon_tiktoc_clone/core/constants/app_strings.dart';
import 'package:kwon_tiktoc_clone/presentation/profile/provider/profile_provider.dart';

class ProfileEditPage extends ConsumerStatefulWidget {
  const ProfileEditPage({
    required this.initialNickname,
    required this.initialBio,
    super.key,
  });

  final String initialNickname;
  final String initialBio;

  @override
  ConsumerState<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends ConsumerState<ProfileEditPage> {
  late final TextEditingController _nicknameController;
  late final TextEditingController _bioController;

  static const _bioMaxLength = 160;

  @override
  void initState() {
    super.initState();
    _nicknameController = TextEditingController(text: widget.initialNickname);
    _bioController = TextEditingController(text: widget.initialBio);
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _onSave() async {
    final nickname = _nicknameController.text.trim();
    if (nickname.isEmpty) return;

    await ref
        .read(profileEditNotifierProvider.notifier)
        .save(nickname: nickname, bio: _bioController.text.trim());
    if (mounted) context.pop();
  }

  Future<void> _onChangePhoto() async {
    final source = await showModalBottomSheet<ImageSource>(
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
              onTap: () => Navigator.pop(context, ImageSource.gallery),
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
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );

    if (source == null) return;

    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: source,
      maxWidth: 600,
      maxHeight: 600,
      imageQuality: 85,
    );
    if (image == null) return;

    await ref.read(profileImageNotifierProvider.notifier).upload(image.path);
  }

  @override
  Widget build(BuildContext context) {
    final currentUserAsync = ref.watch(currentUserProvider);
    final profileImageState = ref.watch(profileImageNotifierProvider);
    final isUploading = profileImageState is AsyncLoading;

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        leading: TextButton(
          onPressed: () => context.pop(),
          child: Text(
            AppStrings.profileEditCancel,
            style: AppTextStyles.description.copyWith(
              color: AppColors.whiteSecondary,
            ),
          ),
        ),
        leadingWidth: 80,
        title: const Text(
          AppStrings.profileEditTitle,
          style: AppTextStyles.username,
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _onSave,
            child: Text(
              AppStrings.profileEditSave,
              style: AppTextStyles.description.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 프로필 사진
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: isUploading ? null : _onChangePhoto,
                    child: currentUserAsync.when(
                      data: (user) => CircleAvatar(
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
                      loading: () => const CircleAvatar(
                        radius: 44,
                        backgroundColor: AppColors.gray,
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                          strokeWidth: 2,
                        ),
                      ),
                      error: (_, _) => const CircleAvatar(
                        radius: 44,
                        backgroundColor: AppColors.gray,
                        child: Icon(
                          Icons.person,
                          size: 44,
                          color: AppColors.whiteSecondary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: isUploading ? null : _onChangePhoto,
                    child: Text(
                      AppStrings.profileEditChangePhoto,
                      style: AppTextStyles.description.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // 닉네임
            Text(
              AppStrings.profileEditNickname,
              style: AppTextStyles.description.copyWith(
                color: AppColors.whiteSecondary,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _nicknameController,
              style: AppTextStyles.description,
              decoration: InputDecoration(
                hintText: AppStrings.profileEditNicknameHint,
                hintStyle: AppTextStyles.description.copyWith(
                  color: AppColors.whiteDisabled,
                ),
                filled: true,
                fillColor: AppColors.gray,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
                counterText: '',
              ),
            ),
            const SizedBox(height: 32),
            // 자기소개
            const Text(
              AppStrings.profileEditBioTitle,
              style: AppTextStyles.profileName,
            ),
            const SizedBox(height: 4),
            Text(
              AppStrings.profileEditBioDescription,
              style: AppTextStyles.description.copyWith(
                color: AppColors.whiteSecondary,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _bioController,
              style: AppTextStyles.description,
              maxLength: _bioMaxLength,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: AppStrings.profileEditBioHint,
                hintStyle: AppTextStyles.description.copyWith(
                  color: AppColors.whiteDisabled,
                ),
                filled: true,
                fillColor: AppColors.gray,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(12),
                counterStyle: AppTextStyles.profileLabel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
