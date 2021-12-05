// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'day_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$DayEntryTearOff {
  const _$DayEntryTearOff();

  _DayEntry call(
      {required int id,
      required int dayOfWeek,
      required String title,
      required DateTime start,
      required DateTime end,
      required int pauseMinutes}) {
    return _DayEntry(
      id: id,
      dayOfWeek: dayOfWeek,
      title: title,
      start: start,
      end: end,
      pauseMinutes: pauseMinutes,
    );
  }
}

/// @nodoc
const $DayEntry = _$DayEntryTearOff();

/// @nodoc
mixin _$DayEntry {
  int get id => throw _privateConstructorUsedError;

  int get dayOfWeek => throw _privateConstructorUsedError;

  String get title => throw _privateConstructorUsedError;

  DateTime get start => throw _privateConstructorUsedError;

  DateTime get end => throw _privateConstructorUsedError;

  int get pauseMinutes => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DayEntryCopyWith<DayEntry> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DayEntryCopyWith<$Res> {
  factory $DayEntryCopyWith(DayEntry value, $Res Function(DayEntry) then) =
      _$DayEntryCopyWithImpl<$Res>;

  $Res call({int id, int dayOfWeek, String title, DateTime start, DateTime end, int pauseMinutes});
}

/// @nodoc
class _$DayEntryCopyWithImpl<$Res> implements $DayEntryCopyWith<$Res> {
  _$DayEntryCopyWithImpl(this._value, this._then);

  final DayEntry _value;

  // ignore: unused_field
  final $Res Function(DayEntry) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? dayOfWeek = freezed,
    Object? title = freezed,
    Object? start = freezed,
    Object? end = freezed,
    Object? pauseMinutes = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      dayOfWeek: dayOfWeek == freezed
          ? _value.dayOfWeek
          : dayOfWeek // ignore: cast_nullable_to_non_nullable
              as int,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      start: start == freezed
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime,
      end: end == freezed
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime,
      pauseMinutes: pauseMinutes == freezed
          ? _value.pauseMinutes
          : pauseMinutes // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$DayEntryCopyWith<$Res> implements $DayEntryCopyWith<$Res> {
  factory _$DayEntryCopyWith(_DayEntry value, $Res Function(_DayEntry) then) =
      __$DayEntryCopyWithImpl<$Res>;

  @override
  $Res call({int id, int dayOfWeek, String title, DateTime start, DateTime end, int pauseMinutes});
}

/// @nodoc
class __$DayEntryCopyWithImpl<$Res> extends _$DayEntryCopyWithImpl<$Res>
    implements _$DayEntryCopyWith<$Res> {
  __$DayEntryCopyWithImpl(_DayEntry _value, $Res Function(_DayEntry) _then)
      : super(_value, (v) => _then(v as _DayEntry));

  @override
  _DayEntry get _value => super._value as _DayEntry;

  @override
  $Res call({
    Object? id = freezed,
    Object? dayOfWeek = freezed,
    Object? title = freezed,
    Object? start = freezed,
    Object? end = freezed,
    Object? pauseMinutes = freezed,
  }) {
    return _then(_DayEntry(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      dayOfWeek: dayOfWeek == freezed
          ? _value.dayOfWeek
          : dayOfWeek // ignore: cast_nullable_to_non_nullable
              as int,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      start: start == freezed
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime,
      end: end == freezed
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime,
      pauseMinutes: pauseMinutes == freezed
          ? _value.pauseMinutes
          : pauseMinutes // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_DayEntry implements _DayEntry {
  const _$_DayEntry(
      {required this.id,
      required this.dayOfWeek,
      required this.title,
      required this.start,
      required this.end,
      required this.pauseMinutes});

  @override
  final int id;
  @override
  final int dayOfWeek;
  @override
  final String title;
  @override
  final DateTime start;
  @override
  final DateTime end;
  @override
  final int pauseMinutes;

  @override
  String toString() {
    return 'DayEntry(id: $id, dayOfWeek: $dayOfWeek, title: $title, start: $start, end: $end, pauseMinutes: $pauseMinutes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DayEntry &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.pauseMinutes, pauseMinutes) || other.pauseMinutes == pauseMinutes));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, dayOfWeek, title, start, end, pauseMinutes);

  @JsonKey(ignore: true)
  @override
  _$DayEntryCopyWith<_DayEntry> get copyWith =>
      __$DayEntryCopyWithImpl<_DayEntry>(this, _$identity);
}

abstract class _DayEntry implements DayEntry {
  const factory _DayEntry(
      {required int id,
      required int dayOfWeek,
      required String title,
      required DateTime start,
      required DateTime end,
      required int pauseMinutes}) = _$_DayEntry;

  @override
  int get id;

  @override
  int get dayOfWeek;

  @override
  String get title;

  @override
  DateTime get start;

  @override
  DateTime get end;

  @override
  int get pauseMinutes;

  @override
  @JsonKey(ignore: true)
  _$DayEntryCopyWith<_DayEntry> get copyWith => throw _privateConstructorUsedError;
}
