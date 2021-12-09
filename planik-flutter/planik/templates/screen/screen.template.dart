import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planik/presentation/common/dimen.dart';
import 'package:planik/presentation/common/extensions.dart';
import 'package:planik/presentation/common/state_type.dart';
import 'package:planik/presentation/screens/_SNAKE_CASE_NAME_/bloc/_SNAKE_CASE_NAME__bloc.dart';
import 'package:planik/presentation/widgets/empty_page_widget.dart';
import 'package:planik/presentation/widgets/error_page_widget.dart';
import 'package:planik/presentation/widgets/loading_page_widget.dart';

class _UPPER_CAMEL_CASE_NAME_Screen extends StatelessWidget {
  static const String routeName = '/_DASH_CASE_NAME_';

  // context.strings._CAMEL_CASE_NAME_ScreenSubtitle,

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('_UPPER_CAMEL_CASE_NAME_Screen'),
      ),
      body: SafeArea(
        child: BlocBuilder<_UPPER_CAMEL_CASE_NAME_Bloc, _UPPER_CAMEL_CASE_NAME_State>(
          builder: (context, state) {
            return state.type.map(
              loading: () => const LoadingPage(),
              loaded: () {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Insets.medium,
                    horizontal: Insets.large,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [],
                  ),
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
