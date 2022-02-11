import 'package:bloc_test/bloc_test.dart';
import 'package:planik/presentation/common/state_type.dart';
import 'package:planik/presentation/screens/plans/bloc/plans_bloc.dart';
import 'package:planik/presentation/screens/plans/plans_argument.dart';

void main() {
  PlansBloc _build() {
    return PlansBloc(argument: const PlansArgument());
  }

  blocTest<PlansBloc, PlansState>(
    'On PlansEvent.started() it emits loaded state',
    build: _build,
    act: (bloc) {
      bloc.add(const PlansEvent.started());
    },
    expect: () => [
      PlansState.initial(argument: const PlansArgument()).copyWith(type: StateType.loaded),
    ],
  );
}
