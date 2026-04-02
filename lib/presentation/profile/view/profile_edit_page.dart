import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../core/constants/app_strings.dart';
import '../provider/profile_provider.dart';

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

    await ref.read(profileEditNotifierProvider.notifier).save(
          nickname: nickname,
          bio: _bioController.text.trim(),
        );
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
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
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
