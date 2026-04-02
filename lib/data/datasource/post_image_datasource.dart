import 'package:kwon_tiktoc_clone/data/model/post_image_model.dart';

abstract interface class PostImageDataSource {
  Future<List<PostImageModel>> getPostImages();
  Future<PostImageModel> uploadPostImage({
    required String filePath,
    required String caption,
    String? avatarUrl,
    void Function(double progress)? onProgress,
  });
}
