import 'package:fpdart/fpdart.dart';
import 'package:planik/domain/failure/general_failure.dart';
import 'package:planik/domain/model/user.dart';

abstract class UserLocalSource {
  TaskEither<GeneralFailure, int> currentUserId();

  TaskEither<GeneralFailure, bool> hasUser();

  TaskEither<GeneralFailure, bool> hasPlan();

  TaskEither<GeneralFailure, Unit> setHasPlan({required bool hasPlan});

  TaskEither<GeneralFailure, User> create({required String nickname, required String uid});

  TaskEither<GeneralFailure, User> getCurrentUser();
}
