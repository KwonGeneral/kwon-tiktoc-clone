import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_strings.dart';
import '../provider/camera_provider.dart';
import '../provider/camera_state.dart';
import '../widget/camera_controls.dart';
import '../widget/recording_timer_indicator.dart';

class CameraPage extends ConsumerStatefulWidget {
  const CameraPage({super.key});

  @override
  ConsumerState<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends ConsumerState<CameraPage>
    with WidgetsBindingObserver {
  CameraController? _controller;
  List<CameraDescription> _cameras = [];
  bool _isInitializing = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_controller == null || !_controller!.value.isInitialized) return;

    if (state == AppLifecycleState.inactive) {
      _controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCamera();
    }
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isEmpty) {
        setState(() {
          _isInitializing = false;
          _errorMessage = AppStrings.cameraNotAvailable;
        });
        return;
      }

      final isFront = ref.read(cameraNotifierProvider).isFrontCamera;
      final cameraDescription = _getCameraDescription(isFront);
      await _setupController(cameraDescription);
    } catch (e) {
      setState(() {
        _isInitializing = false;
        _errorMessage = AppStrings.cameraInitError;
      });
    }
  }

  CameraDescription _getCameraDescription(bool isFront) {
    final direction =
        isFront ? CameraLensDirection.front : CameraLensDirection.back;
    return _cameras.firstWhere(
      (c) => c.lensDirection == direction,
      orElse: () => _cameras.first,
    );
  }

  Future<void> _setupController(CameraDescription camera) async {
    final previousController = _controller;
    _controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: true,
    );

    try {
      await _controller!.initialize();
      await previousController?.dispose();

      if (mounted) {
        setState(() {
          _isInitializing = false;
          _errorMessage = null;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isInitializing = false;
          _errorMessage = AppStrings.cameraInitError;
        });
      }
    }
  }

  Future<void> _switchCamera() async {
    final notifier = ref.read(cameraNotifierProvider.notifier);
    notifier.toggleCamera();
    final isFront = ref.read(cameraNotifierProvider).isFrontCamera;
    final cameraDescription = _getCameraDescription(isFront);
    await _setupController(cameraDescription);
  }

  Future<void> _startRecording() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    try {
      await _controller!.startVideoRecording();
      ref.read(cameraNotifierProvider.notifier).startRecording();
    } catch (e) {
      debugPrint('녹화 시작 실패: $e');
    }
  }

  Future<void> _pauseRecording() async {
    if (_controller == null || !_controller!.value.isRecordingVideo) return;

    try {
      await _controller!.pauseVideoRecording();
      ref.read(cameraNotifierProvider.notifier).pauseRecording();
    } catch (e) {
      debugPrint('녹화 일시정지 실패: $e');
    }
  }

  Future<void> _resumeRecording() async {
    if (_controller == null || !_controller!.value.isRecordingPaused) return;

    try {
      await _controller!.resumeVideoRecording();
      ref.read(cameraNotifierProvider.notifier).resumeRecording();
    } catch (e) {
      debugPrint('녹화 재개 실패: $e');
    }
  }

  Future<void> _stopRecording() async {
    if (_controller == null || !_controller!.value.isRecordingVideo) return;

    try {
      final file = await _controller!.stopVideoRecording();
      ref.read(cameraNotifierProvider.notifier).stopRecording(file.path);

      if (mounted) {
        // TODO: Phase 18에서 게시 화면으로 이동
        _showRecordingCompleteDialog(file.path);
      }
    } catch (e) {
      debugPrint('녹화 중지 실패: $e');
    }
  }

  void _showRecordingCompleteDialog(String filePath) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.gray,
        title: const Text(
          AppStrings.cameraRecordingComplete,
          style: TextStyle(color: AppColors.white),
        ),
        content: const Text(
          AppStrings.cameraRecordingCompleteMessage,
          style: TextStyle(color: AppColors.whiteSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(cameraNotifierProvider.notifier).resetRecording();
            },
            child: const Text(AppStrings.cameraConfirm),
          ),
        ],
      ),
    );
  }

  Future<void> _handleCancel() async {
    final cameraState = ref.read(cameraNotifierProvider);
    if (cameraState.status == RecordingStatus.idle) {
      context.pop();
      return;
    }

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.gray,
        title: const Text(
          AppStrings.cameraDeleteClipTitle,
          style: TextStyle(color: AppColors.white),
        ),
        content: const Text(
          AppStrings.cameraDeleteClipMessage,
          style: TextStyle(color: AppColors.whiteSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(AppStrings.cameraCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(
              AppStrings.cameraDelete,
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );

    if (shouldDelete == true) {
      if (_controller != null && _controller!.value.isRecordingVideo) {
        try {
          await _controller!.stopVideoRecording();
        } catch (_) {}
      }
      ref.read(cameraNotifierProvider.notifier).resetRecording();
    }
  }

  Future<void> _handleAutoStop() async {
    await _stopRecording();
  }

  @override
  Widget build(BuildContext context) {
    final cameraState = ref.watch(cameraNotifierProvider);

    // 15초 도달 시 자동 정지
    ref.listen(cameraNotifierProvider, (prev, next) {
      if (next.status == RecordingStatus.recording &&
          next.elapsed >= AppConstants.maxRecordingDuration) {
        _handleAutoStop();
      }
    });

    return Scaffold(
      backgroundColor: AppColors.black,
      body: _isInitializing
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.white),
            )
          : _errorMessage != null
              ? _ErrorView(
                  message: _errorMessage!,
                  onBack: () => context.pop(),
                )
              : _CameraBody(
                  controller: _controller!,
                  cameraState: cameraState,
                  onClose: () {
                    if (cameraState.status != RecordingStatus.idle) {
                      _handleCancel();
                    } else {
                      context.pop();
                    }
                  },
                  onSwitchCamera: _switchCamera,
                  onStartRecording: _startRecording,
                  onPauseRecording: _pauseRecording,
                  onResumeRecording: _resumeRecording,
                  onStopRecording: _stopRecording,
                  onCancel: _handleCancel,
                ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onBack});

  final String message;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.videocam_off, color: AppColors.whiteDisabled, size: 64),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(color: AppColors.whiteSecondary, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          TextButton(
            onPressed: onBack,
            child: const Text(AppStrings.cameraGoBack),
          ),
        ],
      ),
    );
  }
}

