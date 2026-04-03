import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kwon_tiktoc_clone/core/services/device_id_service.dart';
import 'package:kwon_tiktoc_clone/data/datasource/post_image_datasource.dart';
import 'package:kwon_tiktoc_clone/data/datasource/post_image_remote_datasource.dart';
import 'package:kwon_tiktoc_clone/data/datasource/video_datasource.dart';
import 'package:kwon_tiktoc_clone/data/datasource/video_remote_datasource.dart';
import 'package:kwon_tiktoc_clone/data/repository/notification_repository_impl.dart';
import 'package:kwon_tiktoc_clone/data/repository/post_image_repository_impl.dart';
import 'package:kwon_tiktoc_clone/data/repository/user_repository_impl.dart';
import 'package:kwon_tiktoc_clone/data/repository/video_repository_impl.dart';
import 'package:kwon_tiktoc_clone/domain/repository/local_storage_repository.dart';
import 'package:kwon_tiktoc_clone/domain/repository/notification_repository.dart';
import 'package:kwon_tiktoc_clone/domain/repository/post_image_repository.dart';
import 'package:kwon_tiktoc_clone/domain/repository/user_repository.dart';
import 'package:kwon_tiktoc_clone/domain/repository/video_repository.dart';
import 'package:kwon_tiktoc_clone/domain/usecase/get_comments.dart';
import 'package:kwon_tiktoc_clone/domain/usecase/get_video_feed.dart';
import 'package:kwon_tiktoc_clone/domain/usecase/toggle_bookmark.dart';
import 'package:kwon_tiktoc_clone/domain/usecase/toggle_like.dart';

part 'providers.g.dart';

// Device ID
@Riverpod(keepAlive: true)
DeviceIdService deviceIdService(Ref ref) {
  throw UnimplementedError('deviceIdService must be overridden');
}

// Local Storage
@Riverpod(keepAlive: true)
LocalStorageRepository localStorageRepository(Ref ref) {
  throw UnimplementedError('localStorageRepository must be overridden');
}

// DataSource
@Riverpod(keepAlive: true)
VideoDataSource videoDataSource(Ref ref) {
  return VideoRemoteDataSource();
}

// Repositories
@Riverpod(keepAlive: true)
VideoRepository videoRepository(Ref ref) {
  return VideoRepositoryImpl(ref.watch(videoDataSourceProvider));
}

@Riverpod(keepAlive: true)
UserRepository userRepository(Ref ref) {
  final deviceId = ref.watch(deviceIdServiceProvider).getDeviceId();
  return UserRepositoryImpl(deviceId: deviceId);
}

@Riverpod(keepAlive: true)
NotificationRepository notificationRepository(Ref ref) {
  return NotificationRepositoryImpl();
}

// PostImage
@Riverpod(keepAlive: true)
PostImageDataSource postImageDataSource(Ref ref) {
  return PostImageRemoteDataSource();
}

@Riverpod(keepAlive: true)
PostImageRepository postImageRepository(Ref ref) {
  return PostImageRepositoryImpl(ref.watch(postImageDataSourceProvider));
}

// UseCases
@riverpod
GetVideoFeed getVideoFeed(Ref ref) {
  return GetVideoFeed(ref.watch(videoRepositoryProvider));
}

@riverpod
ToggleLike toggleLike(Ref ref) {
  return ToggleLike(ref.watch(videoRepositoryProvider));
}

@riverpod
ToggleBookmark toggleBookmark(Ref ref) {
  return ToggleBookmark(ref.watch(videoRepositoryProvider));
}

@riverpod
GetComments getComments(Ref ref) {
  return GetComments(ref.watch(videoRepositoryProvider));
}
