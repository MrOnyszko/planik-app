// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'day.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$DayTearOff {
  const _$DayTearOff();

  _Day call(
      {required int ordinal,
      required String name,
      required DateTime date,
      required List<DayEntry> entries}) {
    return _Day(
      ordinal: ordinal,
      name: name,
      date: date,
      entries: entries,
    );
  }
}

/// @nodoc
const $Day = _$DayTearOff();

/// @nodoc
mixin _$Day {
  int get ordinal => throw _privateConstructorUsedError;

  String get name => throw _privateConstructorUsedError;

  DateTime get date => throw _privateConstructorUsedError;

  List<DayEntry> get entries => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DayCopyWith<Day> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DayCopyWith<$Res> {
  factory $DayCopyWith(Day value, $Res Function(Day) then) = _$DayCopyWithImpl<$Res>;

  $Res call({int ordinal, String name, DateTime date, List<DayEntry> entries});
}

/// @nodoc
class _$DayCopyWithImpl<$Res> implements $DayCopyWith<$Res> {
  _$DayCopyWithImpl(this._value, this._then);

  final Day _value;

  // ignore: unused_field
  final $Res Function(Day) _then;

  @override
  $Res call({
    Object? ordinal = freezed,
    Object? name = freezed,
    Object? date = freezed,
    Object? entries = freezed,
  }) {
    return _then(_value.copyWith(
      ordinal: ordinal == freezed
          ? _value.ordinal
          : ordinal // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      entries: entries == freezed
          ? _value.entries
          : entries // ignore: cast_nullable_to_non_nullable
              as List<DayEntry>,
    ));
  }
}

/// @nodoc
abstract class _$DayCopyWith<$Res> implements $DayCopyWith<$Res> {
  factory _$DayCopyWith(_Day value, $Res Function(_Day) then) = __$DayCopyWithImpl<$Res>;

  @override
  $Res call({int ordinal, String name, DateTime date, List<DayEntry> entries});
}

/// @nodoc
class __$DayCopyWithImpl<$Res> extends _$DayCopyWithImpl<$Res> implements _$DayCopyWith<$Res> {
  __$DayCopyWithImpl(_Day _value, $Res Function(_Day) _then)
      : super(_value, (v) => _then(v as _Day));

  @override
  _Day get _value => super._value as _Day;

  @override
  $Res call({
    Object? ordinal = freezed,
    Object? name = freezed,
    Object? date = freezed,
    Object? entries = freezed,
  }) {
    return _then(_Day(
      ordinal: ordinal == freezed
          ? _value.ordinal
          : ordinal // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      entries: entries == freezed
          ? _value.entries
          : entries // ignore: cast_nullable_to_non_nullable
              as List<DayEntry>,
    ));
  }
}

/// @nodoc

class _$_Day implements _Day {
  const _$_Day(
      {required this.ordinal, required this.name, required this.date, required this.entries});

  @override
  final int ordinal;
  @override
  final String name;
  @override
  final DateTime date;
  @override
  final List<DayEntry> entries;

  @override
  String toString() {
    return 'Day(ordinal: $ordinal, name: $name, date: $date, entries: $entries)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Day &&
            (identical(other.ordinal, ordinal) || other.ordinal == ordinal) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality().equals(other.entries, entries));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, ordinal, name, date, const DeepCollectionEquality().hash(entries));

  @JsonKey(ignore: true)
  @override
  _$DayCopyWith<_Day> get copyWith => __$DayCopyWithImpl<_Day>(this, _$identity);
}

abstract class _Day implements Day {
  const factory _Day(
      {required int ordinal,
      required String name,
      required DateTime date,
      required List<DayEntry> entries}) = _$_Day;

  @override
  int get ordinal;

  @override
  String get name;

  @override
  DateTime get date;

  @override
  List<DayEntry> get entries;

  @override
  @JsonKey(ignore: true)
  _$DayCopyWith<_Day> get copyWith => throw _privateConstructorUsedError;
}
