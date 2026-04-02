import 'package:kwon_tiktoc_clone/data/datasource/video_datasource.dart';
import 'package:kwon_tiktoc_clone/domain/entity/comment.dart';
import 'package:kwon_tiktoc_clone/domain/entity/video.dart';
import 'package:kwon_tiktoc_clone/domain/repository/video_repository.dart';

class VideoRepositoryImpl implements VideoRepository {
  final VideoDataSource _dataSource;

  const VideoRepositoryImpl(this._dataSource);

  @override
  Future<List<Video>> getVideoFeed({int page = 0}) async {
    final models = await _dataSource.getVideoFeed(page: page);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<Video> toggleLike(String videoId) async {
    final model = await _dataSource.toggleLike(videoId);
    return model.toEntity();
  }

  @override
  Future<Video> toggleBookmark(String videoId) async {
    final model = await _dataSource.toggleBookmark(videoId);
    return model.toEntity();
  }

  @override
  Future<List<Comment>> getComments(String videoId) async {
    final models = await _dataSource.getComments(videoId);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<Video> uploadVideo({
    required String filePath,
    required String description,
    void Function(double progress)? onProgress,
  }) async {
    final model = await _dataSource.uploadVideo(
      filePath: filePath,
      description: description,
      onProgress: onProgress,
    );
    return model.toEntity();
  }
}
