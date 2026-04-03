import 'package:kwon_tiktoc_clone/data/datasource/post_image_datasource.dart';
import 'package:kwon_tiktoc_clone/domain/entity/post_image.dart';
import 'package:kwon_tiktoc_clone/domain/repository/post_image_repository.dart';

class PostImageRepositoryImpl implements PostImageRepository {
  final PostImageDataSource _dataSource;

  const PostImageRepositoryImpl(this._dataSource);

  @override
  Future<List<PostImage>> getPostImages() async {
    final models = await _dataSource.getPostImages();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<PostImage> uploadPostImage({
    required String filePath,
    required String caption,
    String? userId,
    String? username,
    String? nickname,
    String? avatarUrl,
    void Function(double progress)? onProgress,
  }) async {
    final model = await _dataSource.uploadPostImage(
      filePath: filePath,
      caption: caption,
      userId: userId,
      username: username,
      nickname: nickname,
      avatarUrl: avatarUrl,
      onProgress: onProgress,
    );
    return model.toEntity();
  }

  @override
  Future<void> deletePostImage({
    required String imageId,
    required String userId,
  }) async {
    await _dataSource.deletePostImage(imageId: imageId, userId: userId);
  }
}
