import 'package:flutter/material.dart';
import 'package:planik/domain/model/day.dart';
import 'package:planik/presentation/common/dimen.dart';
import 'package:planik/presentation/common/extensions.dart';
import 'package:planik/presentation/screens/plan/content/day_entries_list.dart';

typedef OnTabChangeCallback = void Function(int index);

class PlanHorizontal extends StatefulWidget {
  const PlanHorizontal({
    required this.title,
    required this.days,
    this.appBarActions = const [],
    this.onTabChange,
    this.onItemTap,
    this.automaticallyImplyLeading = true,
    this.toolbarHeight,
    this.tabChangeNotifier,
    Key? key,
  }) : super(key: key);

  final Widget title;
  final List<Day> days;
  final List<Widget> appBarActions;
  final OnTabChangeCallback? onTabChange;
  final OnItemTap? onItemTap;
  final bool automaticallyImplyLeading;
  final double? toolbarHeight;
  final ValueNotifier<int>? tabChangeNotifier;

  @override
  _PlanHorizontalState createState() => _PlanHorizontalState();
}

class _PlanHorizontalState extends State<PlanHorizontal> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: widget.days.length);
    if (widget.onTabChange != null) {
      _tabController.addListener(
        () {
          widget.onTabChange!(_tabController.index);
        },
      );
    }

    final tabChangeNotifier = widget.tabChangeNotifier;
    if (tabChangeNotifier != null) {
      tabChangeNotifier.addListener(
        () {
          _tabController.animateTo(
            tabChangeNotifier.value,
            duration: kThemeAnimationDuration,
            curve: Curves.fastOutSlowIn,
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              pinned: true,
              centerTitle: false,
              elevation: 0,
              automaticallyImplyLeading: widget.automaticallyImplyLeading,
              actions: widget.appBarActions,
              toolbarHeight: widget.toolbarHeight ?? kToolbarHeight,
              title: SizedBox(
                height: widget.toolbarHeight,
                child: widget.title,
              ),
              titleSpacing: Insets.xLarge,
              forceElevated: innerBoxIsScrolled,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: Material(
                  color: context.theme.colorScheme.surface,
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    tabs: widget.days
                        .map(
                          (day) => Tab(key: Key(day.name), text: day.name),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: _tabController,
        children: widget.days.map(
          (day) {
            return SafeArea(
              top: false,
              bottom: false,
              child: Builder(
                builder: (context) {
                  return CustomScrollView(
                    key: PageStorageKey<String>(day.name),
                    slivers: <Widget>[
                      SliverOverlapInjector(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(vertical: Insets.xSmall),
                        sliver: DayEntriesList(day: day, onItemTap: widget.onItemTap),
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
