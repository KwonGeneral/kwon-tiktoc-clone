import 'package:kwon_tiktoc_clone/domain/entity/comment.dart';
import 'package:kwon_tiktoc_clone/domain/entity/video.dart';

abstract interface class VideoRepository {
  Future<List<Video>> getVideoFeed({int page = 0});
  Future<Video> toggleLike(String videoId);
  Future<Video> toggleBookmark(String videoId);
  Future<List<Comment>> getComments(String videoId);
  Future<void> uploadVideo({
    required String filePath,
    required String description,
    void Function(double progress)? onProgress,
  });
}
