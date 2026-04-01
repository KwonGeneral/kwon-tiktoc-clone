import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:supersent_tiktoc_clone/data/datasource/mock_video_datasource.dart';
import 'package:supersent_tiktoc_clone/data/datasource/video_datasource.dart';
import 'package:supersent_tiktoc_clone/data/repository/user_repository_impl.dart';
import 'package:supersent_tiktoc_clone/data/repository/video_repository_impl.dart';
import 'package:supersent_tiktoc_clone/domain/repository/user_repository.dart';
import 'package:supersent_tiktoc_clone/domain/repository/video_repository.dart';
import 'package:supersent_tiktoc_clone/domain/usecase/get_comments.dart';
import 'package:supersent_tiktoc_clone/domain/usecase/get_video_feed.dart';
import 'package:supersent_tiktoc_clone/domain/usecase/toggle_bookmark.dart';
import 'package:supersent_tiktoc_clone/domain/usecase/toggle_like.dart';

part 'providers.g.dart';

// DataSource
@Riverpod(keepAlive: true)
VideoDataSource videoDataSource(Ref ref) {
  return MockVideoDataSource();
}

// Repositories
@Riverpod(keepAlive: true)
VideoRepository videoRepository(Ref ref) {
  return VideoRepositoryImpl(ref.watch(videoDataSourceProvider));
}

@Riverpod(keepAlive: true)
UserRepository userRepository(Ref ref) {
  return UserRepositoryImpl();
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
