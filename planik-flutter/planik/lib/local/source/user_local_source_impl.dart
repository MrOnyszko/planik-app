import 'package:fpdart/fpdart.dart';
import 'package:planik/domain/failure/general_failure.dart';
import 'package:planik/domain/model/user.dart';
import 'package:planik/domain/source/user_local_source.dart';
import 'package:planik/foundation/foundation.dart';
import 'package:planik/local/dao/user_dao.dart';
import 'package:planik/local/entity/user_entity.dart';
import 'package:planik/local/mapper/user_entity_to_model_mapper.dart';
import 'package:planik/local/store/user_store.dart';

class UserLocalSourceImpl implements UserLocalSource {
  UserLocalSourceImpl({
    required Dates dates,
    required UserDao userDao,
    required UserStore userStore,
    required UserEntityToModelMapper userMapper,
  })  : _dates = dates,
        _userDao = userDao,
        _userStore = userStore,
        _userMapper = userMapper;

  final Dates _dates;
  final UserStore _userStore;
  final UserDao _userDao;
  final UserEntityToModelMapper _userMapper;

  @override
  TaskEither<GeneralFailure, int> currentUserId() {
    return tryCatchE<GeneralFailure, int>(
      () async {
        final id = await _userStore.getId();
        if (id != null) {
          return right(id);
        } else {
          return left(GeneralFailure.notFound);
        }
      },
      (error, stackTrace) => GeneralFailure.fatal,
    );
  }

  @override
  TaskEither<GeneralFailure, bool> hasPlan() {
    return TaskEither<GeneralFailure, bool>.tryCatch(
      _userStore.getHasPlan,
      (error, stackTrace) => GeneralFailure.fatal,
    );
  }

  @override
  TaskEither<GeneralFailure, bool> hasUser() {
    return TaskEither<GeneralFailure, bool>.tryCatch(
      _userStore.getHasPlan,
      (error, stackTrace) => GeneralFailure.fatal,
    );
  }

  @override
  TaskEither<GeneralFailure, Unit> setHasPlan({required bool hasPlan}) {
    return tryCatchE<GeneralFailure, Unit>(
      () async {
        await _userStore.putHasPlan(hasPlan: hasPlan);
        return right(unit);
      },
      (error, stackTrace) => GeneralFailure.fatal,
    );
  }

  @override
  TaskEither<GeneralFailure, User> create({required String nickname, required String uid}) {
    return tryCatchE<GeneralFailure, User>(
      () async {
        final id = await _userDao.insertOne(
          UserEntity(
            id: null,
            uid: uid,
            nickname: nickname,
            createdAt: _dates.now().toIso8601String(),
            updatedAt: null,
          ),
        );
        await _userStore.putId(id: id);
        await _userStore.putUid(uid: uid);
        return getCurrentUser().run();
      },
      (error, stackTrace) => GeneralFailure.fatal,
    );
  }

  @override
  TaskEither<GeneralFailure, User> getCurrentUser() {
    return tryCatchE<GeneralFailure, User>(
      () async {
        final uid = await _userStore.getUid();
        if (uid == null) {
          return left(GeneralFailure.notFound);
        }

        final currentUser = await _userDao.findOneByUid(uid);
        if (currentUser != null) {
          return right(_userMapper.map(currentUser));
        } else {
          return left(GeneralFailure.notFound);
        }
      },
      (error, stackTrace) => GeneralFailure.fatal,
    );
  }
}
