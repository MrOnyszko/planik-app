import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planik/presentation/common/state_type.dart';
import 'package:planik/presentation/screens/create_plan/bloc/create_plan_bloc.dart';
import 'package:planik/presentation/screens/create_plan/create_plan_name_form_widget.dart';
import 'package:planik/presentation/screens/plan/content/plan_horizontal.dart';
import 'package:planik/presentation/widgets/empty_page_widget.dart';
import 'package:planik/presentation/widgets/error_page_widget.dart';
import 'package:planik/presentation/widgets/loading_page_widget.dart';

class CreatePlanScreen extends StatelessWidget {
  static const String routeName = '/create-plan';
  static const double _toolbarHeight = kToolbarHeight + 52;

  const CreatePlanScreen({
    Key? key,
  }) : super(
          // coverage:ignore-line
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return true;
      },
      child: Scaffold(
        body: BlocBuilder<CreatePlanBloc, CreatePlanState>(
          builder: (context, state) {
            return state.type.map(
              loading: () => const LoadingPage(),
              loaded: () {
                return PlanHorizontal(
                  toolbarHeight: _toolbarHeight,
                  title: CreatePlanNameForm(
                    initialValue: state.plan?.name ?? '',
                    onChanged: (value) {
                      context
                          .read<CreatePlanBloc>()
                          .add(CreatePlanEvent.planNameChanged(name: value));
                    },
                  ),
                  automaticallyImplyLeading: false,
                  days: state.days,
                  appBarActions: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      icon: const Icon(Icons.done_all),
                    ),
                  ],
                );
              },
              empty: () => const EmptyPage(),
              error: () => const ErrorPage(),
            );
          },
        ),
      ),
    );
  }
}
