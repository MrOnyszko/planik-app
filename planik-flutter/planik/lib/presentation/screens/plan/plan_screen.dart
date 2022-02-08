import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planik/presentation/common/extensions.dart';
import 'package:planik/presentation/common/state_type.dart';
import 'package:planik/presentation/screens/plan/bloc/plan_bloc.dart';
import 'package:planik/presentation/screens/plan/content/plan_horizontal.dart';
import 'package:planik/presentation/screens/plan/content/plan_vertical.dart';
import 'package:planik/presentation/widgets/empty_page_widget.dart';
import 'package:planik/presentation/widgets/error_page_widget.dart';
import 'package:planik/presentation/widgets/loading_page_widget.dart';

class PlanScreen extends StatelessWidget {
  static const String routeName = '/plan';

  const PlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PlanBloc, PlanState>(
        builder: (context, state) {
          return state.type.map(
            loading: () => const LoadingPage(),
            loaded: () {
              if (state.isVertical) {
                return PlanVertical(
                  title: context.strings.appTitle,
                  days: state.days,
                  appBarActions: const [],
                );
              } else {
                return PlanHorizontal(
                  title: Text(context.strings.appTitle),
                  days: state.days,
                );
              }
            },
            empty: () => const EmptyPage(),
            error: () => const ErrorPage(),
          );
        },
      ),
    );
  }
}
