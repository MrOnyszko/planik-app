import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:planik/presentation/screens/plan/content/day_entry_item.dart';
import 'package:planik/presentation/screens/plan/content/plan_horizontal.dart';

import '../../../../day_entries_test_data.dart';
import '../../../../testable.dart';

void main() {
  testWidgets(
    'PlanHorizontal displays correct data',
    (tester) async {
      await tester.pumpWidget(
        Testable(
          child: PlanHorizontal(title: const Text('Planik'), days: days),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Planik'), findsOneWidget);
      expect(find.byType(DayEntryItem), findsNWidgets(2));
      expect(find.byType(Tab), findsNWidgets(2));

      expect(find.text('Monday'), findsOneWidget);
      expect(find.text('Math'), findsOneWidget);
      expect(find.text('History'), findsOneWidget);
      expect(find.text('8:00 AM -- 8:45 AM'), findsOneWidget);
      expect(find.text('9:00 AM -- 9:45 AM'), findsOneWidget);
      expect(find.text('15'), findsOneWidget);
      expect(find.text('5'), findsOneWidget);

      await tester.tap(find.byKey(const Key('Tuesday')));

      await tester.pumpAndSettle();

      expect(find.byType(DayEntryItem), findsNWidgets(3));
      expect(find.text('Tuesday'), findsOneWidget);
      expect(find.text('Math'), findsOneWidget);
      expect(find.text('History'), findsOneWidget);
      expect(find.text('Latin'), findsOneWidget);
      expect(find.text('8:00 AM -- 8:45 AM'), findsOneWidget);
      expect(find.text('9:00 AM -- 9:45 AM'), findsOneWidget);
      expect(find.text('9:50 AM -- 10:30 AM'), findsOneWidget);
      expect(find.text('15'), findsOneWidget);
      expect(find.text('5'), findsNWidgets(2));
    },
  );
}
