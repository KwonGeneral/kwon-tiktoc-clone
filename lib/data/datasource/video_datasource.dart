import 'package:kwon_tiktoc_clone/data/model/comment_model.dart';
import 'package:kwon_tiktoc_clone/data/model/video_model.dart';

abstract interface class VideoDataSource {
  Future<List<VideoModel>> getVideoFeed({int page = 0});
  Future<VideoModel> toggleLike(String videoId);
  Future<VideoModel> toggleBookmark(String videoId);
  Future<List<CommentModel>> getComments(String videoId);
  Future<VideoModel> uploadVideo({
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
