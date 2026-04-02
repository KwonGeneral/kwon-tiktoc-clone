// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_image.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PostImage {

 String get id; String get thumbUrl; String get fullUrl; String get caption; String get userId; String get username; String get nickname; String get avatarUrl; DateTime get createdAt;
/// Create a copy of PostImage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostImageCopyWith<PostImage> get copyWith => _$PostImageCopyWithImpl<PostImage>(this as PostImage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostImage&&(identical(other.id, id) || other.id == id)&&(identical(other.thumbUrl, thumbUrl) || other.thumbUrl == thumbUrl)&&(identical(other.fullUrl, fullUrl) || other.fullUrl == fullUrl)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,thumbUrl,fullUrl,caption,userId,username,nickname,avatarUrl,createdAt);

@override
String toString() {
  return 'PostImage(id: $id, thumbUrl: $thumbUrl, fullUrl: $fullUrl, caption: $caption, userId: $userId, username: $username, nickname: $nickname, avatarUrl: $avatarUrl, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $PostImageCopyWith<$Res>  {
  factory $PostImageCopyWith(PostImage value, $Res Function(PostImage) _then) = _$PostImageCopyWithImpl;
@useResult
$Res call({
 String id, String thumbUrl, String fullUrl, String caption, String userId, String username, String nickname, String avatarUrl, DateTime createdAt
});




}
/// @nodoc
class _$PostImageCopyWithImpl<$Res>
    implements $PostImageCopyWith<$Res> {
  _$PostImageCopyWithImpl(this._self, this._then);

  final PostImage _self;
  final $Res Function(PostImage) _then;

/// Create a copy of PostImage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? thumbUrl = null,Object? fullUrl = null,Object? caption = null,Object? userId = null,Object? username = null,Object? nickname = null,Object? avatarUrl = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,thumbUrl: null == thumbUrl ? _self.thumbUrl : thumbUrl // ignore: cast_nullable_to_non_nullable
as String,fullUrl: null == fullUrl ? _self.fullUrl : fullUrl // ignore: cast_nullable_to_non_nullable
as String,caption: null == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: null == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [PostImage].
extension PostImagePatterns on PostImage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostImage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostImage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostImage value)  $default,){
final _that = this;
switch (_that) {
case _PostImage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostImage value)?  $default,){
final _that = this;
switch (_that) {
case _PostImage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String thumbUrl,  String fullUrl,  String caption,  String userId,  String username,  String nickname,  String avatarUrl,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostImage() when $default != null:
return $default(_that.id,_that.thumbUrl,_that.fullUrl,_that.caption,_that.userId,_that.username,_that.nickname,_that.avatarUrl,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String thumbUrl,  String fullUrl,  String caption,  String userId,  String username,  String nickname,  String avatarUrl,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _PostImage():
return $default(_that.id,_that.thumbUrl,_that.fullUrl,_that.caption,_that.userId,_that.username,_that.nickname,_that.avatarUrl,_that.createdAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String thumbUrl,  String fullUrl,  String caption,  String userId,  String username,  String nickname,  String avatarUrl,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _PostImage() when $default != null:
return $default(_that.id,_that.thumbUrl,_that.fullUrl,_that.caption,_that.userId,_that.username,_that.nickname,_that.avatarUrl,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _PostImage implements PostImage {
  const _PostImage({required this.id, required this.thumbUrl, required this.fullUrl, this.caption = '', this.userId = '', this.username = '', this.nickname = '', this.avatarUrl = '', required this.createdAt});
  

@override final  String id;
@override final  String thumbUrl;
@override final  String fullUrl;
@override@JsonKey() final  String caption;
@override@JsonKey() final  String userId;
@override@JsonKey() final  String username;
@override@JsonKey() final  String nickname;
@override@JsonKey() final  String avatarUrl;
@override final  DateTime createdAt;

/// Create a copy of PostImage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostImageCopyWith<_PostImage> get copyWith => __$PostImageCopyWithImpl<_PostImage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostImage&&(identical(other.id, id) || other.id == id)&&(identical(other.thumbUrl, thumbUrl) || other.thumbUrl == thumbUrl)&&(identical(other.fullUrl, fullUrl) || other.fullUrl == fullUrl)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,thumbUrl,fullUrl,caption,userId,username,nickname,avatarUrl,createdAt);

@override
String toString() {
  return 'PostImage(id: $id, thumbUrl: $thumbUrl, fullUrl: $fullUrl, caption: $caption, userId: $userId, username: $username, nickname: $nickname, avatarUrl: $avatarUrl, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$PostImageCopyWith<$Res> implements $PostImageCopyWith<$Res> {
  factory _$PostImageCopyWith(_PostImage value, $Res Function(_PostImage) _then) = __$PostImageCopyWithImpl;
@override @useResult
$Res call({
 String id, String thumbUrl, String fullUrl, String caption, String userId, String username, String nickname, String avatarUrl, DateTime createdAt
});




}
/// @nodoc
class __$PostImageCopyWithImpl<$Res>
    implements _$PostImageCopyWith<$Res> {
  __$PostImageCopyWithImpl(this._self, this._then);

  final _PostImage _self;
  final $Res Function(_PostImage) _then;

/// Create a copy of PostImage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? thumbUrl = null,Object? fullUrl = null,Object? caption = null,Object? userId = null,Object? username = null,Object? nickname = null,Object? avatarUrl = null,Object? createdAt = null,}) {
  return _then(_PostImage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,thumbUrl: null == thumbUrl ? _self.thumbUrl : thumbUrl // ignore: cast_nullable_to_non_nullable
as String,fullUrl: null == fullUrl ? _self.fullUrl : fullUrl // ignore: cast_nullable_to_non_nullable
as String,caption: null == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: null == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
