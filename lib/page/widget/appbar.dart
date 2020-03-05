import 'package:flutter/material.dart';
import 'package:flutter_sample/router/router.dart';
import 'package:flutter_sample/utils/toast.dart';
import 'package:flutter_sample/view/titlebar.dart';

class AppBarPage extends StatefulWidget {
  final String title;

  AppBarPage(this.title, {key}) : super(key: key);

  @override
  _AppBarPageState createState() => _AppBarPageState();
}

class _AppBarPageState extends State<AppBarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add_a_photo),
              tooltip: '拍照',  // tooltip： 长按显示
              onPressed: () {}),
          IconButton(icon: Icon(Icons.add), onPressed: () {}),
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
              PopupMenuItem<String>(
                child: Text('关于'),
                value: 'about',
              ),
              PopupMenuItem<String>(
                child: Text('设置'),
                value: 'setting',
              ),
            ],
            onCanceled: () {},
            onSelected: (String action) {
              switch (action) {
                case 'about':
                  XToast.toast('点击了关于');
                  break;
                case 'setting':
                  XToast.toast('点击了设置');
                  break;
              }
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 10.0),
        child: ListView(
          scrollDirection: Axis.vertical, // 水平listView
          children: <Widget>[
            TitleBar.backAppbar(context, '个人资料'),
          ],
        ),
      ),
    );
  }
}
