import 'package:flutter/material.dart';

class BottomNavigationBarPage extends StatefulWidget {
  BottomNavigationBarPage(this.title, {Key key}) : super(key: key);
  final String title;

  @override
  _BottomNavigationBarPageState createState() =>
      _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
  int _currentIndex = 0;

  List<BottomNavigationBarItem> _tabs = <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('主页')),
    BottomNavigationBarItem(title: Text("列表"), icon: Icon(Icons.list)),
    BottomNavigationBarItem(title: Text("新建"), icon: Icon(Icons.add)),
    BottomNavigationBarItem(title: Text("消息"), icon: Icon(Icons.message)),
    BottomNavigationBarItem(title: Text("菜单"), icon: Icon(Icons.menu)),
    BottomNavigationBarItem(title: Text("其他"), icon: Icon(Icons.devices_other)),
  ];

  void _onItemTap(int index) {
    if (mounted) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _tabs.map((BottomNavigationBarItem item) {
          return Center(
            child: item.title,
          );
        }).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _tabs,
        currentIndex: _currentIndex,
        onTap: _onItemTap,
        //shifting :按钮点击移动效果
        //fixed：固定
        type: BottomNavigationBarType.fixed,
        fixedColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
