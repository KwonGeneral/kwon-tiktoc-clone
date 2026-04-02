// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentUserHash() => r'5e5fb0af2ba3afac5cfcc7290de747ae957858e3';

/// See also [currentUser].
@ProviderFor(currentUser)
final currentUserProvider = AutoDisposeFutureProvider<User>.internal(
  currentUser,
  name: r'currentUserProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentUserRef = AutoDisposeFutureProviderRef<User>;
String _$likedVideosHash() => r'4e189ff900e1bb2e346d060cbf9701597e327818';

/// See also [likedVideos].
@ProviderFor(likedVideos)
final likedVideosProvider = AutoDisposeProvider<List<Video>>.internal(
  likedVideos,
  name: r'likedVideosProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$likedVideosHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LikedVideosRef = AutoDisposeProviderRef<List<Video>>;
String _$bookmarkedVideosHash() => r'54db4932e8f1b055206b371d0bdb59734e8bc7c6';

/// See also [bookmarkedVideos].
@ProviderFor(bookmarkedVideos)
final bookmarkedVideosProvider = AutoDisposeProvider<List<Video>>.internal(
  bookmarkedVideos,
  name: r'bookmarkedVideosProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bookmarkedVideosHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BookmarkedVideosRef = AutoDisposeProviderRef<List<Video>>;
String _$myVideosHash() => r'b2a003808c104fca8f64860a30edc2c4c40a80f2';

/// See also [myVideos].
@ProviderFor(myVideos)
final myVideosProvider = AutoDisposeProvider<List<Video>>.internal(
  myVideos,
  name: r'myVideosProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$myVideosHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MyVideosRef = AutoDisposeProviderRef<List<Video>>;
String _$profileEditNotifierHash() =>
    r'8070470f49d4b98ec98d9e574c883baf630fb0f0';

/// See also [ProfileEditNotifier].
@ProviderFor(ProfileEditNotifier)
final profileEditNotifierProvider =
    AutoDisposeNotifierProvider<
      ProfileEditNotifier,
      ({String nickname, String bio})
    >.internal(
      ProfileEditNotifier.new,
      name: r'profileEditNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$profileEditNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ProfileEditNotifier =
    AutoDisposeNotifier<({String nickname, String bio})>;
String _$notificationSettingNotifierHash() =>
    r'e8f827bcf7fdcb5c811d57640920793ce9707846';

/// See also [NotificationSettingNotifier].
@ProviderFor(NotificationSettingNotifier)
final notificationSettingNotifierProvider =
    AutoDisposeNotifierProvider<NotificationSettingNotifier, bool>.internal(
      NotificationSettingNotifier.new,
      name: r'notificationSettingNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$notificationSettingNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$NotificationSettingNotifier = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
