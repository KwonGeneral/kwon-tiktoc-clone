// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentUserHash() => r'184a8b1d64e616f29b732b02c79e20dc29e35386';

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
String _$profileImageHash() => r'64da2ad90357fb3547e91f0e3cddaf9d66b03d90';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [profileImage].
@ProviderFor(profileImage)
const profileImageProvider = ProfileImageFamily();

/// See also [profileImage].
class ProfileImageFamily extends Family<AsyncValue<String?>> {
  /// See also [profileImage].
  const ProfileImageFamily();

  /// See also [profileImage].
  ProfileImageProvider call(String userId) {
    return ProfileImageProvider(userId);
  }

  @override
  ProfileImageProvider getProviderOverride(
    covariant ProfileImageProvider provider,
  ) {
    return call(provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'profileImageProvider';
}

/// See also [profileImage].
class ProfileImageProvider extends AutoDisposeFutureProvider<String?> {
  /// See also [profileImage].
  ProfileImageProvider(String userId)
    : this._internal(
        (ref) => profileImage(ref as ProfileImageRef, userId),
        from: profileImageProvider,
        name: r'profileImageProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$profileImageHash,
        dependencies: ProfileImageFamily._dependencies,
        allTransitiveDependencies:
            ProfileImageFamily._allTransitiveDependencies,
        userId: userId,
      );

  ProfileImageProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    FutureOr<String?> Function(ProfileImageRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProfileImageProvider._internal(
        (ref) => create(ref as ProfileImageRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String?> createElement() {
    return _ProfileImageProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProfileImageProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProfileImageRef on AutoDisposeFutureProviderRef<String?> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _ProfileImageProviderElement
    extends AutoDisposeFutureProviderElement<String?>
    with ProfileImageRef {
  _ProfileImageProviderElement(super.provider);

  @override
  String get userId => (origin as ProfileImageProvider).userId;
}

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
String _$myVideosHash() => r'318566adb554af24fb7e4af0d70fe3c4a2daff35';

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
String _$myPostImagesHash() => r'1db760aaaed0d2131c960bad1fecc1a83cc06a05';

/// See also [myPostImages].
@ProviderFor(myPostImages)
final myPostImagesProvider = AutoDisposeProvider<List<PostImage>>.internal(
  myPostImages,
  name: r'myPostImagesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$myPostImagesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MyPostImagesRef = AutoDisposeProviderRef<List<PostImage>>;
String _$profileImageNotifierHash() =>
    r'd50ad0627b7f5fb48470448fb0d37aaea959ec1d';

/// See also [ProfileImageNotifier].
@ProviderFor(ProfileImageNotifier)
final profileImageNotifierProvider =
    AutoDisposeAsyncNotifierProvider<ProfileImageNotifier, String?>.internal(
      ProfileImageNotifier.new,
      name: r'profileImageNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$profileImageNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ProfileImageNotifier = AutoDisposeAsyncNotifier<String?>;
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
    r'e82a4d13af65ed0b128f23a0ae92b0106526f89b';

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
