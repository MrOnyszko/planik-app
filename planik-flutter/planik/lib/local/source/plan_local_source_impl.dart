import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:planik/domain/failure/general_failure.dart';
import 'package:planik/domain/model/day.dart';
import 'package:planik/domain/model/day_entry.dart';
import 'package:planik/domain/model/full_plan.dart';
import 'package:planik/domain/model/plan.dart';
import 'package:planik/domain/source/plan_local_source.dart';
import 'package:planik/foundation/foundation.dart';
import 'package:planik/local/dao/plan_dao.dart';
import 'package:planik/local/dao/plan_day_entry_dao.dart';
import 'package:planik/local/entity/plan_day_entry_entity.dart';
import 'package:planik/local/entity/plan_entity.dart';
import 'package:planik/local/mapper/plan_day_entry_entity_to_model_mapper.dart';
import 'package:planik/local/mapper/plan_entity_to_model_mapper.dart';

class PlanLocalSourceImpl implements PlanLocalSource {
  const PlanLocalSourceImpl({
    required Dates dates,
    required PlanDao planDao,
    required PlanDayEntryDao planDayEntryDao,
    required PlanEntityToModelMapper planEntityToModelMapper,
    required PlayDayEntryEntityToModelMapper playDayEntryEntityToModelMapper,
  })  : _dates = dates,
        _planDao = planDao,
        _planDayEntryDao = planDayEntryDao,
        _planEntityToModelMapper = planEntityToModelMapper,
        _playDayEntryEntityToModelMapper = playDayEntryEntityToModelMapper;

  final Dates _dates;
  final PlanDao _planDao;
  final PlanDayEntryDao _planDayEntryDao;
  final PlanEntityToModelMapper _planEntityToModelMapper;
  final PlayDayEntryEntityToModelMapper _playDayEntryEntityToModelMapper;

  @override
  TaskEither<GeneralFailure, List<Plan>> getPlans({required int pageSize, required int page}) {
    return tryCatchE<GeneralFailure, List<Plan>>(
      () async {
        final entities = await _planDao.findManyBy(page, pageSize);
        final plans = entities.map(_planEntityToModelMapper.map).toList();
        return right(plans);
      },
      (error, stackTrace) => GeneralFailure.fatal,
    );
  }

  @override
  TaskEither<GeneralFailure, FullPlan> getPlan({required int id}) {
    return tryCatchE<GeneralFailure, FullPlan>(
      () async {
        final now = _dates.now();

        final planEntity = await _planDao.findOneById(id);
        if (planEntity == null) {
          return left(GeneralFailure.notFound);
        }

        final planDayEntryEntities = await _planDayEntryDao.findManyByPlanId(id);

        final group = groupBy(
          planDayEntryEntities,
          // ignore: avoid_types_on_closure_parameters
          (PlanDayEntryEntity it) => it.dayOfWeek,
        ).entries;

        final dayNameFormat = DateFormat.EEEE(Platform.localeName);

        final days = group.map(
          (it) {
            final startOfWeek = now.subtract(Duration(days: now.weekday));
            final day = startOfWeek.add(Duration(days: it.key));
            final dayName = dayNameFormat.format(day);
            final uppercaseDayName = '${dayName[0].toUpperCase()}${dayName.substring(1)}';
            final entities = it.value;
            final entries = <DayEntry>[];
            for (var i = 0; i < entities.length; i++) {
              final entry = _playDayEntryEntityToModelMapper.map(entities[i]);
              final next = i < entities.length - 1 ? entities[i + 1] : null;
              final pause =
                  next != null ? DateTime.parse(next.start).difference(entry.end).inMinutes : 0;
              entries.add(entry.copyWith(pauseMinutes: pause));
            }
            return Day(
              ordinal: it.key,
              date: day,
              name: uppercaseDayName,
              entries: entries,
            );
          },
        ).toList(growable: false);

        final plan = _planEntityToModelMapper.map(planEntity);

        return right(FullPlan(plan: plan, days: days));
      },
      (error, stackTrace) => GeneralFailure.fatal,
    );
  }

  @override
  TaskEither<GeneralFailure, int> createPlan({
    required int userId,
    required String name,
    required bool current,
  }) {
    return tryCatchE<GeneralFailure, int>(
      () async {
        final now = _dates.now();

        final plan = PlanEntity(
          userId: userId,
          name: name,
          current: current,
          createdAt: now.toIso8601String(),
          updatedAt: null,
        );

        final planId = await _planDao.insertOne(plan);

        final entities = List.generate(
          DateTime.daysPerWeek,
          (index) => PlanDayEntryEntity(
            id: null,
            planId: planId,
            dayOfWeek: index + 1,
            name: name,
            start: now.copyWith(hour: 8, minute: 0).toIso8601String(),
            end: now.copyWith(hour: 8, minute: 45).toIso8601String(),
            createdAt: now.toIso8601String(),
            updatedAt: null,
          ),
        );

        await _planDayEntryDao.insertMany(entities);

        return right(planId);
      },
      (error, stackTrace) => GeneralFailure.fatal,
    );
  }

  @override
  TaskEither<GeneralFailure, int> updatePlan({
    required int id,
    String? name,
    bool? current,
  }) {
    return tryCatchE<GeneralFailure, int>(
      () async {
        final now = _dates.now();

        final plan = await _planDao.findOneById(id);

        if (plan == null) {
          return left(GeneralFailure.notFound);
        }

        await _planDao.updateOne(
          plan.copyWith(
            name: name,
            current: current,
            updatedAt: now.toIso8601String(),
          ),
        );

        return right(id);
      },
      (error, stackTrace) => GeneralFailure.fatal,
    );
  }
}
