// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'publish_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PublishState {

 PublishStatus get status; double get progress; String? get errorMessage; String? get uploadedVideoUrl; String? get uploadedDescription; String? get thumbnailPath;
/// Create a copy of PublishState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PublishStateCopyWith<PublishState> get copyWith => _$PublishStateCopyWithImpl<PublishState>(this as PublishState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PublishState&&(identical(other.status, status) || other.status == status)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.uploadedVideoUrl, uploadedVideoUrl) || other.uploadedVideoUrl == uploadedVideoUrl)&&(identical(other.uploadedDescription, uploadedDescription) || other.uploadedDescription == uploadedDescription)&&(identical(other.thumbnailPath, thumbnailPath) || other.thumbnailPath == thumbnailPath));
}


@override
int get hashCode => Object.hash(runtimeType,status,progress,errorMessage,uploadedVideoUrl,uploadedDescription,thumbnailPath);

@override
String toString() {
  return 'PublishState(status: $status, progress: $progress, errorMessage: $errorMessage, uploadedVideoUrl: $uploadedVideoUrl, uploadedDescription: $uploadedDescription, thumbnailPath: $thumbnailPath)';
}


}

/// @nodoc
abstract mixin class $PublishStateCopyWith<$Res>  {
  factory $PublishStateCopyWith(PublishState value, $Res Function(PublishState) _then) = _$PublishStateCopyWithImpl;
@useResult
$Res call({
 PublishStatus status, double progress, String? errorMessage, String? uploadedVideoUrl, String? uploadedDescription, String? thumbnailPath
});




}
/// @nodoc
class _$PublishStateCopyWithImpl<$Res>
    implements $PublishStateCopyWith<$Res> {
  _$PublishStateCopyWithImpl(this._self, this._then);

  final PublishState _self;
  final $Res Function(PublishState) _then;

/// Create a copy of PublishState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? progress = null,Object? errorMessage = freezed,Object? uploadedVideoUrl = freezed,Object? uploadedDescription = freezed,Object? thumbnailPath = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PublishStatus,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,uploadedVideoUrl: freezed == uploadedVideoUrl ? _self.uploadedVideoUrl : uploadedVideoUrl // ignore: cast_nullable_to_non_nullable
as String?,uploadedDescription: freezed == uploadedDescription ? _self.uploadedDescription : uploadedDescription // ignore: cast_nullable_to_non_nullable
as String?,thumbnailPath: freezed == thumbnailPath ? _self.thumbnailPath : thumbnailPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PublishState].
extension PublishStatePatterns on PublishState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PublishState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PublishState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PublishState value)  $default,){
final _that = this;
switch (_that) {
case _PublishState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PublishState value)?  $default,){
final _that = this;
switch (_that) {
case _PublishState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PublishStatus status,  double progress,  String? errorMessage,  String? uploadedVideoUrl,  String? uploadedDescription,  String? thumbnailPath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PublishState() when $default != null:
return $default(_that.status,_that.progress,_that.errorMessage,_that.uploadedVideoUrl,_that.uploadedDescription,_that.thumbnailPath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PublishStatus status,  double progress,  String? errorMessage,  String? uploadedVideoUrl,  String? uploadedDescription,  String? thumbnailPath)  $default,) {final _that = this;
switch (_that) {
case _PublishState():
return $default(_that.status,_that.progress,_that.errorMessage,_that.uploadedVideoUrl,_that.uploadedDescription,_that.thumbnailPath);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PublishStatus status,  double progress,  String? errorMessage,  String? uploadedVideoUrl,  String? uploadedDescription,  String? thumbnailPath)?  $default,) {final _that = this;
switch (_that) {
case _PublishState() when $default != null:
return $default(_that.status,_that.progress,_that.errorMessage,_that.uploadedVideoUrl,_that.uploadedDescription,_that.thumbnailPath);case _:
  return null;

}
}

}

/// @nodoc


class _PublishState implements PublishState {
  const _PublishState({this.status = PublishStatus.idle, this.progress = 0.0, this.errorMessage, this.uploadedVideoUrl, this.uploadedDescription, this.thumbnailPath});
  

@override@JsonKey() final  PublishStatus status;
@override@JsonKey() final  double progress;
@override final  String? errorMessage;
@override final  String? uploadedVideoUrl;
@override final  String? uploadedDescription;
@override final  String? thumbnailPath;

/// Create a copy of PublishState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PublishStateCopyWith<_PublishState> get copyWith => __$PublishStateCopyWithImpl<_PublishState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PublishState&&(identical(other.status, status) || other.status == status)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.uploadedVideoUrl, uploadedVideoUrl) || other.uploadedVideoUrl == uploadedVideoUrl)&&(identical(other.uploadedDescription, uploadedDescription) || other.uploadedDescription == uploadedDescription)&&(identical(other.thumbnailPath, thumbnailPath) || other.thumbnailPath == thumbnailPath));
}


@override
int get hashCode => Object.hash(runtimeType,status,progress,errorMessage,uploadedVideoUrl,uploadedDescription,thumbnailPath);

@override
String toString() {
  return 'PublishState(status: $status, progress: $progress, errorMessage: $errorMessage, uploadedVideoUrl: $uploadedVideoUrl, uploadedDescription: $uploadedDescription, thumbnailPath: $thumbnailPath)';
}


}

/// @nodoc
abstract mixin class _$PublishStateCopyWith<$Res> implements $PublishStateCopyWith<$Res> {
  factory _$PublishStateCopyWith(_PublishState value, $Res Function(_PublishState) _then) = __$PublishStateCopyWithImpl;
@override @useResult
$Res call({
 PublishStatus status, double progress, String? errorMessage, String? uploadedVideoUrl, String? uploadedDescription, String? thumbnailPath
});




}
/// @nodoc
class __$PublishStateCopyWithImpl<$Res>
    implements _$PublishStateCopyWith<$Res> {
  __$PublishStateCopyWithImpl(this._self, this._then);

  final _PublishState _self;
  final $Res Function(_PublishState) _then;

/// Create a copy of PublishState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? progress = null,Object? errorMessage = freezed,Object? uploadedVideoUrl = freezed,Object? uploadedDescription = freezed,Object? thumbnailPath = freezed,}) {
  return _then(_PublishState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PublishStatus,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,uploadedVideoUrl: freezed == uploadedVideoUrl ? _self.uploadedVideoUrl : uploadedVideoUrl // ignore: cast_nullable_to_non_nullable
as String?,uploadedDescription: freezed == uploadedDescription ? _self.uploadedDescription : uploadedDescription // ignore: cast_nullable_to_non_nullable
as String?,thumbnailPath: freezed == thumbnailPath ? _self.thumbnailPath : thumbnailPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
