import 'package:fpdart/fpdart.dart';
import 'package:planik/domain/failure/general_failure.dart';
import 'package:planik/domain/model/full_plan.dart';
import 'package:planik/domain/source/plan_local_source.dart';
import 'package:planik/domain/source/user_local_source.dart';
import 'package:planik/local/store/user_store.dart';

class PlanService {
  const PlanService({
    required PlanLocalSource planLocalSource,
    required UserLocalSource userLocalSource,
    required UserStore userStore,
  })  : _planLocalSource = planLocalSource,
        _userLocalSource = userLocalSource,
        _userStore = userStore;

  final PlanLocalSource _planLocalSource;
  final UserLocalSource _userLocalSource;
  final UserStore _userStore;

  TaskEither<GeneralFailure, FullPlan> getPlan({
    required id,
  }) {
    final userId = _userStore.getId();
    if (userId == null) {
      return TaskEither<GeneralFailure, FullPlan>.left(GeneralFailure.notFound);
    }
    return _planLocalSource.getPlan(id: id);
  }

  TaskEither<GeneralFailure, FullPlan> addPlan({
    String name = "",
    bool current = true,
  }) {
    final userId = _userStore.getId();
    if (userId == null) {
      return TaskEither<GeneralFailure, FullPlan>.left(GeneralFailure.notFound);
    }

    return _planLocalSource
        .createPlan(userId: userId, name: name, current: current)
        .flatMap((id) => _planLocalSource.getPlan(id: id))
        .flatMap(
          (fullPlan) => _userLocalSource.setHasPlan(hasPlan: true).map((_) => fullPlan),
        );
  }
}
