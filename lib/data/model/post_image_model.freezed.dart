// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_image_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostImageModel {

 String get id; String get thumbUrl; String get fullUrl; String get caption; String get userId; String get username; String get nickname; String get avatarUrl; DateTime get createdAt;
/// Create a copy of PostImageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostImageModelCopyWith<PostImageModel> get copyWith => _$PostImageModelCopyWithImpl<PostImageModel>(this as PostImageModel, _$identity);

  /// Serializes this PostImageModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostImageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.thumbUrl, thumbUrl) || other.thumbUrl == thumbUrl)&&(identical(other.fullUrl, fullUrl) || other.fullUrl == fullUrl)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,thumbUrl,fullUrl,caption,userId,username,nickname,avatarUrl,createdAt);

@override
String toString() {
  return 'PostImageModel(id: $id, thumbUrl: $thumbUrl, fullUrl: $fullUrl, caption: $caption, userId: $userId, username: $username, nickname: $nickname, avatarUrl: $avatarUrl, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $PostImageModelCopyWith<$Res>  {
  factory $PostImageModelCopyWith(PostImageModel value, $Res Function(PostImageModel) _then) = _$PostImageModelCopyWithImpl;
@useResult
$Res call({
 String id, String thumbUrl, String fullUrl, String caption, String userId, String username, String nickname, String avatarUrl, DateTime createdAt
});




}
/// @nodoc
class _$PostImageModelCopyWithImpl<$Res>
    implements $PostImageModelCopyWith<$Res> {
  _$PostImageModelCopyWithImpl(this._self, this._then);

  final PostImageModel _self;
  final $Res Function(PostImageModel) _then;

/// Create a copy of PostImageModel
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


/// Adds pattern-matching-related methods to [PostImageModel].
extension PostImageModelPatterns on PostImageModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostImageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostImageModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostImageModel value)  $default,){
final _that = this;
switch (_that) {
case _PostImageModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostImageModel value)?  $default,){
final _that = this;
switch (_that) {
case _PostImageModel() when $default != null:
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
case _PostImageModel() when $default != null:
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
case _PostImageModel():
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
case _PostImageModel() when $default != null:
return $default(_that.id,_that.thumbUrl,_that.fullUrl,_that.caption,_that.userId,_that.username,_that.nickname,_that.avatarUrl,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostImageModel extends PostImageModel {
  const _PostImageModel({required this.id, required this.thumbUrl, required this.fullUrl, this.caption = '', this.userId = '', this.username = '', this.nickname = '', this.avatarUrl = '', required this.createdAt}): super._();
  factory _PostImageModel.fromJson(Map<String, dynamic> json) => _$PostImageModelFromJson(json);

@override final  String id;
@override final  String thumbUrl;
@override final  String fullUrl;
@override@JsonKey() final  String caption;
@override@JsonKey() final  String userId;
@override@JsonKey() final  String username;
@override@JsonKey() final  String nickname;
@override@JsonKey() final  String avatarUrl;
@override final  DateTime createdAt;

/// Create a copy of PostImageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostImageModelCopyWith<_PostImageModel> get copyWith => __$PostImageModelCopyWithImpl<_PostImageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostImageModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostImageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.thumbUrl, thumbUrl) || other.thumbUrl == thumbUrl)&&(identical(other.fullUrl, fullUrl) || other.fullUrl == fullUrl)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,thumbUrl,fullUrl,caption,userId,username,nickname,avatarUrl,createdAt);

@override
String toString() {
  return 'PostImageModel(id: $id, thumbUrl: $thumbUrl, fullUrl: $fullUrl, caption: $caption, userId: $userId, username: $username, nickname: $nickname, avatarUrl: $avatarUrl, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$PostImageModelCopyWith<$Res> implements $PostImageModelCopyWith<$Res> {
  factory _$PostImageModelCopyWith(_PostImageModel value, $Res Function(_PostImageModel) _then) = __$PostImageModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String thumbUrl, String fullUrl, String caption, String userId, String username, String nickname, String avatarUrl, DateTime createdAt
});




}
/// @nodoc
class __$PostImageModelCopyWithImpl<$Res>
    implements _$PostImageModelCopyWith<$Res> {
  __$PostImageModelCopyWithImpl(this._self, this._then);

  final _PostImageModel _self;
  final $Res Function(_PostImageModel) _then;

/// Create a copy of PostImageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? thumbUrl = null,Object? fullUrl = null,Object? caption = null,Object? userId = null,Object? username = null,Object? nickname = null,Object? avatarUrl = null,Object? createdAt = null,}) {
  return _then(_PostImageModel(
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
