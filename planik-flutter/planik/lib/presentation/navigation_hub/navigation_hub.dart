import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planik/presentation/navigation_hub/bloc/navigation_hub_bloc.dart';
import 'package:planik/presentation/screens/user_name/user_name_screen.dart';

class NavigationHub extends StatelessWidget {
  const NavigationHub({
    required this.navigatorKey,
    required this.child,
    Key? key,
  }) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationHubBloc, NavigationHubState>(
      listener: (context, state) {
        if (state.openPlanScreen) {
        } else if (state.openCreatePlanIncentiveScreen) {
        } else if (state.openUserNameScreen) {
          navigatorKey.currentState?.pushNamedAndRemoveUntil(
            UserNameScreen.routeName,
            (route) => false,
          );
        }
      },
      child: child,
    );
  }
}
