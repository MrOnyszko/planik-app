import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planik/presentation/common/extensions.dart';
import 'package:planik/presentation/common/state_type.dart';
import 'package:planik/presentation/screens/plan/bloc/plan_bloc.dart';
import 'package:planik/presentation/screens/plan/content/plan_horizontal.dart';
import 'package:planik/presentation/screens/plan/content/plan_vertical.dart';
import 'package:planik/presentation/screens/plans/plans_screen.dart';
import 'package:planik/presentation/widgets/empty_page_widget.dart';
import 'package:planik/presentation/widgets/error_page_widget.dart';
import 'package:planik/presentation/widgets/loading_page_widget.dart';

class PlanScreen extends StatefulWidget {
  static const String routeName = '/plan';

  const PlanScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<int> _tabChangeNotifier = ValueNotifier(0);

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PlanBloc, PlanState>(
        listener: (context, state) {
          if (state.indexOfToday != null) {
            if (state.isVertical) {
              _scrollController.animateTo(
                state.indexOfToday! * 100,
                duration: kThemeAnimationDuration,
                curve: Curves.fastOutSlowIn,
              );
            } else {
              _tabChangeNotifier.value = state.indexOfToday!;
            }
          }
        },
        builder: (context, state) {
          return state.type.map(
            loading: () => const LoadingPage(),
            loaded: () {
              final appBarActions = [
                if (state.argument.id == null)
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, PlansScreen.routeName);
                    },
                    icon: const Icon(Icons.list),
                  ),
                IconButton(
                  onPressed: () {
                    context.read<PlanBloc>().add(const PlanEvent.todayRequested());
                  },
                  icon: const Icon(Icons.today),
                ),
                IconButton(
                  onPressed: () {
                    context.read<PlanBloc>().add(const PlanEvent.toggleViewTypeRequested());
                  },
                  icon: Icon(state.isVertical ? Icons.toggle_off : Icons.toggle_on),
                ),
              ];

              if (state.isVertical) {
                return PlanVertical(
                  scrollController: _scrollController,
                  title: context.strings.appTitle,
                  days: state.days,
                  appBarActions: appBarActions,
                  applyTitlePadding: state.argument.id == null,
                );
              } else {
                return PlanHorizontal(
                  title: Text(context.strings.appTitle),
                  days: state.days,
                  appBarActions: appBarActions,
                  tabChangeNotifier: _tabChangeNotifier,
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
