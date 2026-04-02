// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_player_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$videoPlayerManagerHash() =>
    r'b99a6f8a0c59ee64704d89ace68c9832d574ebee';

/// 비디오 플레이어 컨트롤러를 중앙 관리하는 Manager.
/// 현재 페이지 ± 2 범위의 컨트롤러만 유지하여 메모리를 관리한다.
///
/// Copied from [VideoPlayerManager].
@ProviderFor(VideoPlayerManager)
final videoPlayerManagerProvider =
    NotifierProvider<
      VideoPlayerManager,
      Map<int, VideoPlayerController>
    >.internal(
      VideoPlayerManager.new,
      name: r'videoPlayerManagerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$videoPlayerManagerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$VideoPlayerManager = Notifier<Map<int, VideoPlayerController>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
