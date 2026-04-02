import 'package:kwon_tiktoc_clone/domain/entity/video.dart';
import 'package:kwon_tiktoc_clone/domain/repository/video_repository.dart';

class GetVideoFeed {
  final VideoRepository _repository;

  const GetVideoFeed(this._repository);

  Future<List<Video>> call({int page = 0}) {
    return _repository.getVideoFeed(page: page);
  }
}
