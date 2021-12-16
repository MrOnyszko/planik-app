// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'navigation_hub_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$NavigationHubEventTearOff {
  const _$NavigationHubEventTearOff();

  _NavigationHubStarted started() {
    return const _NavigationHubStarted();
  }
}

/// @nodoc
const $NavigationHubEvent = _$NavigationHubEventTearOff();

/// @nodoc
mixin _$NavigationHubEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? started,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NavigationHubStarted value) started,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_NavigationHubStarted value)? started,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NavigationHubStarted value)? started,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NavigationHubEventCopyWith<$Res> {
  factory $NavigationHubEventCopyWith(
          NavigationHubEvent value, $Res Function(NavigationHubEvent) then) =
      _$NavigationHubEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$NavigationHubEventCopyWithImpl<$Res>
    implements $NavigationHubEventCopyWith<$Res> {
  _$NavigationHubEventCopyWithImpl(this._value, this._then);

  final NavigationHubEvent _value;
  // ignore: unused_field
  final $Res Function(NavigationHubEvent) _then;
}

/// @nodoc
abstract class _$NavigationHubStartedCopyWith<$Res> {
  factory _$NavigationHubStartedCopyWith(_NavigationHubStarted value,
          $Res Function(_NavigationHubStarted) then) =
      __$NavigationHubStartedCopyWithImpl<$Res>;
}

/// @nodoc
class __$NavigationHubStartedCopyWithImpl<$Res>
    extends _$NavigationHubEventCopyWithImpl<$Res>
    implements _$NavigationHubStartedCopyWith<$Res> {
  __$NavigationHubStartedCopyWithImpl(
      _NavigationHubStarted _value, $Res Function(_NavigationHubStarted) _then)
      : super(_value, (v) => _then(v as _NavigationHubStarted));

  @override
  _NavigationHubStarted get _value => super._value as _NavigationHubStarted;
}

/// @nodoc

class _$_NavigationHubStarted implements _NavigationHubStarted {
  const _$_NavigationHubStarted();

  @override
  String toString() {
    return 'NavigationHubEvent.started()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _NavigationHubStarted);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? started,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NavigationHubStarted value) started,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_NavigationHubStarted value)? started,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NavigationHubStarted value)? started,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _NavigationHubStarted implements NavigationHubEvent {
  const factory _NavigationHubStarted() = _$_NavigationHubStarted;
}

/// @nodoc
class _$NavigationHubStateTearOff {
  const _$NavigationHubStateTearOff();

  _NavigationHubState call(
      {required bool hasUser, required bool hasPlan, required bool hasError}) {
    return _NavigationHubState(
      hasUser: hasUser,
      hasPlan: hasPlan,
      hasError: hasError,
    );
  }
}

/// @nodoc
const $NavigationHubState = _$NavigationHubStateTearOff();

/// @nodoc
mixin _$NavigationHubState {
  bool get hasUser => throw _privateConstructorUsedError;
  bool get hasPlan => throw _privateConstructorUsedError;
  bool get hasError => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NavigationHubStateCopyWith<NavigationHubState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NavigationHubStateCopyWith<$Res> {
  factory $NavigationHubStateCopyWith(
          NavigationHubState value, $Res Function(NavigationHubState) then) =
      _$NavigationHubStateCopyWithImpl<$Res>;
  $Res call({bool hasUser, bool hasPlan, bool hasError});
}

/// @nodoc
class _$NavigationHubStateCopyWithImpl<$Res>
    implements $NavigationHubStateCopyWith<$Res> {
  _$NavigationHubStateCopyWithImpl(this._value, this._then);

  final NavigationHubState _value;
  // ignore: unused_field
  final $Res Function(NavigationHubState) _then;

  @override
  $Res call({
    Object? hasUser = freezed,
    Object? hasPlan = freezed,
    Object? hasError = freezed,
  }) {
    return _then(_value.copyWith(
      hasUser: hasUser == freezed
          ? _value.hasUser
          : hasUser // ignore: cast_nullable_to_non_nullable
              as bool,
      hasPlan: hasPlan == freezed
          ? _value.hasPlan
          : hasPlan // ignore: cast_nullable_to_non_nullable
              as bool,
      hasError: hasError == freezed
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$NavigationHubStateCopyWith<$Res>
    implements $NavigationHubStateCopyWith<$Res> {
  factory _$NavigationHubStateCopyWith(
          _NavigationHubState value, $Res Function(_NavigationHubState) then) =
      __$NavigationHubStateCopyWithImpl<$Res>;
  @override
  $Res call({bool hasUser, bool hasPlan, bool hasError});
}

/// @nodoc
class __$NavigationHubStateCopyWithImpl<$Res>
    extends _$NavigationHubStateCopyWithImpl<$Res>
    implements _$NavigationHubStateCopyWith<$Res> {
  __$NavigationHubStateCopyWithImpl(
      _NavigationHubState _value, $Res Function(_NavigationHubState) _then)
      : super(_value, (v) => _then(v as _NavigationHubState));

  @override
  _NavigationHubState get _value => super._value as _NavigationHubState;

  @override
  $Res call({
    Object? hasUser = freezed,
    Object? hasPlan = freezed,
    Object? hasError = freezed,
  }) {
    return _then(_NavigationHubState(
      hasUser: hasUser == freezed
          ? _value.hasUser
          : hasUser // ignore: cast_nullable_to_non_nullable
              as bool,
      hasPlan: hasPlan == freezed
          ? _value.hasPlan
          : hasPlan // ignore: cast_nullable_to_non_nullable
              as bool,
      hasError: hasError == freezed
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_NavigationHubState implements _NavigationHubState {
  const _$_NavigationHubState(
      {required this.hasUser, required this.hasPlan, required this.hasError});

  @override
  final bool hasUser;
  @override
  final bool hasPlan;
  @override
  final bool hasError;

  @override
  String toString() {
    return 'NavigationHubState(hasUser: $hasUser, hasPlan: $hasPlan, hasError: $hasError)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NavigationHubState &&
            (identical(other.hasUser, hasUser) || other.hasUser == hasUser) &&
            (identical(other.hasPlan, hasPlan) || other.hasPlan == hasPlan) &&
            (identical(other.hasError, hasError) ||
                other.hasError == hasError));
  }

  @override
  int get hashCode => Object.hash(runtimeType, hasUser, hasPlan, hasError);

  @JsonKey(ignore: true)
  @override
  _$NavigationHubStateCopyWith<_NavigationHubState> get copyWith =>
      __$NavigationHubStateCopyWithImpl<_NavigationHubState>(this, _$identity);
}

abstract class _NavigationHubState implements NavigationHubState {
  const factory _NavigationHubState(
      {required bool hasUser,
      required bool hasPlan,
      required bool hasError}) = _$_NavigationHubState;

  @override
  bool get hasUser;
  @override
  bool get hasPlan;
  @override
  bool get hasError;
  @override
  @JsonKey(ignore: true)
  _$NavigationHubStateCopyWith<_NavigationHubState> get copyWith =>
      throw _privateConstructorUsedError;
}
