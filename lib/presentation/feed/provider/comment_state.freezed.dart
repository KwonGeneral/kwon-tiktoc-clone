// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CommentState {

 String get videoId; List<Comment> get comments; Set<String> get likedCommentIds; Set<String> get dislikedCommentIds; bool get isLoading;/// 댓글창이 열려있는지 여부
 bool get isOpen;/// 답글이 펼쳐진 댓글 ID 목록
 Set<String> get expandedReplyIds;/// 답글 입력 대상 댓글 ID (null이면 일반 댓글 입력)
 String? get replyingToCommentId;/// 답글 입력 대상 유저 이름
 String? get replyingToUserName;
/// Create a copy of CommentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentStateCopyWith<CommentState> get copyWith => _$CommentStateCopyWithImpl<CommentState>(this as CommentState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentState&&(identical(other.videoId, videoId) || other.videoId == videoId)&&const DeepCollectionEquality().equals(other.comments, comments)&&const DeepCollectionEquality().equals(other.likedCommentIds, likedCommentIds)&&const DeepCollectionEquality().equals(other.dislikedCommentIds, dislikedCommentIds)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&const DeepCollectionEquality().equals(other.expandedReplyIds, expandedReplyIds)&&(identical(other.replyingToCommentId, replyingToCommentId) || other.replyingToCommentId == replyingToCommentId)&&(identical(other.replyingToUserName, replyingToUserName) || other.replyingToUserName == replyingToUserName));
}


@override
int get hashCode => Object.hash(runtimeType,videoId,const DeepCollectionEquality().hash(comments),const DeepCollectionEquality().hash(likedCommentIds),const DeepCollectionEquality().hash(dislikedCommentIds),isLoading,isOpen,const DeepCollectionEquality().hash(expandedReplyIds),replyingToCommentId,replyingToUserName);

@override
String toString() {
  return 'CommentState(videoId: $videoId, comments: $comments, likedCommentIds: $likedCommentIds, dislikedCommentIds: $dislikedCommentIds, isLoading: $isLoading, isOpen: $isOpen, expandedReplyIds: $expandedReplyIds, replyingToCommentId: $replyingToCommentId, replyingToUserName: $replyingToUserName)';
}


}

