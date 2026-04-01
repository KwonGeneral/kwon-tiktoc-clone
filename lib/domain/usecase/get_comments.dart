import 'package:supersent_tiktoc_clone/domain/entity/comment.dart';
import 'package:supersent_tiktoc_clone/domain/repository/video_repository.dart';

class GetComments {
  final VideoRepository _repository;

  const GetComments(this._repository);

  Future<List<Comment>> call(String videoId) {
    return _repository.getComments(videoId);
  }
}
