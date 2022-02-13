import 'package:flutter_test/flutter_test.dart';
import 'package:planik/presentation/screens/splash/splash_screen.dart';

import '../../../testable.dart';

void main() {
  group(
    'SplashScreen',
    () {
      testWidgets(
        'Screen renders properly',
        (tester) async {
          // arrange
          // ..

          // find
          final text = find.text('Planik');

          // test
          await tester.pumpWidget(
            const Testable(
              child: SplashScreen(),
            ),
          );

          // expect
          expect(text, findsOneWidget);
        },
      );
    },
  );
}