/// @nodoc
abstract mixin class $CommentStateCopyWith<$Res>  {
  factory $CommentStateCopyWith(CommentState value, $Res Function(CommentState) _then) = _$CommentStateCopyWithImpl;
@useResult
$Res call({
 String videoId, List<Comment> comments, Set<String> likedCommentIds, Set<String> dislikedCommentIds, bool isLoading, bool isOpen, Set<String> expandedReplyIds, String? replyingToCommentId, String? replyingToUserName
});




}
/// @nodoc
class _$CommentStateCopyWithImpl<$Res>
    implements $CommentStateCopyWith<$Res> {
  _$CommentStateCopyWithImpl(this._self, this._then);

  final CommentState _self;
  final $Res Function(CommentState) _then;

/// Create a copy of CommentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? videoId = null,Object? comments = null,Object? likedCommentIds = null,Object? dislikedCommentIds = null,Object? isLoading = null,Object? isOpen = null,Object? expandedReplyIds = null,Object? replyingToCommentId = freezed,Object? replyingToUserName = freezed,}) {
  return _then(_self.copyWith(
videoId: null == videoId ? _self.videoId : videoId // ignore: cast_nullable_to_non_nullable
as String,comments: null == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as List<Comment>,likedCommentIds: null == likedCommentIds ? _self.likedCommentIds : likedCommentIds // ignore: cast_nullable_to_non_nullable
as Set<String>,dislikedCommentIds: null == dislikedCommentIds ? _self.dislikedCommentIds : dislikedCommentIds // ignore: cast_nullable_to_non_nullable
as Set<String>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,expandedReplyIds: null == expandedReplyIds ? _self.expandedReplyIds : expandedReplyIds // ignore: cast_nullable_to_non_nullable
as Set<String>,replyingToCommentId: freezed == replyingToCommentId ? _self.replyingToCommentId : replyingToCommentId // ignore: cast_nullable_to_non_nullable
as String?,replyingToUserName: freezed == replyingToUserName ? _self.replyingToUserName : replyingToUserName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CommentState].
extension CommentStatePatterns on CommentState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommentState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommentState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommentState value)  $default,){
final _that = this;
switch (_that) {
case _CommentState():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommentState value)?  $default,){
final _that = this;
switch (_that) {
case _CommentState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String videoId,  List<Comment> comments,  Set<String> likedCommentIds,  Set<String> dislikedCommentIds,  bool isLoading,  bool isOpen,  Set<String> expandedReplyIds,  String? replyingToCommentId,  String? replyingToUserName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentState() when $default != null:
return $default(_that.videoId,_that.comments,_that.likedCommentIds,_that.dislikedCommentIds,_that.isLoading,_that.isOpen,_that.expandedReplyIds,_that.replyingToCommentId,_that.replyingToUserName);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String videoId,  List<Comment> comments,  Set<String> likedCommentIds,  Set<String> dislikedCommentIds,  bool isLoading,  bool isOpen,  Set<String> expandedReplyIds,  String? replyingToCommentId,  String? replyingToUserName)  $default,) {final _that = this;
switch (_that) {
case _CommentState():
return $default(_that.videoId,_that.comments,_that.likedCommentIds,_that.dislikedCommentIds,_that.isLoading,_that.isOpen,_that.expandedReplyIds,_that.replyingToCommentId,_that.replyingToUserName);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String videoId,  List<Comment> comments,  Set<String> likedCommentIds,  Set<String> dislikedCommentIds,  bool isLoading,  bool isOpen,  Set<String> expandedReplyIds,  String? replyingToCommentId,  String? replyingToUserName)?  $default,) {final _that = this;
switch (_that) {
case _CommentState() when $default != null:
return $default(_that.videoId,_that.comments,_that.likedCommentIds,_that.dislikedCommentIds,_that.isLoading,_that.isOpen,_that.expandedReplyIds,_that.replyingToCommentId,_that.replyingToUserName);case _:
  return null;

}
}

}

/// @nodoc


class _CommentState implements CommentState {
  const _CommentState({this.videoId = '', final  List<Comment> comments = const [], final  Set<String> likedCommentIds = const {}, final  Set<String> dislikedCommentIds = const {}, this.isLoading = false, this.isOpen = false, final  Set<String> expandedReplyIds = const {}, this.replyingToCommentId, this.replyingToUserName}): _comments = comments,_likedCommentIds = likedCommentIds,_dislikedCommentIds = dislikedCommentIds,_expandedReplyIds = expandedReplyIds;
  

@override@JsonKey() final  String videoId;
 final  List<Comment> _comments;
@override@JsonKey() List<Comment> get comments {
  if (_comments is EqualUnmodifiableListView) return _comments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_comments);
}

 final  Set<String> _likedCommentIds;
@override@JsonKey() Set<String> get likedCommentIds {
  if (_likedCommentIds is EqualUnmodifiableSetView) return _likedCommentIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_likedCommentIds);
}

 final  Set<String> _dislikedCommentIds;
@override@JsonKey() Set<String> get dislikedCommentIds {
  if (_dislikedCommentIds is EqualUnmodifiableSetView) return _dislikedCommentIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_dislikedCommentIds);
}

@override@JsonKey() final  bool isLoading;
/// 댓글창이 열려있는지 여부
@override@JsonKey() final  bool isOpen;
/// 답글이 펼쳐진 댓글 ID 목록
 final  Set<String> _expandedReplyIds;
/// 답글이 펼쳐진 댓글 ID 목록
@override@JsonKey() Set<String> get expandedReplyIds {
  if (_expandedReplyIds is EqualUnmodifiableSetView) return _expandedReplyIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_expandedReplyIds);
}

