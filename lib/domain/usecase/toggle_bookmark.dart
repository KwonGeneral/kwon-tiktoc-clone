import 'package:kwon_tiktoc_clone/domain/entity/video.dart';
import 'package:kwon_tiktoc_clone/domain/repository/video_repository.dart';

class ToggleBookmark {
  final VideoRepository _repository;

  const ToggleBookmark(this._repository);

  Future<Video> call(String videoId) {
    return _repository.toggleBookmark(videoId);
  }
}
