import 'package:kwon_tiktoc_clone/data/model/comment_model.dart';
import 'package:kwon_tiktoc_clone/data/model/video_model.dart';

abstract interface class VideoDataSource {
  Future<List<VideoModel>> getVideoFeed({int page = 0});
  Future<VideoModel> toggleLike(String videoId);
  Future<VideoModel> toggleBookmark(String videoId);
  Future<List<CommentModel>> getComments(String videoId);
}