/// 답글 입력 대상 댓글 ID (null이면 일반 댓글 입력)
@override final  String? replyingToCommentId;
/// 답글 입력 대상 유저 이름
@override final  String? replyingToUserName;

/// Create a copy of CommentState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentStateCopyWith<_CommentState> get copyWith => __$CommentStateCopyWithImpl<_CommentState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentState&&(identical(other.videoId, videoId) || other.videoId == videoId)&&const DeepCollectionEquality().equals(other._comments, _comments)&&const DeepCollectionEquality().equals(other._likedCommentIds, _likedCommentIds)&&const DeepCollectionEquality().equals(other._dislikedCommentIds, _dislikedCommentIds)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&const DeepCollectionEquality().equals(other._expandedReplyIds, _expandedReplyIds)&&(identical(other.replyingToCommentId, replyingToCommentId) || other.replyingToCommentId == replyingToCommentId)&&(identical(other.replyingToUserName, replyingToUserName) || other.replyingToUserName == replyingToUserName));
}


@override
int get hashCode => Object.hash(runtimeType,videoId,const DeepCollectionEquality().hash(_comments),const DeepCollectionEquality().hash(_likedCommentIds),const DeepCollectionEquality().hash(_dislikedCommentIds),isLoading,isOpen,const DeepCollectionEquality().hash(_expandedReplyIds),replyingToCommentId,replyingToUserName);

@override
String toString() {
  return 'CommentState(videoId: $videoId, comments: $comments, likedCommentIds: $likedCommentIds, dislikedCommentIds: $dislikedCommentIds, isLoading: $isLoading, isOpen: $isOpen, expandedReplyIds: $expandedReplyIds, replyingToCommentId: $replyingToCommentId, replyingToUserName: $replyingToUserName)';
}


}

/// @nodoc
abstract mixin class _$CommentStateCopyWith<$Res> implements $CommentStateCopyWith<$Res> {
  factory _$CommentStateCopyWith(_CommentState value, $Res Function(_CommentState) _then) = __$CommentStateCopyWithImpl;
@override @useResult
$Res call({
 String videoId, List<Comment> comments, Set<String> likedCommentIds, Set<String> dislikedCommentIds, bool isLoading, bool isOpen, Set<String> expandedReplyIds, String? replyingToCommentId, String? replyingToUserName
});




}
/// @nodoc
class __$CommentStateCopyWithImpl<$Res>
    implements _$CommentStateCopyWith<$Res> {
  __$CommentStateCopyWithImpl(this._self, this._then);

  final _CommentState _self;
  final $Res Function(_CommentState) _then;

/// Create a copy of CommentState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? videoId = null,Object? comments = null,Object? likedCommentIds = null,Object? dislikedCommentIds = null,Object? isLoading = null,Object? isOpen = null,Object? expandedReplyIds = null,Object? replyingToCommentId = freezed,Object? replyingToUserName = freezed,}) {
  return _then(_CommentState(
videoId: null == videoId ? _self.videoId : videoId // ignore: cast_nullable_to_non_nullable
as String,comments: null == comments ? _self._comments : comments // ignore: cast_nullable_to_non_nullable
as List<Comment>,likedCommentIds: null == likedCommentIds ? _self._likedCommentIds : likedCommentIds // ignore: cast_nullable_to_non_nullable
as Set<String>,dislikedCommentIds: null == dislikedCommentIds ? _self._dislikedCommentIds : dislikedCommentIds // ignore: cast_nullable_to_non_nullable
as Set<String>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,expandedReplyIds: null == expandedReplyIds ? _self._expandedReplyIds : expandedReplyIds // ignore: cast_nullable_to_non_nullable
as Set<String>,replyingToCommentId: freezed == replyingToCommentId ? _self.replyingToCommentId : replyingToCommentId // ignore: cast_nullable_to_non_nullable
as String?,replyingToUserName: freezed == replyingToUserName ? _self.replyingToUserName : replyingToUserName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
