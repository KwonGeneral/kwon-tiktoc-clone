import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/route/route_paths.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../feed/provider/feed_provider.dart';
import '../provider/publish_provider.dart';
import '../provider/publish_state.dart';
import '../widget/publish_cover_thumbnail.dart';
import '../widget/publish_upload_overlay.dart';

class PublishPage extends ConsumerStatefulWidget {
  const PublishPage({super.key, required this.videoFilePath});

  final String videoFilePath;

  @override
  ConsumerState<PublishPage> createState() => _PublishPageState();
}

class _PublishPageState extends ConsumerState<PublishPage> {
  final _descriptionController = TextEditingController();
  final _descriptionFocusNode = FocusNode();

  @override
  void dispose() {
    _descriptionController.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  void _onPublish() {
    FocusScope.of(context).unfocus();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(AppStrings.publishPrivacyTitle),
        content: const Text(AppStrings.publishPrivacyMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text(AppStrings.publishPrivacyCancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _startUpload();
            },
            child: const Text(
              AppStrings.publishPrivacyConfirm,
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  void _startUpload() {
    ref.read(publishNotifierProvider.notifier).publish(
          videoFilePath: widget.videoFilePath,
          description: _descriptionController.text,
        );
  }

  void _onHashtagTap() {
    _descriptionFocusNode.requestFocus();
    final text = _descriptionController.text;
    final cursorPos = _descriptionController.selection.baseOffset;
    final newText = '${text.substring(0, cursorPos < 0 ? text.length : cursorPos)}'
        '#'
        '${cursorPos < 0 ? '' : text.substring(cursorPos)}';
    _descriptionController.text = newText;
    _descriptionController.selection = TextSelection.collapsed(
      offset: (cursorPos < 0 ? text.length : cursorPos) + 1,
    );
  }

  void _onMentionTap() {
    _descriptionFocusNode.requestFocus();
    final text = _descriptionController.text;
    final cursorPos = _descriptionController.selection.baseOffset;
    final newText = '${text.substring(0, cursorPos < 0 ? text.length : cursorPos)}'
        '@'
        '${cursorPos < 0 ? '' : text.substring(cursorPos)}';
    _descriptionController.text = newText;
    _descriptionController.selection = TextSelection.collapsed(
      offset: (cursorPos < 0 ? text.length : cursorPos) + 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    final publishState = ref.watch(publishNotifierProvider);

    ref.listen(publishNotifierProvider, (prev, next) {
      if (next.status == PublishStatus.success) {
        ref.invalidate(feedNotifierProvider);
        context.go(RoutePaths.profile);
      }
    });

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.black),
              onPressed: () => context.pop(),
            ),
            actions: [
              if (publishState.status == PublishStatus.idle)
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: _PublishButton(onTap: _onPublish),
                ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  // 설명 입력 + 커버 썸네일
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _descriptionController,
                          focusNode: _descriptionFocusNode,
                          maxLines: 5,
                          minLines: 3,
                          decoration: const InputDecoration(
                            hintText: AppStrings.publishDescriptionHint,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontSize: 15,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      PublishCoverThumbnail(videoFilePath: widget.videoFilePath),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // 해시태그 / 멘션 버튼
                  Row(
                    children: [
                      _TagButton(
                        label: AppStrings.publishHashtag,
                        onTap: _onHashtagTap,
                      ),
                      const SizedBox(width: 12),
                      _TagButton(
                        label: AppStrings.publishMention,
                        onTap: _onMentionTap,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Divider(height: 1, color: Color(0xFFEEEEEE)),
                  const SizedBox(height: 24),
                  // 하단 게시 버튼
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _onPublish,
                      icon: const Icon(Icons.upload, size: 18),
                      label: const Text(AppStrings.publishButton),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
        // 업로드 오버레이
        if (publishState.status != PublishStatus.idle)
          PublishUploadOverlay(state: publishState, onRetry: _startUpload),
      ],
    );
  }
}

class _PublishButton extends StatelessWidget {
  const _PublishButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Text(
          AppStrings.publishButton,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _TagButton extends StatelessWidget {
  const _TagButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
