import 'package:flutter/material.dart';
import 'package:planik/presentation/common/dimen.dart';
import 'package:planik/presentation/common/extensions.dart';

class DayEntryItem extends StatelessWidget {
  const DayEntryItem({
    required this.ordinal,
    required this.title,
    required this.time,
    required this.pause,
    Key? key,
  }) : super(key: key);

  final int ordinal;
  final String title;
  final String time;
  final String pause;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Insets.large,
                horizontal: Insets.large,
              ),
              child: Text(
                ordinal.toString(),
                style: context.theme.textTheme.caption,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: Insets.small,
                      right: Insets.small,
                      bottom: Insets.xSmall,
                    ),
                    child: Text(
                      title,
                      style: context.theme.textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: Insets.small,
                      right: Insets.small,
                      bottom: Insets.small,
                    ),
                    child: Text(time, style: context.theme.textTheme.bodyText2),
                  ),
                ],
              ),
            )
          ],
        ),
        Ink(
          color: context.palette.inactiveColor,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(
              left: Insets.small,
              top: Insets.small,
              right: Insets.large,
              bottom: Insets.xSmall,
            ),
            child: Text(
              pause,
              style: Theme.of(context).textTheme.caption,
              textAlign: TextAlign.end,
            ),
          ),
        ),
      ],
    );
  }
}
