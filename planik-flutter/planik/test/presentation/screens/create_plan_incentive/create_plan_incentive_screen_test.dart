import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:planik/presentation/screens/create_plan_incentive/create_plan_incentive_screen.dart';

import '../../../testable.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class FakeRoute extends Fake implements Route {}

void main() {
  group(
    'CreatePlanIncentiveScreen',
    () {
      setUpAll(
        () {
          registerFallbackValue(FakeRoute());
        },
      );

      testWidgets(
        'Screen renders properly',
        (tester) async {
          // arrange
          final mockNavigatorObserver = MockNavigatorObserver();

          // find
          final title = find.text('Planik');
          // ignore: avoid_escaping_inner_quotes
          final header = find.text('Let\'s create\na new Plan!');
          final buttonText = find.text('Go');
          final button = find.byType(ElevatedButton);

          // test
          await tester.pumpWidget(
            Testable(
              navigatorObservers: [mockNavigatorObserver],
              onGenerateRoute: (settings) {
                if (settings.name == '/create-plan') {
                  return MaterialPageRoute(builder: (context) => const Scaffold());
                }
                return null;
              },
              child: const CreatePlanIncentiveScreen(),
            ),
          );

          await tester.pump();

          await tester.tap(button);

          verify(() => mockNavigatorObserver.didPush(any(), any()));

          await tester.pump();

          // expect
          expect(title, findsOneWidget);
          expect(header, findsOneWidget);
          expect(buttonText, findsOneWidget);
        },
      );
    },
  );
}
