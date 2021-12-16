import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planik/presentation/common/dimen.dart';
import 'package:planik/presentation/common/extensions.dart';
import 'package:planik/presentation/common/state_type.dart';
import 'package:planik/presentation/screens/create_plan_incentive/create_plan_incentive_screen.dart';
import 'package:planik/presentation/screens/user_name/bloc/user_name_bloc.dart';
import 'package:planik/presentation/widgets/empty_page_widget.dart';
import 'package:planik/presentation/widgets/error_page_widget.dart';
import 'package:planik/presentation/widgets/loading_page_widget.dart';

class UserNameScreen extends StatelessWidget {
  static const String routeName = '/user-name';

  const UserNameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.appTitle),
      ),
      body: SafeArea(
        child: BlocConsumer<UserNameBloc, UserNameState>(
          listener: (context, state) {
            if (state.openCreatePlanIncentiveScreen) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                CreatePlanIncentiveScreen.routeName,
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            return state.type.map(
              loading: () => const LoadingPage(),
              loaded: () => _Content(
                name: state.name,
                isConfirmEnabled: state.isConfirmEnabled,
              ),
              empty: () => const EmptyPage(),
              error: () => const ErrorPage(),
            );
          },
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.name,
    required this.isConfirmEnabled,
    Key? key,
  }) : super(key: key);

  final String name;
  final bool isConfirmEnabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Insets.medium,
        horizontal: Insets.large,
      ),
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: Insets.xxxLarge),
            Text(context.strings.userNameScreenHeader, style: context.textTheme.headline5),
            const SizedBox(height: Insets.xxxLarge),
            TextFormField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: context.strings.userNameScreenInputLabel,
                hintText: context.strings.userNameScreenInputHint,
              ),
              autocorrect: false,
              onChanged: (value) {
                context.read<UserNameBloc>().add(UserNameEvent.userNameChanged(name: value));
              },
            ),
            const SizedBox(height: Insets.large),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isConfirmEnabled
                    ? () {
                        context.read<UserNameBloc>().add(const UserNameEvent.confirmed());
                      }
                    : null,
                child: Text(context.strings.userNameScreenPrimaryAction),
              ),
            )
          ],
        ),
      ),
    );
  }
}
