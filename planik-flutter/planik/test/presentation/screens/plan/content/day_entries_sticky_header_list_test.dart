import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:planik/presentation/screens/plan/content/day_entries_sticky_header_list.dart';
import 'package:planik/presentation/screens/plan/content/day_entry_item.dart';

import '../../../../day_entries_test_data.dart';
import '../../../../testable.dart';

void main() {
  testWidgets(
    'DayEntriesStickyHeaderList displays correct data',
    (tester) async {
      await tester.pumpWidget(
        Testable(
          child: CustomScrollView(
            slivers: <Widget>[
              DayEntriesStickyHeaderList(day: monday),
            ],
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(DayEntryItem), findsNWidgets(2));
      expect(find.text('Monday'), findsOneWidget);
      expect(find.text('2020-07-06'), findsOneWidget);
      expect(find.text('0'), findsOneWidget);
      expect(find.text('Math'), findsOneWidget);
      expect(find.text('8:00 AM -- 8:45 AM'), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
      expect(find.text('History'), findsOneWidget);
    },
  );
}
