import 'package:flutter/material.dart';
import 'package:planik/domain/model/day.dart';
import 'package:planik/presentation/common/dimen.dart';
import 'package:planik/presentation/screens/plan/content/day_entries_list.dart';

typedef OnTabChangeCallback = void Function(int index);

class PlanHorizontal extends StatefulWidget {
  const PlanHorizontal({
    required this.title,
    required this.days,
    this.appBarActions = const [],
    this.onTabChange,
    this.onItemTap,
    Key? key,
  }) : super(key: key);

  final String title;
  final List<Day> days;
  final List<Widget> appBarActions;
  final OnTabChangeCallback? onTabChange;
  final OnItemTap? onItemTap;

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
      _tabController.addListener(() {
        widget.onTabChange!(_tabController.index);
      });
    }
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
              automaticallyImplyLeading: false,
              actions: widget.appBarActions,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(
                  left: Insets.large,
                  bottom: Insets.large,
                ),
                title: Text(widget.title),
              ),
              forceElevated: innerBoxIsScrolled,
              bottom: TabBar(
                controller: _tabController,
                isScrollable: true,
                tabs: widget.days.map((day) => Tab(key: Key(day.name), text: day.name)).toList(),
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
