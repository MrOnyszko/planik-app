import 'package:planik/domain/model/user.dart';
import 'package:planik/local/entity/user_entity.dart';
import 'package:planik/local/mapper/mapper.dart';

class UserEntityToModelMapper implements Mapper<UserEntity, User> {
  @override
  User map(UserEntity entity) {
    return User(
      id: entity.id!,
      uid: entity.uid,
      nickname: entity.nickname,
      createdAt: DateTime.parse(entity.createdAt),
      updatedAt: entity.updatedAt != null ? DateTime.parse(entity.updatedAt!) : null,
    );
  }
}
