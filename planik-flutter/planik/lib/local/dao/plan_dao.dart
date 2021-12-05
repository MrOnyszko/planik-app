import 'package:floor/floor.dart';
import 'package:planik/local/entity/plan_entity.dart';

@dao
abstract class PlanDao {
  @Query('SELECT * FROM plans')
  Future<List<PlanEntity>> findAll();

  @Query('SELECT * FROM plans WHERE id > :lastId ORDER BY current DESC LIMIT :limit')
  Future<List<PlanEntity>> findManyBy(int lastId, int limit);

  @Query('SELECT * FROM plans WHERE id = :id')
  Future<PlanEntity?> findOneById(int id);

  @Query('SELECT * FROM plans WHERE current = 1')
  Future<PlanEntity?> findCurrent();

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<int> insertOne(PlanEntity entity);

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<List<int>> insertMany(List<PlanEntity> entities);

  @Update(onConflict: OnConflictStrategy.ignore)
  Future<int> updateOne(PlanEntity entity);

  @Update(onConflict: OnConflictStrategy.ignore)
  Future<int> updateMany(List<PlanEntity> entities);

  @transaction
  Future<void> insertOrUpdateOne(PlanEntity entity) async {
    final id = await insertOne(entity);
    if (id == -1) {
      await updateOne(entity);
    }
  }

  @transaction
  Future<void> insertOrUpdateMany(List<PlanEntity> entities) async {
    final results = await insertMany(entities);

    final toUpdate = <PlanEntity>[];
    for (var i = 0; i < results.length; i++) {
      if (results[i] == -1) {
        toUpdate.add(entities[i]);
      }
    }

    await updateMany(toUpdate);
  }

  @Query('DELETE FROM plans WHERE id = :id')
  Future<void> deleteOneById(int id);

  @delete
  Future<void> deleteMany(List<PlanEntity> entities);
}
