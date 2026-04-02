// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friends_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FriendsState {

 List<User> get users; String get searchQuery;
/// Create a copy of FriendsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendsStateCopyWith<FriendsState> get copyWith => _$FriendsStateCopyWithImpl<FriendsState>(this as FriendsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendsState&&const DeepCollectionEquality().equals(other.users, users)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(users),searchQuery);

@override
String toString() {
  return 'FriendsState(users: $users, searchQuery: $searchQuery)';
}


}

/// @nodoc
abstract mixin class $FriendsStateCopyWith<$Res>  {
  factory $FriendsStateCopyWith(FriendsState value, $Res Function(FriendsState) _then) = _$FriendsStateCopyWithImpl;
@useResult
$Res call({
 List<User> users, String searchQuery
});




}
/// @nodoc
class _$FriendsStateCopyWithImpl<$Res>
    implements $FriendsStateCopyWith<$Res> {
  _$FriendsStateCopyWithImpl(this._self, this._then);

  final FriendsState _self;
  final $Res Function(FriendsState) _then;

/// Create a copy of FriendsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? users = null,Object? searchQuery = null,}) {
  return _then(_self.copyWith(
users: null == users ? _self.users : users // ignore: cast_nullable_to_non_nullable
as List<User>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FriendsState].
extension FriendsStatePatterns on FriendsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FriendsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FriendsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FriendsState value)  $default,){
final _that = this;
switch (_that) {
case _FriendsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FriendsState value)?  $default,){
final _that = this;
switch (_that) {
case _FriendsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<User> users,  String searchQuery)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FriendsState() when $default != null:
return $default(_that.users,_that.searchQuery);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<User> users,  String searchQuery)  $default,) {final _that = this;
switch (_that) {
case _FriendsState():
return $default(_that.users,_that.searchQuery);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<User> users,  String searchQuery)?  $default,) {final _that = this;
switch (_that) {
case _FriendsState() when $default != null:
return $default(_that.users,_that.searchQuery);case _:
  return null;

}
}

}

/// @nodoc


class _FriendsState implements FriendsState {
  const _FriendsState({final  List<User> users = const [], this.searchQuery = ''}): _users = users;
  

 final  List<User> _users;
@override@JsonKey() List<User> get users {
  if (_users is EqualUnmodifiableListView) return _users;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_users);
}

@override@JsonKey() final  String searchQuery;

/// Create a copy of FriendsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FriendsStateCopyWith<_FriendsState> get copyWith => __$FriendsStateCopyWithImpl<_FriendsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FriendsState&&const DeepCollectionEquality().equals(other._users, _users)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_users),searchQuery);

@override
String toString() {
  return 'FriendsState(users: $users, searchQuery: $searchQuery)';
}


}

/// @nodoc
abstract mixin class _$FriendsStateCopyWith<$Res> implements $FriendsStateCopyWith<$Res> {
  factory _$FriendsStateCopyWith(_FriendsState value, $Res Function(_FriendsState) _then) = __$FriendsStateCopyWithImpl;
@override @useResult
$Res call({
 List<User> users, String searchQuery
});




}
/// @nodoc
class __$FriendsStateCopyWithImpl<$Res>
    implements _$FriendsStateCopyWith<$Res> {
  __$FriendsStateCopyWithImpl(this._self, this._then);

  final _FriendsState _self;
  final $Res Function(_FriendsState) _then;

/// Create a copy of FriendsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? users = null,Object? searchQuery = null,}) {
  return _then(_FriendsState(
users: null == users ? _self._users : users // ignore: cast_nullable_to_non_nullable
as List<User>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
