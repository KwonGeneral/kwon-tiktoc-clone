import 'package:kwon_tiktoc_clone/data/model/post_image_model.dart';

abstract interface class PostImageDataSource {
  Future<List<PostImageModel>> getPostImages();
  Future<PostImageModel> uploadPostImage({
    required String filePath,
    required String caption,
    String? userId,
    String? avatarUrl,
    void Function(double progress)? onProgress,
  });
  Future<void> deletePostImage({required String imageId, required String userId});
}
