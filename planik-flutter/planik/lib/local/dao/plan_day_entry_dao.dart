import 'package:floor/floor.dart';
import 'package:planik/local/entity/plan_day_entry_entity.dart';

@dao
abstract class PlanDayEntryDao {
  @Query('SELECT * FROM plan_day_entries')
  Future<List<PlanDayEntryEntity>> findAll();

  @Query(
      'SELECT * FROM plan_day_entries DE WHERE DE.plan_id = :planId AND DE.day_of_week = :dayOfWeek')
  Future<List<PlanDayEntryEntity>> findManyBy(int planId, int dayOfWeek);

  @Query('SELECT * FROM plan_day_entries DE WHERE DE.plan_id = :planId')
  Future<List<PlanDayEntryEntity>> findManyByPlanId(int planId);

  @Query('SELECT DE.* FROM plan_day_entries DE JOIN plans P ON DE.plan_id = P.id AND P.current')
  Future<List<PlanDayEntryEntity>> findManyFromCurrentPlan();

  @Query('SELECT * FROM plan_day_entries WHERE id = :id')
  Future<PlanDayEntryEntity?> findOneById(int id);

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<int> insertOne(PlanDayEntryEntity entity);

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<List<int>> insertMany(List<PlanDayEntryEntity> entities);

  @Update(onConflict: OnConflictStrategy.ignore)
  Future<int> updateOne(PlanDayEntryEntity entity);

  @Update(onConflict: OnConflictStrategy.ignore)
  Future<int> updateMany(List<PlanDayEntryEntity> entities);

  @transaction
  Future<void> insertOrUpdateOne(PlanDayEntryEntity entity) async {
    final id = await insertOne(entity);
    if (id == -1) {
      await updateOne(entity);
    }
  }

  @transaction
  Future<void> insertOrUpdateMany(List<PlanDayEntryEntity> entities) async {
    final results = await insertMany(entities);

    final toUpdate = <PlanDayEntryEntity>[];
    for (var i = 0; i < results.length; i++) {
      if (results[i] == -1) {
        toUpdate.add(entities[i]);
      }
    }

    await updateMany(toUpdate);
  }

  @Query('DELETE FROM plan_day_entries WHERE id = :id')
  Future<void> deleteOneById(int id);

  @delete
  Future<void> deleteMany(List<PlanDayEntryEntity> entities);
}
