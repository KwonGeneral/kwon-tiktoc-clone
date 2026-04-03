import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:kwon_tiktoc_clone/app/route/route_paths.dart';
import 'package:kwon_tiktoc_clone/app/theme/app_colors.dart';
import 'package:kwon_tiktoc_clone/core/constants/app_strings.dart';
import 'package:kwon_tiktoc_clone/presentation/publish/provider/publish_image_provider.dart';
import 'package:kwon_tiktoc_clone/presentation/publish/provider/publish_state.dart';
import 'package:kwon_tiktoc_clone/presentation/publish/widget/publish_upload_overlay.dart';

class PublishImagePage extends ConsumerStatefulWidget {
  const PublishImagePage({super.key, required this.imageFilePath});

  final String imageFilePath;

  @override
  ConsumerState<PublishImagePage> createState() => _PublishImagePageState();
}

class _PublishImagePageState extends ConsumerState<PublishImagePage> {
  final _captionController = TextEditingController();
  final _captionFocusNode = FocusNode();
  bool _hasCaption = false;

  @override
  void initState() {
    super.initState();
    _captionController.addListener(() {
      final hasText = _captionController.text.trim().isNotEmpty;
      if (hasText != _hasCaption) {
        setState(() => _hasCaption = hasText);
      }
    });
  }

  @override
  void dispose() {
    _captionController.dispose();
    _captionFocusNode.dispose();
    super.dispose();
  }

  void _onPublish() {
    _captionFocusNode.unfocus();
    FocusManager.instance.primaryFocus?.unfocus();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(AppStrings.publishPrivacyTitle),
        content: const Text(AppStrings.publishImagePrivacyMessage),
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
    ref
        .read(publishImageNotifierProvider.notifier)
        .publish(
          imageFilePath: widget.imageFilePath,
          caption: _captionController.text,
        );
  }

  Future<void> _onUploadSuccess() async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    try {
      await ref.read(postImageListNotifierProvider.notifier).reload();
    } catch (_) {}
    if (!mounted) return;
    context.go(RoutePaths.profile);
  }

  void _onHashtagTap() {
    _captionFocusNode.requestFocus();
    final text = _captionController.text;
    final cursorPos = _captionController.selection.baseOffset;
    final pos = cursorPos < 0 ? text.length : cursorPos;
    final newText = '${text.substring(0, pos)}#${text.substring(pos)}';
    _captionController.text = newText;
    _captionController.selection = TextSelection.collapsed(offset: pos + 1);
  }

  void _onMentionTap() {
    _captionFocusNode.requestFocus();
    final text = _captionController.text;
    final cursorPos = _captionController.selection.baseOffset;
    final pos = cursorPos < 0 ? text.length : cursorPos;
    final newText = '${text.substring(0, pos)}@${text.substring(pos)}';
    _captionController.text = newText;
    _captionController.selection = TextSelection.collapsed(offset: pos + 1);
  }

  @override
  Widget build(BuildContext context) {
    final publishState = ref.watch(publishImageNotifierProvider);

    ref.listen(publishImageNotifierProvider, (prev, next) {
      if (prev?.status != PublishStatus.success &&
          next.status == PublishStatus.success) {
        _onUploadSuccess();
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
            title: const Text(
              AppStrings.publishTitle,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _captionController,
                          focusNode: _captionFocusNode,
                          maxLines: 5,
                          minLines: 3,
                          decoration: const InputDecoration(
                            hintText: AppStrings.publishCaptionHint,
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
                      // 이미지 미리보기
                      Container(
                        width: 90,
                        height: 120,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F0F0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Image.file(
                          File(widget.imageFilePath),
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => const Center(
                            child: Icon(
                              Icons.image,
                              color: Colors.grey,
                              size: 32,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
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
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _hasCaption ? _onPublish : null,
                      icon: const Icon(Icons.upload, size: 18),
                      label: const Text(AppStrings.publishButton),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor:
                            AppColors.primary.withValues(alpha: 0.5),
                        disabledForegroundColor:
                            Colors.white.withValues(alpha: 0.5),
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
        if (publishState.status != PublishStatus.idle)
          PublishUploadOverlay(state: publishState, onRetry: _startUpload),
      ],
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
