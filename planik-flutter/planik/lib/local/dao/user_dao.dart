import 'package:floor/floor.dart';
import 'package:planik/local/entity/user_entity.dart';

@dao
abstract class UserDao {
  @Query('SELECT * FROM users')
  Future<List<UserEntity>> findAll();

  @Query('SELECT * FROM users WHERE id = :id')
  Future<UserEntity?> findOneById(int id);

  @Query('SELECT * FROM users WHERE uid = :uid')
  Future<UserEntity?> findOneByUid(String uid);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertOne(UserEntity entity);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<int> updateOne(UserEntity entity);

  @transaction
  Future<void> insertOrUpdateOne(UserEntity entity) async {
    final id = await insertOne(entity);
    if (id == -1) {
      await updateOne(entity);
    }
  }

  @Query('DELETE FROM users WHERE id = :id')
  Future<void> deleteOneById(int id);

  @delete
  Future<void> deleteMany(List<UserEntity> entities);
}
