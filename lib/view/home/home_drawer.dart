import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/provider.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfile>(
      builder: (BuildContext context, UserProfile value, Widget child) {
        return Drawer(
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Container(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              MediaQuery.removePadding(context: context, child: ListView(
                shrinkWrap: true, //为true可以解决子控件必须设置高度的问题
                scrollDirection: Axis.vertical,  //禁用滑动事件
              ))
            ],
          ),
        );
      },
    );
  }
}
