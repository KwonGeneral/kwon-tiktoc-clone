import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:kwon_tiktoc_clone/data/datasource/post_image_datasource.dart';
import 'package:kwon_tiktoc_clone/data/model/post_image_model.dart';

class PostImageRemoteDataSource implements PostImageDataSource {
  PostImageRemoteDataSource({http.Client? client})
    : _client = client ?? http.Client();

  final http.Client _client;

  static const _baseUrl = 'https://api.myfortie.com';
  static const _currentUserId = 'current_user';

  List<PostImageModel>? _cachedImages;

  @override
  Future<List<PostImageModel>> getPostImages() async {
    if (_cachedImages != null) return _cachedImages!;

    final response = await _client.get(Uri.parse('$_baseUrl/videos/images'));

    if (response.statusCode != 200) {
      throw Exception('이미지 목록 조회 실패: ${response.statusCode}');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final imagesJson = json['images'] as List<dynamic>;

    _cachedImages = imagesJson.map((item) {
      final v = item as Map<String, dynamic>;
      final metadata = v['metadata'] as Map<String, dynamic>? ?? {};

      return PostImageModel(
        id: v['id'] as String? ?? '',
        thumbUrl: v['thumbUrl'] as String? ?? '',
        fullUrl: v['fullUrl'] as String? ?? '',
        caption: metadata['caption'] as String? ?? '',
        userId: metadata['userId'] as String? ?? '',
        username: metadata['username'] as String? ?? '',
        nickname: metadata['nickname'] as String? ?? '',
        avatarUrl: metadata['avatarUrl'] as String? ?? '',
        createdAt:
            DateTime.tryParse(v['lastModified'] as String? ?? '') ??
            DateTime.now(),
      );
    }).toList();

    debugPrint(
      'PostImageRemoteDataSource: ${_cachedImages!.length}개 이미지 로드 완료',
    );
    return _cachedImages!;
  }

  @override
  Future<PostImageModel> uploadPostImage({
    required String filePath,
    required String caption,
    String? avatarUrl,
    void Function(double progress)? onProgress,
  }) async {
    final file = File(filePath);
    if (!file.existsSync()) {
      throw Exception('파일을 찾을 수 없습니다: $filePath');
    }

    final uri = Uri.parse('$_baseUrl/videos/images/upload');
    final request = http.MultipartRequest('POST', uri);

    request.fields['caption'] = caption;
    request.fields['userId'] = _currentUserId;
    if (avatarUrl != null && avatarUrl.isNotEmpty) {
      request.fields['avatarUrl'] = avatarUrl;
    }
    request.files.add(await http.MultipartFile.fromPath('image', filePath));

    onProgress?.call(0.0);

    final streamedResponse = await request.send();
    onProgress?.call(0.7);

    final response = await http.Response.fromStream(streamedResponse);
    onProgress?.call(1.0);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('이미지 업로드 실패: ${response.statusCode}');
    }

    debugPrint('이미지 업로드 완료: ${file.lengthSync()} bytes');

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final metadata = json['metadata'] as Map<String, dynamic>? ?? {};

    final uploaded = PostImageModel(
      id: json['id'] as String? ?? '',
      thumbUrl: json['thumbUrl'] as String? ?? '',
      fullUrl: json['fullUrl'] as String? ?? '',
      caption: metadata['caption'] as String? ?? caption,
      userId: metadata['userId'] as String? ?? _currentUserId,
      username: metadata['username'] as String? ?? '',
      nickname: metadata['nickname'] as String? ?? '',
      avatarUrl: metadata['avatarUrl'] as String? ?? '',
      createdAt: DateTime.now(),
    );

    _cachedImages = null;

    return uploaded;
  }
}
