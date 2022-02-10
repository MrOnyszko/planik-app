import 'package:fpdart/fpdart.dart';
import 'package:planik/domain/failure/general_failure.dart';
import 'package:planik/domain/model/full_plan.dart';
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
}
