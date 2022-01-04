import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:intl/intl.dart';
import 'package:planik/domain/model/day.dart';
import 'package:planik/presentation/common/dimen.dart';
import 'package:planik/presentation/common/extensions.dart';
import 'package:planik/presentation/screens/plan/content/day_entries_list.dart';

class DayEntriesStickyHeaderList extends StatelessWidget {
  const DayEntriesStickyHeaderList({
    required this.day,
    this.onItemTap,
    Key? key,
  }) : super(key: key);

  static final dateFormat = DateFormat('y-MM-dd');

  final Day day;
  final OnItemTap? onItemTap;

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: Container(
        decoration: BoxDecoration(
          color: context.theme.canvasColor,
          boxShadow: [
            BoxShadow(
              color: context.palette.inactiveColor,
              offset: const Offset(0, 1),
              blurRadius: 1,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: Insets.large,
            top: Insets.large,
            right: Insets.large,
            bottom: Insets.xLarge,
          ),
          child: Row(
            children: <Widget>[
              Text(
                day.name,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Text(
                  dateFormat.format(day.date),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
      ),
      sliver: DayEntriesList(day: day, onItemTap: onItemTap),
    );
  }
}
