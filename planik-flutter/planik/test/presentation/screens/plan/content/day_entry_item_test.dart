import 'package:flutter_test/flutter_test.dart';
import 'package:planik/presentation/screens/plan/content/day_entry_item.dart';

import '../../../../testable.dart';

void main() {
  testWidgets(
    'DayEntryItem displays correct data',
    (tester) async {
      await tester.pumpWidget(
        const Testable(
          child: DayEntryItem(ordinal: 1, title: 'Title', time: '08:00 - 08:45', pause: '15'),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('1'), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('08:00 - 08:45'), findsOneWidget);
      expect(find.text('15'), findsOneWidget);
    },
  );
}
