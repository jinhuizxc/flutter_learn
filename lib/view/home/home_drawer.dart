import 'package:flutter/material.dart';
import 'package:flutter_sample/i10n/localization_intl.dart';
import 'package:flutter_sample/router/router.dart';
import 'package:flutter_sample/utils/xuifont.dart';
import 'package:flutter_sample/view/home/about.dart';
import 'package:flutter_sample/view/home/language.dart';
import 'package:flutter_sample/view/home/sponsor.dart';
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
              MediaQuery.removePadding(  // Flutter会为某些Widget默认设置一些padding，使用它包裹可以设置去掉这些padding
                  context: context,
                  child: ListView(
                    shrinkWrap: true, //为true可以解决子控件必须设置高度的问题
                    scrollDirection: Axis.vertical, // 禁用滑动事件
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.color_lens),
                        title: Text(Languages.of(context).theme),
                      ),
                      ListTile(
                        leading: Icon(Icons.language),
                        title: Text(Languages.of(context).language),
                        onTap: () => {XRouter.gotoWidget(context, LanguagePage())},
                      ),
                      ListTile(
                        leading: Icon(Icons.attach_money),
                        title: Text(Languages.of(context).sponsor),
                        onTap: () => {XRouter.gotoWidget(context, SponsorPage())},
                      ),
                      ListTile(
                        leading: Icon(Icons.error_outline),
                        title: Text(Languages.of(context).about),
                        onTap: ()=>{
                          XRouter.gotoWidget(context, AboutPage())
                        },
                      ),
                      // 添加分割线
                      Divider(height: 1.0, color: Colors.grey),
                      ListTile(
                        leading: Icon(XUIIcons.logout),
                        title: Text(Languages.of(context).logout),
                        onTap: (){
                          value.nickName = null;
                          Navigator.of(context).pushReplacementNamed('/login');
                        },
                      ),
                    ],
                  ))
            ],
          ),
        );
      },
    );
  }
}
