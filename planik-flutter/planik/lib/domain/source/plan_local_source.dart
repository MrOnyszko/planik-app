import 'package:fpdart/fpdart.dart';
import 'package:planik/domain/failure/general_failure.dart';
import 'package:planik/domain/model/full_plan.dart';
import 'package:planik/domain/model/plan.dart';

abstract class PlanLocalSource {
  TaskEither<GeneralFailure, FullPlan> getPlan({required int id});

  TaskEither<GeneralFailure, List<Plan>> getPlans({required int pageSize, required int page});

  TaskEither<GeneralFailure, int> createPlan({
    required int userId,
    required String name,
    required bool current,
  });
}
