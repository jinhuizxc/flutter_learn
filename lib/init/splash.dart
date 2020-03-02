import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sample/utils/shared_preference.dart';

//类似广告启动页
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    countDown();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Center(
        child: Image(
          image: AssetImage('assets/images/flutter.png'),
          width: 96,
          height: 96,
        ),
      ),
    );
  }

//倒计时
  void countDown() {
    var _duration = Duration(seconds: 2);
    Future.delayed(_duration, goHomePage);
  }

  //页面跳转
  void goHomePage() {
    String nickName = SPUtils.getNickName();
    if (nickName != null && nickName.isNotEmpty) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }
}
