import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:kwon_tiktoc_clone/core/constants/app_strings.dart';
import 'package:kwon_tiktoc_clone/core/di/providers.dart';
import 'package:kwon_tiktoc_clone/domain/entity/comment.dart';
import 'package:kwon_tiktoc_clone/domain/repository/local_storage_repository.dart';
import 'package:kwon_tiktoc_clone/presentation/feed/provider/comment_state.dart';
import 'package:kwon_tiktoc_clone/presentation/feed/provider/feed_provider.dart';

part 'comment_provider.g.dart';

@riverpod
class CommentNotifier extends _$CommentNotifier {
  late final LocalStorageRepository _storage;

  @override
  CommentState build() {
    _storage = ref.read(localStorageRepositoryProvider);
    return const CommentState();
  }

  Future<void> loadComments(String videoId) async {
    state = state.copyWith(isLoading: true, videoId: videoId);

    final getComments = ref.read(getCommentsProvider);
    final serverComments = await getComments(videoId);

    // 로컬에 저장된 사용자 작성 댓글 로드
    final userComments = _loadUserComments(videoId);

    final allComments = [...userComments, ...serverComments];

    // 좋아요/싫어요 상태 적용
    final likedIds = _storage.getLikedCommentIds();
    final dislikedIds = _storage.getDislikedCommentIds();

    state = state.copyWith(
      comments: allComments,
      likedCommentIds: likedIds,
      dislikedCommentIds: dislikedIds,
      isLoading: false,
      videoId: videoId,
    );
  }

  List<Comment> _loadUserComments(String videoId) {
    try {
      final json = _storage.getUserCommentsJson();
      final list = jsonDecode(json) as List<dynamic>;

      return list
          .where((item) => item['videoId'] == videoId)
          .map(
            (item) => Comment(
              id: item['id'] as String,
              videoId: item['videoId'] as String,
              userId: item['userId'] as String,
              userName: item['userName'] as String? ?? '',
              text: item['text'] as String,
              likeCount: 0,
              createdAt: DateTime.parse(item['createdAt'] as String),
            ),
          )
          .toList();
    } on FormatException {
      return [];
    }
  }

  Future<void> addComment(String text) async {
    final videoId = state.videoId;
    if (videoId.isEmpty || text.trim().isEmpty) return;

    final now = DateTime.now();
    final comment = Comment(
      id: 'user_comment_${now.millisecondsSinceEpoch}',
      videoId: videoId,
      userId: AppStrings.commentCurrentUserId,
      userName: AppStrings.commentCurrentUserName,
      text: text.trim(),
      likeCount: 0,
      createdAt: now,
    );

    // UI 업데이트
    state = state.copyWith(comments: [comment, ...state.comments]);

    // 로컬 저장
    await _saveUserComment(comment);

    // FeedState의 commentCount 업데이트
    ref.read(feedNotifierProvider.notifier).incrementCommentCount(videoId);
  }

  Future<void> _saveUserComment(Comment comment) async {
    List<dynamic> list;
    try {
      final json = _storage.getUserCommentsJson();
      list = jsonDecode(json) as List<dynamic>;
    } on FormatException {
      list = [];
    }

    list.insert(0, {
      'id': comment.id,
      'videoId': comment.videoId,
      'userId': comment.userId,
      'userName': comment.userName,
      'text': comment.text,
      'createdAt': comment.createdAt.toIso8601String(),
    });

    await _storage.saveUserCommentsJson(jsonEncode(list));
  }

  Future<void> toggleCommentLike(String commentId) async {
    final likedIds = {...state.likedCommentIds};
    final dislikedIds = {...state.dislikedCommentIds};

    // 싫어요 되어 있으면 해제
    dislikedIds.remove(commentId);

    if (likedIds.contains(commentId)) {
      likedIds.remove(commentId);
    } else {
      likedIds.add(commentId);
    }

    state = state.copyWith(
      likedCommentIds: likedIds,
      dislikedCommentIds: dislikedIds,
    );

    await _storage.saveLikedCommentIds(likedIds);
    await _storage.saveDislikedCommentIds(dislikedIds);
  }

  Future<void> toggleCommentDislike(String commentId) async {
    final likedIds = {...state.likedCommentIds};
    final dislikedIds = {...state.dislikedCommentIds};

    // 좋아요 되어 있으면 해제
    likedIds.remove(commentId);

    if (dislikedIds.contains(commentId)) {
      dislikedIds.remove(commentId);
    } else {
      dislikedIds.add(commentId);
    }

    state = state.copyWith(
      likedCommentIds: likedIds,
      dislikedCommentIds: dislikedIds,
    );

    await _storage.saveLikedCommentIds(likedIds);
    await _storage.saveDislikedCommentIds(dislikedIds);
  }
}
