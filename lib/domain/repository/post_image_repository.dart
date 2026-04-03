import 'package:kwon_tiktoc_clone/domain/entity/post_image.dart';

abstract interface class PostImageRepository {
  Future<List<PostImage>> getPostImages();
  Future<PostImage> uploadPostImage({
    required String filePath,
    required String caption,
    String? userId,
    String? avatarUrl,
    void Function(double progress)? onProgress,
  });
  Future<void> deletePostImage({required String imageId, required String userId});
}
