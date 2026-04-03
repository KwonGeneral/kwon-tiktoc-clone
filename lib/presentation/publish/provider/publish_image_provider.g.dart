// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publish_image_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$publishImageNotifierHash() =>
    r'8b397953d4ab247c97301fe4ece111a7e4084aef';

/// See also [PublishImageNotifier].
@ProviderFor(PublishImageNotifier)
final publishImageNotifierProvider =
    AutoDisposeNotifierProvider<PublishImageNotifier, PublishState>.internal(
      PublishImageNotifier.new,
      name: r'publishImageNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$publishImageNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PublishImageNotifier = AutoDisposeNotifier<PublishState>;
String _$postImageListNotifierHash() =>
    r'6b81f437fab457f8b671f153031c6c7c89545f0e';

/// See also [PostImageListNotifier].
@ProviderFor(PostImageListNotifier)
final postImageListNotifierProvider =
    AutoDisposeAsyncNotifierProvider<
      PostImageListNotifier,
      List<PostImage>
    >.internal(
      PostImageListNotifier.new,
      name: r'postImageListNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$postImageListNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PostImageListNotifier = AutoDisposeAsyncNotifier<List<PostImage>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
