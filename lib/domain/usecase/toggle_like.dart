import 'package:supersent_tiktoc_clone/domain/entity/video.dart';
import 'package:supersent_tiktoc_clone/domain/repository/video_repository.dart';

class ToggleLike {
  final VideoRepository _repository;

  const ToggleLike(this._repository);

  Future<Video> call(String videoId) {
    return _repository.toggleLike(videoId);
  }
}
