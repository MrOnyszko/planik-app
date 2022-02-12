import 'package:fpdart/fpdart.dart';
import 'package:planik/domain/failure/general_failure.dart';
import 'package:planik/domain/model/full_plan.dart';
import 'package:planik/domain/model/plan.dart';
import 'package:planik/domain/source/plan_local_source.dart';
import 'package:planik/domain/source/user_local_source.dart';

class PlanService {
  const PlanService({
    required PlanLocalSource planLocalSource,
    required UserLocalSource userLocalSource,
  })  : _planLocalSource = planLocalSource,
        _userLocalSource = userLocalSource;

  final PlanLocalSource _planLocalSource;
  final UserLocalSource _userLocalSource;

  TaskEither<GeneralFailure, FullPlan> getCurrentPlan() {
    return _userLocalSource.currentPlanId().flatMap((it) => _planLocalSource.getPlan(id: it));
  }

  TaskEither<GeneralFailure, FullPlan> getPlan({required id}) {
    return _planLocalSource.getPlan(id: id);
  }

  TaskEither<GeneralFailure, FullPlan> addPlan({
    String name = "",
    bool current = true,
  }) {
    return _userLocalSource.currentUserId().flatMap(
          (currentUserId) => _planLocalSource
              .createPlan(userId: currentUserId, name: name, current: current)
              .flatMap((id) => _planLocalSource.getPlan(id: id))
              .flatMap(
                (fullPlan) => _userLocalSource.setHasPlan(hasPlan: true).map((_) => fullPlan),
              )
              .flatMap(
                (fullPlan) =>
                    _userLocalSource.setCurrentPlanId(id: fullPlan.plan.id).map((_) => fullPlan),
              ),
        );
  }

  TaskEither<GeneralFailure, FullPlan> updatePlan({
    required int id,
    String? name,
    bool? current,
  }) {
    return _planLocalSource
        .updatePlan(id: id, name: name, current: current)
        .flatMap((id) => _planLocalSource.getPlan(id: id))
        .flatMap(
      (fullPlan) {
        if (current == true) {
          return _userLocalSource.setCurrentPlanId(id: fullPlan.plan.id).map((_) => fullPlan);
        } else {
          return TaskEither.right(fullPlan);
        }
      },
    );
  }

  Future<List<Plan>> getPlans({required int pageSize, required int page}) {
    return _planLocalSource
        .getPlans(pageSize: pageSize, page: page)
        .match((l) => <Plan>[], (r) => r)
        .run();
  }
}
