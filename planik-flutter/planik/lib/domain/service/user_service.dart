import 'package:fpdart/fpdart.dart';
import 'package:planik/domain/failure/general_failure.dart';
import 'package:planik/domain/model/user.dart';
import 'package:planik/domain/source/user_local_source.dart';
import 'package:uuid/uuid.dart';

class UserService {
  const UserService({
    required UserLocalSource userLocalSource,
  }) : _userLocalSource = userLocalSource;

  final UserLocalSource _userLocalSource;

  TaskEither<GeneralFailure, bool> hasUser() => _userLocalSource.hasUser();

  TaskEither<GeneralFailure, bool> hasPlan() => _userLocalSource.hasPlan();

  TaskEither<GeneralFailure, User> getCurrentUser() => _userLocalSource.getCurrentUser();

  TaskEither<GeneralFailure, User> createUser({required String nickname}) {
    return _userLocalSource.create(
      nickname: nickname,
      uid: Uuid(
        options: {'seedBytes': nickname.codeUnits},
      ).v4(),
    );
  }
}
