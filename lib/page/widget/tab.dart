import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// tab
class TabPage extends StatefulWidget {

  TabPage(this.title, {Key key}) : super(key: key);
  final String title;

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> with SingleTickerProviderStateMixin {

  TabController _tabController;

  final List<Tab> _mTabs = <Tab>[
    Tab(
      icon: Icon(Icons.home),
      text: '语文',
    ),
    Tab(
      icon: Icon(Icons.text_fields),
      text: '数学',
    ),
    Tab(
      icon: Icon(Icons.access_alarm),
      text: '英语',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _mTabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: TabBar(controller: _tabController, tabs: _mTabs),
      ),
      body: TabBarView(
          controller: _tabController,
          dragStartBehavior: DragStartBehavior.start,
          children: _mTabs.map((item) {
            return Center(child: Text(item.text),);
          }).toList()),
    );
  }
}
