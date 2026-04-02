import 'package:kwon_tiktoc_clone/domain/entity/comment.dart';
import 'package:kwon_tiktoc_clone/domain/entity/video.dart';

abstract interface class VideoRepository {
  Future<List<Video>> getVideoFeed({int page = 0});
  Future<Video> toggleLike(String videoId);
  Future<Video> toggleBookmark(String videoId);
  Future<List<Comment>> getComments(String videoId);
  Future<Video> uploadVideo({
    required String filePath,
    required String description,
    String? title,
    String? tags,
    String? location,
    String? userId,
    String? username,
    String? nickname,
    String? avatarUrl,
    void Function(double progress)? onProgress,
  });
}
