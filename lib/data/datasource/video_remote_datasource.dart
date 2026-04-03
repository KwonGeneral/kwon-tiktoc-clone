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

  static const _sampleReplies = ['맞아요 ㅋㅋㅋ', '저도 공감해요!', '완전 동의합니다'];

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

      // metadata에 userId가 있으면 그대로 사용 (업로드된 영상),
      // 없으면 mock user와 일치하도록 index+1 기반 userId 할당
      final rawUserId = metadata['userId'] as String?;
      final userId = (rawUserId != null && rawUserId.isNotEmpty)
          ? rawUserId
          : 'user_${index + 1}';

      return VideoModel(
        id: 'video_${v['id']}',
        userId: userId,
        videoUrl: v['url'] as String,
        hlsUrl: v['hlsUrl'] as String? ?? '',
        thumbnailUrl: v['thumbnailUrl'] as String? ?? '',
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
    final videoHash = videoId.hashCode.abs();
    final count = 5 + (videoHash % 6); // 5~10개

    final comments = <CommentModel>[];

    for (var i = 0; i < count; i++) {
      final commentId = 'comment_${videoId}_$i';
      final replyCount = (i < 3) ? (2 - i).clamp(0, 3) : 0; // 첫 몇 개 댓글에 답글

      comments.add(
        CommentModel(
          id: commentId,
          videoId: videoId,
          userId: 'commenter_$i',
          userName: _commentUserNames[i % _commentUserNames.length],
          userAvatarUrl: 'https://i.pravatar.cc/150?img=${(i % 10) + 1}',
          text: _sampleComments[i % _sampleComments.length],
          likeCount: (i + 1) * 120,
          createdAt: now.subtract(Duration(hours: i * 2, minutes: i * 17)),
          replyCount: replyCount,
        ),
      );

      // 답글 생성
      for (var r = 0; r < replyCount; r++) {
        final replyUserIdx = (i + r + 3) % _commentUserNames.length;
        comments.add(
          CommentModel(
            id: 'reply_${commentId}_$r',
            videoId: videoId,
            userId: 'replier_${i}_$r',
            userName: _commentUserNames[replyUserIdx],
            userAvatarUrl:
                'https://i.pravatar.cc/150?img=${((i + r + 3) % 10) + 1}',
            text: _sampleReplies[r % _sampleReplies.length],
            likeCount: (r + 1) * 30,
            createdAt: now.subtract(
              Duration(hours: i * 2, minutes: i * 17 + r * 5 + 10),
            ),
            parentCommentId: commentId,
          ),
        );
      }
    }

    _comments[videoId] = comments;
    return comments;
  }

  @override
  Future<VideoModel> uploadVideo({
    required String filePath,
    required String description,
    String? title,
    String? tags,
    String? location,
    String? userId,
    String? username,
    String? nickname,
    String? avatarUrl,
    void Function(double progress)? onProgress,
  }) async {
    final file = File(filePath);
    if (!file.existsSync()) {
      throw Exception('파일을 찾을 수 없습니다: $filePath');
    }

    final uri = Uri.parse('$_baseUrl/videos/upload');
    final request = http.MultipartRequest('POST', uri);

    request.fields['description'] = description;
    request.fields['userId'] = userId ?? '';
    if (title != null && title.isNotEmpty) {
      request.fields['title'] = title;
    }
    if (tags != null && tags.isNotEmpty) {
      request.fields['tags'] = tags;
    }
    if (location != null && location.isNotEmpty) {
      request.fields['location'] = location;
    }
    if (username != null && username.isNotEmpty) {
      request.fields['username'] = username;
    }
    if (nickname != null && nickname.isNotEmpty) {
      request.fields['nickname'] = nickname;
    }
    if (avatarUrl != null && avatarUrl.isNotEmpty) {
      request.fields['avatarUrl'] = avatarUrl;
    }
    request.files.add(await http.MultipartFile.fromPath('video', filePath));

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

    // 서버 응답 파싱하여 Video 정보 반환
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final metadata = json['metadata'] as Map<String, dynamic>? ?? {};
    final videoId = json['id'];
    if (videoId == null) {
      throw Exception('업로드 응답에 id 필드가 없습니다');
    }

    final uploadedVideo = VideoModel(
      id: 'video_$videoId',
      userId: metadata['userId'] as String? ?? '',
      videoUrl: json['url'] as String? ?? '',
      hlsUrl: json['hlsUrl'] as String? ?? '',
      thumbnailUrl: json['thumbnailUrl'] as String? ?? '',
      description: description,
      musicName: 'Original Sound',
      username: metadata['username'] as String? ?? '',
      nickname: metadata['nickname'] as String? ?? '',
      avatarUrl: metadata['avatarUrl'] as String? ?? '',
      createdAt: DateTime.now(),
    );

    // 캐시 초기화하여 다음 피드 로드 시 새 영상 포함
    _cachedVideos = null;

    return uploadedVideo;
  }

  @override
  Future<void> deleteVideo({
    required String videoId,
    required String userId,
  }) async {
    // videoId 형식: "video_19" → 서버에는 숫자 id만 전달
    final serverId = videoId.replaceFirst('video_', '');

    final uri = Uri.parse('$_baseUrl/videos/$serverId').replace(
      queryParameters: {'userId': userId},
    );

    final response = await _client.delete(uri);

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('영상 삭제 실패: ${response.statusCode}');
    }

    // 캐시에서도 제거
    _cachedVideos?.removeWhere((v) => v.id == videoId);

    debugPrint('영상 삭제 완료: $videoId');
  }
}
