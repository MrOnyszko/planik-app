import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String uid,
    required String nickname,
    required DateTime createdAt,
    required DateTime? updatedAt,
  }) = _User;
}
