import 'package:floor/floor.dart';
import 'package:local/db/_SNAKE_CASE_NAME_/_SNAKE_CASE_NAME__entity.dart';

@dao
abstract class _UPPER_CAMEL_CASE_NAME_Dao {
  @Query('SELECT * FROM _SNAKE_CASE_NAME_ ORDER BY created_at DESC')
  Future<List<_UPPER_CAMEL_CASE_NAME_Entity>> findAll();

  @Query(
    '''
    SELECT * FROM _SNAKE_CASE_NAME_ WHERE id NOT IN 
      ( 
        SELECT id FROM _SNAKE_CASE_NAME_ 
        ORDER BY created_at DESC
        LIMIT :offset
      )
    ORDER BY created_at DESC 
    LIMIT :limit
    ''',
  )
  Future<List<_UPPER_CAMEL_CASE_NAME_Entity>> findManyBy(int offset, int limit);

  @Query('SELECT * FROM _SNAKE_CASE_NAME_ WHERE id = :id')
  Future<_UPPER_CAMEL_CASE_NAME_Entity?> findOne(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertOne(_UPPER_CAMEL_CASE_NAME_Entity entity);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertMany(List<_UPPER_CAMEL_CASE_NAME_Entity> entities);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<int> updateOne(_UPPER_CAMEL_CASE_NAME_Entity entity);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<int> updateMany(List<_UPPER_CAMEL_CASE_NAME_Entity> entities);

  @transaction
  Future<void> insertOrUpdateOne(_UPPER_CAMEL_CASE_NAME_Entity entity) async {
    final id = await insertOne(entity);
    if (id == -1) {
      await updateOne(entity);
    }
  }

  @transaction
  Future<void> insertOrUpdateMany(List<_UPPER_CAMEL_CASE_NAME_Entity> entities) async {
    final results = await insertMany(entities);

    final toUpdate = <_UPPER_CAMEL_CASE_NAME_Entity>[];
    for (var i = 0; i < results.length; i++) {
      if (results[i] == -1) {
        toUpdate.add(entities[i]);
      }
    }

    await updateMany(toUpdate);
  }

  @Query('DELETE FROM _SNAKE_CASE_NAME_ WHERE id = :id')
  Future<void> deleteOneById(int id);

  @delete
  Future<void> deleteMany(List<_UPPER_CAMEL_CASE_NAME_Entity> entities);
}
