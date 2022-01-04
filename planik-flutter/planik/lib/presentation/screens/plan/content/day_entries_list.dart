import 'package:flutter/material.dart';
import 'package:planik/domain/model/day.dart';
import 'package:planik/domain/model/day_entry.dart';
import 'package:planik/presentation/screens/plan/content/day_entry_item.dart';

typedef OnItemTap = void Function(DayEntry item);

class DayEntriesList extends StatelessWidget {
  const DayEntriesList({
    required this.day,
    this.onItemTap,
    Key? key,
  }) : super(key: key);

  final Day day;
  final OnItemTap? onItemTap;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final entry = day.entries[index];
          final formattedStartTime = TimeOfDay.fromDateTime(entry.start).format(context);
          final formattedEndTime = TimeOfDay.fromDateTime(entry.end).format(context);
          final time = '$formattedStartTime -- $formattedEndTime';
          return Material(
            child: InkWell(
              onTap: onItemTap != null
                  ? () {
                      onItemTap!(entry);
                    }
                  : null,
              child: DayEntryItem(
                ordinal: index,
                title: entry.title,
                time: time,
                pause: '${entry.pauseMinutes}',
              ),
            ),
          );
        },
        childCount: day.entries.length,
      ),
    );
  }
}
