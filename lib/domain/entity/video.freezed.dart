// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Video {

 String get id; String get userId; String get videoUrl; String get thumbnailUrl; String get description; String get musicName; int get likeCount; int get commentCount; int get bookmarkCount; int get shareCount; bool get isLiked; bool get isBookmarked; DateTime get createdAt;
/// Create a copy of Video
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoCopyWith<Video> get copyWith => _$VideoCopyWithImpl<Video>(this as Video, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Video&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.description, description) || other.description == description)&&(identical(other.musicName, musicName) || other.musicName == musicName)&&(identical(other.likeCount, likeCount) || other.likeCount == likeCount)&&(identical(other.commentCount, commentCount) || other.commentCount == commentCount)&&(identical(other.bookmarkCount, bookmarkCount) || other.bookmarkCount == bookmarkCount)&&(identical(other.shareCount, shareCount) || other.shareCount == shareCount)&&(identical(other.isLiked, isLiked) || other.isLiked == isLiked)&&(identical(other.isBookmarked, isBookmarked) || other.isBookmarked == isBookmarked)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,videoUrl,thumbnailUrl,description,musicName,likeCount,commentCount,bookmarkCount,shareCount,isLiked,isBookmarked,createdAt);

@override
String toString() {
  return 'Video(id: $id, userId: $userId, videoUrl: $videoUrl, thumbnailUrl: $thumbnailUrl, description: $description, musicName: $musicName, likeCount: $likeCount, commentCount: $commentCount, bookmarkCount: $bookmarkCount, shareCount: $shareCount, isLiked: $isLiked, isBookmarked: $isBookmarked, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $VideoCopyWith<$Res>  {
  factory $VideoCopyWith(Video value, $Res Function(Video) _then) = _$VideoCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String videoUrl, String thumbnailUrl, String description, String musicName, int likeCount, int commentCount, int bookmarkCount, int shareCount, bool isLiked, bool isBookmarked, DateTime createdAt
});




}
/// @nodoc
class _$VideoCopyWithImpl<$Res>
    implements $VideoCopyWith<$Res> {
  _$VideoCopyWithImpl(this._self, this._then);

  final Video _self;
  final $Res Function(Video) _then;

/// Create a copy of Video
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? videoUrl = null,Object? thumbnailUrl = null,Object? description = null,Object? musicName = null,Object? likeCount = null,Object? commentCount = null,Object? bookmarkCount = null,Object? shareCount = null,Object? isLiked = null,Object? isBookmarked = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,videoUrl: null == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: null == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,musicName: null == musicName ? _self.musicName : musicName // ignore: cast_nullable_to_non_nullable
as String,likeCount: null == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int,commentCount: null == commentCount ? _self.commentCount : commentCount // ignore: cast_nullable_to_non_nullable
as int,bookmarkCount: null == bookmarkCount ? _self.bookmarkCount : bookmarkCount // ignore: cast_nullable_to_non_nullable
as int,shareCount: null == shareCount ? _self.shareCount : shareCount // ignore: cast_nullable_to_non_nullable
as int,isLiked: null == isLiked ? _self.isLiked : isLiked // ignore: cast_nullable_to_non_nullable
as bool,isBookmarked: null == isBookmarked ? _self.isBookmarked : isBookmarked // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Video].
extension VideoPatterns on Video {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Video value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Video() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Video value)  $default,){
final _that = this;
switch (_that) {
case _Video():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Video value)?  $default,){
final _that = this;
switch (_that) {
case _Video() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String videoUrl,  String thumbnailUrl,  String description,  String musicName,  int likeCount,  int commentCount,  int bookmarkCount,  int shareCount,  bool isLiked,  bool isBookmarked,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Video() when $default != null:
return $default(_that.id,_that.userId,_that.videoUrl,_that.thumbnailUrl,_that.description,_that.musicName,_that.likeCount,_that.commentCount,_that.bookmarkCount,_that.shareCount,_that.isLiked,_that.isBookmarked,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String videoUrl,  String thumbnailUrl,  String description,  String musicName,  int likeCount,  int commentCount,  int bookmarkCount,  int shareCount,  bool isLiked,  bool isBookmarked,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Video():
return $default(_that.id,_that.userId,_that.videoUrl,_that.thumbnailUrl,_that.description,_that.musicName,_that.likeCount,_that.commentCount,_that.bookmarkCount,_that.shareCount,_that.isLiked,_that.isBookmarked,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String videoUrl,  String thumbnailUrl,  String description,  String musicName,  int likeCount,  int commentCount,  int bookmarkCount,  int shareCount,  bool isLiked,  bool isBookmarked,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Video() when $default != null:
return $default(_that.id,_that.userId,_that.videoUrl,_that.thumbnailUrl,_that.description,_that.musicName,_that.likeCount,_that.commentCount,_that.bookmarkCount,_that.shareCount,_that.isLiked,_that.isBookmarked,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _Video implements Video {
  const _Video({required this.id, required this.userId, required this.videoUrl, this.thumbnailUrl = '', this.description = '', this.musicName = '', this.likeCount = 0, this.commentCount = 0, this.bookmarkCount = 0, this.shareCount = 0, this.isLiked = false, this.isBookmarked = false, required this.createdAt});
  

@override final  String id;
@override final  String userId;
@override final  String videoUrl;
@override@JsonKey() final  String thumbnailUrl;
@override@JsonKey() final  String description;
@override@JsonKey() final  String musicName;
@override@JsonKey() final  int likeCount;
@override@JsonKey() final  int commentCount;
@override@JsonKey() final  int bookmarkCount;
@override@JsonKey() final  int shareCount;
@override@JsonKey() final  bool isLiked;
@override@JsonKey() final  bool isBookmarked;
@override final  DateTime createdAt;

/// Create a copy of Video
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VideoCopyWith<_Video> get copyWith => __$VideoCopyWithImpl<_Video>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Video&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.description, description) || other.description == description)&&(identical(other.musicName, musicName) || other.musicName == musicName)&&(identical(other.likeCount, likeCount) || other.likeCount == likeCount)&&(identical(other.commentCount, commentCount) || other.commentCount == commentCount)&&(identical(other.bookmarkCount, bookmarkCount) || other.bookmarkCount == bookmarkCount)&&(identical(other.shareCount, shareCount) || other.shareCount == shareCount)&&(identical(other.isLiked, isLiked) || other.isLiked == isLiked)&&(identical(other.isBookmarked, isBookmarked) || other.isBookmarked == isBookmarked)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,videoUrl,thumbnailUrl,description,musicName,likeCount,commentCount,bookmarkCount,shareCount,isLiked,isBookmarked,createdAt);

@override
String toString() {
  return 'Video(id: $id, userId: $userId, videoUrl: $videoUrl, thumbnailUrl: $thumbnailUrl, description: $description, musicName: $musicName, likeCount: $likeCount, commentCount: $commentCount, bookmarkCount: $bookmarkCount, shareCount: $shareCount, isLiked: $isLiked, isBookmarked: $isBookmarked, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$VideoCopyWith<$Res> implements $VideoCopyWith<$Res> {
  factory _$VideoCopyWith(_Video value, $Res Function(_Video) _then) = __$VideoCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String videoUrl, String thumbnailUrl, String description, String musicName, int likeCount, int commentCount, int bookmarkCount, int shareCount, bool isLiked, bool isBookmarked, DateTime createdAt
});




}
/// @nodoc
class __$VideoCopyWithImpl<$Res>
    implements _$VideoCopyWith<$Res> {
  __$VideoCopyWithImpl(this._self, this._then);

  final _Video _self;
  final $Res Function(_Video) _then;

/// Create a copy of Video
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? videoUrl = null,Object? thumbnailUrl = null,Object? description = null,Object? musicName = null,Object? likeCount = null,Object? commentCount = null,Object? bookmarkCount = null,Object? shareCount = null,Object? isLiked = null,Object? isBookmarked = null,Object? createdAt = null,}) {
  return _then(_Video(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,videoUrl: null == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: null == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,musicName: null == musicName ? _self.musicName : musicName // ignore: cast_nullable_to_non_nullable
as String,likeCount: null == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int,commentCount: null == commentCount ? _self.commentCount : commentCount // ignore: cast_nullable_to_non_nullable
as int,bookmarkCount: null == bookmarkCount ? _self.bookmarkCount : bookmarkCount // ignore: cast_nullable_to_non_nullable
as int,shareCount: null == shareCount ? _self.shareCount : shareCount // ignore: cast_nullable_to_non_nullable
as int,isLiked: null == isLiked ? _self.isLiked : isLiked // ignore: cast_nullable_to_non_nullable
as bool,isBookmarked: null == isBookmarked ? _self.isBookmarked : isBookmarked // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
