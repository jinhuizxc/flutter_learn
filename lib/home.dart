import 'package:flutter/material.dart';
import 'package:flutter_sample/i10n/localization_intl.dart';
import 'package:flutter_sample/router/route.dart';
import 'package:flutter_sample/utils/click.dart';
import 'package:flutter_sample/utils/xupdate.dart';
import 'package:flutter_sample/view/gridview_page.dart';
import 'package:flutter_sample/view/home/home_drawer.dart';

class MainHomePage extends StatefulWidget {
  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);

    XUpdate.initAndCheck();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(Languages.of(context).title),
          bottom: TabBar(controller: _tabController, tabs: getTabs(context)),
        ),
        drawer: HomeDrawer(),
        body: TabBarView(
            controller: _tabController,
            children: getTabViews(context).map((widget) {
              return widget;
            }).toList()),
      ),
      //监听导航栏返回,类似onKeyEvent
      onWillPop: () =>
          ClickUtils.exitBy2Click(status: _scaffoldKey.currentState),
    );
  }

  List<Tab> getTabs(BuildContext context) {
    return [
      Tab(text: Languages.of(context).widget),
      Tab(text: Languages.of(context).utils),
      Tab(text: Languages.of(context).expand)
    ];
  }

  List<Widget> getTabViews(BuildContext context) => [
        GridViewPage(items: RouteMap.getWidgetItems(context)),
        GridViewPage(items: RouteMap.getUtilsItems(context)),
        GridViewPage(items: RouteMap.getExpandItems(context)),
      ];
}
