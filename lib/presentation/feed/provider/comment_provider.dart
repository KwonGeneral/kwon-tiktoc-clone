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

  /// 댓글창 열기
  Future<void> open(String videoId) async {
    state = state.copyWith(isOpen: true);
    await loadComments(videoId);
  }

  /// 댓글창 닫기
  void close() {
    state = state.copyWith(
      isOpen: false,
      replyingToCommentId: null,
      replyingToUserName: null,
    );
  }

  Future<void> loadComments(String videoId) async {
    // 로컬 댓글과 좋아요/싫어요 상태를 먼저 즉시 표시 (optimistic)
    final userComments = _loadUserComments(videoId);
    final likedIds = _storage.getLikedCommentIds();
    final dislikedIds = _storage.getDislikedCommentIds();

    state = state.copyWith(
      comments: userComments,
      likedCommentIds: likedIds,
      dislikedCommentIds: dislikedIds,
      isLoading: userComments.isEmpty,
      videoId: videoId,
    );

    // 서버 댓글을 비동기로 로드하여 병합
    final getComments = ref.read(getCommentsProvider);
    final serverComments = await getComments(videoId);

    // 로컬 댓글 ID 집합 (중복 방지)
    final userCommentIds = userComments.map((c) => c.id).toSet();
    final mergedComments = [
      ...userComments,
      ...serverComments.where((c) => !userCommentIds.contains(c.id)),
    ];

    state = state.copyWith(comments: mergedComments, isLoading: false);
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
              parentCommentId: item['parentCommentId'] as String?,
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
    final replyingTo = state.replyingToCommentId;

    final comment = Comment(
      id: 'user_comment_${now.millisecondsSinceEpoch}',
      videoId: videoId,
      userId: AppStrings.commentCurrentUserId,
      userName: AppStrings.commentCurrentUserName,
      text: text.trim(),
      likeCount: 0,
      createdAt: now,
      parentCommentId: replyingTo,
    );

    if (replyingTo != null) {
      // 답글: 부모 댓글의 replyCount 증가 + 답글 목록에 추가
      final updatedComments = state.comments.map((c) {
        if (c.id == replyingTo) {
          return c.copyWith(replyCount: c.replyCount + 1);
        }
        return c;
      }).toList();
      updatedComments.add(comment);

      // 답글을 달면 해당 댓글의 답글을 펼침
      final expandedIds = {...state.expandedReplyIds, replyingTo};

      state = state.copyWith(
        comments: updatedComments,
        expandedReplyIds: expandedIds,
        replyingToCommentId: null,
        replyingToUserName: null,
      );
    } else {
      // 일반 댓글
      state = state.copyWith(
        comments: [comment, ...state.comments],
        replyingToCommentId: null,
        replyingToUserName: null,
      );
    }

    // 로컬 저장
    await _saveUserComment(comment);

    // FeedState의 commentCount 업데이트 (최상위 댓글만)
    if (replyingTo == null) {
      ref.read(feedNotifierProvider.notifier).incrementCommentCount(videoId);
    }
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
      'parentCommentId': comment.parentCommentId,
    });

    await _storage.saveUserCommentsJson(jsonEncode(list));
  }

  /// 답글 입력 모드 시작
  void startReply(String commentId, String userName) {
    state = state.copyWith(
      replyingToCommentId: commentId,
      replyingToUserName: userName,
    );
  }

  /// 답글 입력 모드 취소
  void cancelReply() {
    state = state.copyWith(replyingToCommentId: null, replyingToUserName: null);
  }

  /// 답글 펼치기/접기 토글
  void toggleReplies(String commentId) {
    final expanded = {...state.expandedReplyIds};
    if (expanded.contains(commentId)) {
      expanded.remove(commentId);
    } else {
      expanded.add(commentId);
    }
    state = state.copyWith(expandedReplyIds: expanded);
  }

  /// 특정 댓글의 답글 목록
  List<Comment> getReplies(String commentId) {
    return state.comments.where((c) => c.parentCommentId == commentId).toList();
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