class _CameraBody extends StatelessWidget {
  const _CameraBody({
    required this.controller,
    required this.cameraState,
    required this.onClose,
    required this.onSwitchCamera,
    required this.onStartRecording,
    required this.onPauseRecording,
    required this.onResumeRecording,
    required this.onStopRecording,
    required this.onCancel,
  });

  final CameraController controller;
  final CameraState cameraState;
  final VoidCallback onClose;
  final VoidCallback onSwitchCamera;
  final VoidCallback onStartRecording;
  final VoidCallback onPauseRecording;
  final VoidCallback onResumeRecording;
  final VoidCallback onStopRecording;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // 카메라 프리뷰
        ClipRect(
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: controller.value.previewSize?.height ?? 0,
              height: controller.value.previewSize?.width ?? 0,
              child: CameraPreview(controller),
            ),
          ),
        ),

        // 상단 바
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          left: 16,
          right: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 닫기 버튼
              GestureDetector(
                onTap: onClose,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: AppColors.overlay,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: AppColors.white,
                    size: 24,
                  ),
                ),
              ),
              // 카메라 전환
              if (cameraState.status == RecordingStatus.idle)
                GestureDetector(
                  onTap: onSwitchCamera,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: AppColors.overlay,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.flip_camera_ios,
                      color: AppColors.white,
                      size: 24,
                    ),
                  ),
                )
              else
                const SizedBox(width: 40),
            ],
          ),
        ),

        // 타이머 표시 (녹화 중/일시정지)
        if (cameraState.status != RecordingStatus.idle)
          Positioned(
            top: MediaQuery.of(context).padding.top + 60,
            left: 0,
            right: 0,
            child: Center(
              child: RecordingTimerIndicator(elapsed: cameraState.elapsed),
            ),
          ),

        // 하단 컨트롤
        Positioned(
          bottom: MediaQuery.of(context).padding.bottom + 40,
          left: 0,
          right: 0,
          child: CameraControls(
            status: cameraState.status,
            elapsed: cameraState.elapsed,
            onStartRecording: onStartRecording,
            onPauseRecording: onPauseRecording,
            onResumeRecording: onResumeRecording,
            onStopRecording: onStopRecording,
            onCancel: onCancel,
          ),
        ),

        // 동영상 모드 라벨
        Positioned(
          bottom: MediaQuery.of(context).padding.bottom + 16,
          left: 0,
          right: 0,
          child: const Center(
            child: Text(
              AppStrings.cameraVideoMode,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
