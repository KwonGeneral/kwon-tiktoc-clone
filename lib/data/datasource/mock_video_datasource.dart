import 'package:kwon_tiktoc_clone/core/constants/app_constants.dart';
import 'package:kwon_tiktoc_clone/data/datasource/video_datasource.dart';
import 'package:kwon_tiktoc_clone/data/model/comment_model.dart';
import 'package:kwon_tiktoc_clone/data/model/video_model.dart';

class MockVideoDataSource implements VideoDataSource {
  late final List<VideoModel> _videos = _generateVideos();
  late final Map<String, List<CommentModel>> _comments = _generateComments();

  List<VideoModel> _generateVideos() {
    final now = DateTime.now();
    final descriptions = [
      '이 댄스 챌린지 해봤어? #댄스챌린지 #틱톡',
      '여행 중 발견한 숨겨진 명소 #여행 #히든스팟',
      '3분 만에 완성하는 초간단 레시피 #요리 #레시피',
      '우리 강아지가 또... 😂 #반려동물 #귀여워',
      '매일 10분 홈트로 변화 가져오기 #운동 #홈트',
      '이거 보고 안 웃으면 돌이라고 ㅋㅋ #웃긴영상',
      '새벽 감성 플레이리스트 🎵 #음악 #감성',
      '30초 만에 그리는 캐릭터 일러스트 #그림 #아트',
      '도심 속 힐링 산책 코스 추천 #산책 #자연',
      '이 떡볶이 맛집 진짜 미쳤다 #맛집 #먹방',
      '아침 요가 루틴으로 하루 시작하기 #요가 #모닝루틴',
      '이 트릭 성공하는 데 100번 걸렸어요 #스케이트보드',
      '오늘의 일몰이 역대급이었음 #일몰 #풍경',
    ];
    final musicNames = [
      'Original Sound - dance_queen',
      'Blinding Lights - The Weeknd',
      'Cooking ASMR - Original',
      'Happy Dog Song - pet_lover',
      'Workout Mix 2024',
      'Funny Sound Effect',
      'Lo-fi Chill Beats',
      'Drawing Time - art_studio',
      'Nature Ambience',
      'Mukbang Beats',
      'Peaceful Morning - yoga_life',
      'Skater Anthem',
      'Golden Hour - sunset_chaser',
    ];

    return List.generate(13, (index) {
      final i = index + 1;
      return VideoModel(
        id: 'video_$i',
        userId: 'user_$i',
        videoUrl: '${AppConstants.videoBaseUrl}/full-hd/$i.mp4',
        description: descriptions[index],
        musicName: musicNames[index],
        likeCount: (index + 1) * 55000,
        commentCount: (index + 1) * 4170,
        bookmarkCount: (index + 1) * 24700,
        shareCount: (index + 1) * 13700,
        createdAt: now.subtract(Duration(hours: index * 3)),
      );
    });
  }

  Map<String, List<CommentModel>> _generateComments() {
    final now = DateTime.now();
    final comments = <String, List<CommentModel>>{};

    for (var videoIndex = 0; videoIndex < 13; videoIndex++) {
      final videoId = 'video_${videoIndex + 1}';
      final count = 5 + (videoIndex % 6); // 5~10개
      comments[videoId] = List.generate(count, (commentIndex) {
        return CommentModel(
          id: 'comment_${videoId}_$commentIndex',
          videoId: videoId,
          userId: 'commenter_$commentIndex',
          userName: _commentUserNames[commentIndex % _commentUserNames.length],
          text: _sampleComments[commentIndex % _sampleComments.length],
          likeCount: (commentIndex + 1) * 120,
          createdAt: now.subtract(
            Duration(hours: commentIndex * 2, minutes: commentIndex * 17),
          ),
        );
      });
    }

    return comments;
  }

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

  /// 총 제공할 최대 비디오 수 (순환하여 생성)
  static const _maxTotalVideos = 50;

  @override
  Future<List<VideoModel>> getVideoFeed({int page = 0}) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));

    final start = page * AppConstants.videoPageSize;
    if (start >= _maxTotalVideos) return [];

    final end = (start + AppConstants.videoPageSize).clamp(0, _maxTotalVideos);
    final result = <VideoModel>[];

    for (var i = start; i < end; i++) {
      final sourceIndex = i % _videos.length;
      final source = _videos[sourceIndex];
      result.add(
        source.copyWith(
          id: 'video_${i + 1}',
          createdAt: source.createdAt.subtract(Duration(hours: i * 3)),
        ),
      );
    }

    return result;
  }

  @override
  Future<VideoModel> toggleLike(String videoId) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));

    final index = _videos.indexWhere((v) => v.id == videoId);
    if (index == -1) throw Exception('Video not found: $videoId');

    final video = _videos[index];
    final updated = video.copyWith(
      isLiked: !video.isLiked,
      likeCount: video.isLiked ? video.likeCount - 1 : video.likeCount + 1,
    );
    _videos[index] = updated;
    return updated;
  }

  @override
  Future<VideoModel> toggleBookmark(String videoId) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));

    final index = _videos.indexWhere((v) => v.id == videoId);
    if (index == -1) throw Exception('Video not found: $videoId');

    final video = _videos[index];
    final updated = video.copyWith(
      isBookmarked: !video.isBookmarked,
      bookmarkCount: video.isBookmarked
          ? video.bookmarkCount - 1
          : video.bookmarkCount + 1,
    );
    _videos[index] = updated;
    return updated;
  }

  @override
  Future<List<CommentModel>> getComments(String videoId) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return _comments[videoId] ?? [];
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
    await Future<void>.delayed(const Duration(seconds: 2));
    onProgress?.call(1.0);
    return VideoModel(
      id: 'video_mock_${DateTime.now().millisecondsSinceEpoch}',
      userId: 'mock_user',
      videoUrl: filePath,
      description: description,
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<void> deleteVideo({
    required String videoId,
    required String userId,
  }) async {
    _videos.removeWhere((v) => v.id == videoId);
  }
}
