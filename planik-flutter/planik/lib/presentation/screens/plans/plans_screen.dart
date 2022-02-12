import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planik/domain/model/plan.dart';
import 'package:planik/presentation/common/dimen.dart';
import 'package:planik/presentation/common/extensions.dart';
import 'package:planik/presentation/components/pagination/pagination.dart';
import 'package:planik/presentation/screens/create_plan/create_plan_argument.dart';
import 'package:planik/presentation/screens/create_plan/create_plan_screen.dart';
import 'package:planik/presentation/screens/plan/plan_argument.dart';
import 'package:planik/presentation/screens/plan/plan_screen.dart';
import 'package:planik/presentation/screens/plans/bloc/plans_bloc.dart';
import 'package:planik/presentation/widgets/empty_page_widget.dart';
import 'package:planik/presentation/widgets/error_page_widget.dart';
import 'package:planik/presentation/widgets/loading_page_widget.dart';

class PlansScreen extends StatelessWidget {
  static const String routeName = '/plans';

  const PlansScreen({
    Key? key,
  }) : super(
          // coverage:ignore-line
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.plansScreenTitle),
      ),
      body: SafeArea(
        child: BlocBuilder<PlansBloc, PlansState>(
          builder: (context, state) {
            return Pagination<Plan>.listView(
              loading: const LoadingPage(),
              empty: const EmptyPage(),
              error: const ErrorPage(),
              indexedPageWidgetBuilder: (context, index, plan) {
                return ListTile(
                  title: Text('${plan.id} ${plan.name}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: Insets.small),
                      Text(
                        context.strings.commonCreatedAtLabel(plan.createdAt),
                        style: context.textTheme.bodyText2,
                      ),
                      const SizedBox(height: Insets.small),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      _navigateToCreatePlanScreen(context, plan.id);
                    },
                  ),
                  selected: plan.current,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      PlanScreen.routeName,
                      arguments: PlanArgument(id: plan.id),
                    );
                  },
                );
              },
              indexedWidgetSeparatorBuilder: (context, index) => const Divider(
                height: 1,
                indent: Insets.large,
                endIndent: Insets.large,
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _navigateToCreatePlanScreen(context);
        },
      ),
    );
  }

  Future<void> _navigateToCreatePlanScreen(BuildContext context, [int? id]) async {
    final result = await Navigator.pushNamed(
      context,
      CreatePlanScreen.routeName,
      arguments: CreatePlanArgument(id: id),
    );

    if (result != null) {
      context.read<PaginationBloc<Plan>>().add(const PaginationEvent.refresh());
    }
  }
}
