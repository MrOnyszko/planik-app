import 'package:flutter_test/flutter_test.dart';
import 'package:planik/presentation/screens/plan/content/day_entry_item.dart';
import 'package:planik/presentation/screens/plan/content/plan_vertical.dart';

import '../../../../day_entries_test_data.dart';
import '../../../../testable.dart';

void main() {
  testWidgets(
    'PlanVertical displays correct data',
    (tester) async {
      await tester.pumpWidget(
        Testable(
          child: PlanVertical(title: 'Planik', days: days, appBarActions: const []),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Planik'), findsOneWidget);
      expect(find.byType(DayEntryItem), findsNWidgets(5));
      expect(find.text('Monday'), findsOneWidget);
      expect(find.text('2020-07-06'), findsOneWidget);
      expect(find.text('2020-07-07'), findsOneWidget);
      expect(find.text('0'), findsNWidgets(2));
      expect(find.text('Math'), findsNWidgets(2));
      expect(find.text('8:00 AM -- 8:45 AM'), findsNWidgets(2));
      expect(find.text('1'), findsNWidgets(2));
      expect(find.text('History'), findsNWidgets(2));
      expect(find.text('Latin'), findsOneWidget);
    },
  );
}
