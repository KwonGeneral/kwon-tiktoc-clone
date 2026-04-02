import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:kwon_tiktoc_clone/data/datasource/video_datasource.dart';
import 'package:kwon_tiktoc_clone/data/model/comment_model.dart';
import 'package:kwon_tiktoc_clone/data/model/video_model.dart';

class VideoRemoteDataSource implements VideoDataSource {
  VideoRemoteDataSource({http.Client? client})
    : _client = client ?? http.Client();

  final http.Client _client;

  static const _baseUrl = 'https://api.myfortie.com';

  List<VideoModel>? _cachedVideos;

  final Map<String, List<CommentModel>> _comments = {};

  static const _commentUserNames = [
    '꿈나라',
    '카르페디엠',
    'Mango Day',
    'ga든',
    '해피바이러스',
    '별빛소녀',
    '맛집헌터',
    '댄스킹',
    '여행러버',
    '일상기록',
  ];

  static const _sampleComments = [
    '와 대박 ㅋㅋㅋ',
    '이거 진짜 잘했다 👏',
    '나도 해보고 싶다!',
    '팔로우 했어요~',
    '다음 영상도 기대할게요 ❤️',
    '진짜 웃기다 ㅋㅋㅋㅋ',
    '이거 어디서 찍은거에요?',
    '오늘도 좋은 영상 감사해요!',
    '대박... 이건 못참지',
    '저도 해봤는데 너무 어렵더라고요 😂',
  ];

  static const _musicNames = [
    'Original Sound - @{username}',
    'Blinding Lights - The Weeknd',
    'Lo-fi Chill Beats',
    'Happy Vibes - Original',
    'Cooking ASMR - Original',
    'Nature Ambience',
    'Peaceful Morning',
    'City Lights - Original',
    'Sunset Melody',
    'Workout Mix 2024',
    'Drawing Time - art_studio',
    'Skater Anthem',
    'Golden Hour - sunset_chaser',
  ];

  Future<List<VideoModel>> _fetchVideos() async {
    if (_cachedVideos != null) return _cachedVideos!;

    final response = await _client.get(Uri.parse('$_baseUrl/videos'));

    if (response.statusCode != 200) {
      throw Exception('API 요청 실패: ${response.statusCode}');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final videosJson = json['videos'] as List<dynamic>;
    final now = DateTime.now();

    _cachedVideos = videosJson.asMap().entries.map((entry) {
      final index = entry.key;
      final v = entry.value as Map<String, dynamic>;
      final metadata = v['metadata'] as Map<String, dynamic>;
      final username = metadata['username'] as String? ?? '';

      final musicName = _musicNames[index % _musicNames.length].replaceAll(
        '{username}',
        username,
      );

      final tags = metadata['tags'] as String? ?? '';
      final description = metadata['description'] as String? ?? '';
      final hashTags = tags.isNotEmpty
          ? tags.split(',').map((t) => '#${t.trim()}').join(' ')
          : '';
      final fullDescription = hashTags.isNotEmpty
          ? '$description $hashTags'
          : description;

      return VideoModel(
        id: 'video_${v['id']}',
        userId: metadata['userId'] as String? ?? 'user_${v['id']}',
        videoUrl: v['url'] as String,
        description: fullDescription,
        musicName: musicName,
        username: username,
        nickname: metadata['nickname'] as String? ?? '',
        avatarUrl: metadata['avatarUrl'] as String? ?? '',
        likeCount: (index + 1) * 55000,
        commentCount: (index + 1) * 4170,
        bookmarkCount: (index + 1) * 24700,
        shareCount: (index + 1) * 13700,
        createdAt: now.subtract(Duration(hours: index * 3)),
      );
    }).toList();

    debugPrint('VideoRemoteDataSource: ${_cachedVideos!.length}개 영상 로드 완료');
    return _cachedVideos!;
  }

  @override
  Future<List<VideoModel>> getVideoFeed({int page = 0}) async {
    final videos = await _fetchVideos();

    const pageSize = 10;
    final start = page * pageSize;
    if (start >= videos.length) return [];

    final end = (start + pageSize).clamp(0, videos.length);
    return videos.sublist(start, end);
  }

  @override
  Future<VideoModel> toggleLike(String videoId) async {
    final videos = await _fetchVideos();
    final index = videos.indexWhere((v) => v.id == videoId);
    if (index == -1) throw Exception('Video not found: $videoId');

    final video = videos[index];
    final updated = video.copyWith(
      isLiked: !video.isLiked,
      likeCount: video.isLiked ? video.likeCount - 1 : video.likeCount + 1,
    );
    _cachedVideos![index] = updated;
    return updated;
  }

  @override
  Future<VideoModel> toggleBookmark(String videoId) async {
    final videos = await _fetchVideos();
    final index = videos.indexWhere((v) => v.id == videoId);
    if (index == -1) throw Exception('Video not found: $videoId');

    final video = videos[index];
    final updated = video.copyWith(
      isBookmarked: !video.isBookmarked,
      bookmarkCount: video.isBookmarked
          ? video.bookmarkCount - 1
          : video.bookmarkCount + 1,
    );
    _cachedVideos![index] = updated;
    return updated;
  }

  @override
  Future<List<CommentModel>> getComments(String videoId) async {
    if (_comments.containsKey(videoId)) return _comments[videoId]!;

    final now = DateTime.now();
    final videoNum = int.tryParse(videoId.replaceAll('video_', '')) ?? 0;
    final count = 5 + (videoNum % 6); // 5~10개
    final comments = List.generate(count, (i) {
      return CommentModel(
        id: 'comment_${videoId}_$i',
        videoId: videoId,
        userId: 'commenter_$i',
        userName: _commentUserNames[i % _commentUserNames.length],
        text: _sampleComments[i % _sampleComments.length],
        likeCount: (i + 1) * 120,
        createdAt: now.subtract(Duration(hours: i * 2, minutes: i * 17)),
      );
    });

    _comments[videoId] = comments;
    return comments;
  }

  @override
  Future<void> uploadVideo({
    required String filePath,
    required String description,
    void Function(double progress)? onProgress,
  }) async {
    final file = File(filePath);
    if (!file.existsSync()) {
      throw Exception('파일을 찾을 수 없습니다: $filePath');
    }

    final uri = Uri.parse('$_baseUrl/videos/upload');
    final request = http.MultipartRequest('POST', uri);

    request.fields['description'] = description;
    request.files.add(
      await http.MultipartFile.fromPath('video', filePath),
    );

    // 진행률 시뮬레이션 (http 패키지는 실제 업로드 진행률 미지원)
    onProgress?.call(0.0);

    final streamedResponse = await request.send();
    onProgress?.call(0.7);

    final response = await http.Response.fromStream(streamedResponse);
    onProgress?.call(1.0);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('업로드 실패: ${response.statusCode}');
    }

    debugPrint('업로드 완료: ${file.lengthSync()} bytes');

    // 캐시 초기화하여 다음 피드 로드 시 새 영상 포함
    _cachedVideos = null;
  }
}
