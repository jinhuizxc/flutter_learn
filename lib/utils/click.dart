import 'package:flutter/material.dart';
import 'package:flutter_sample/utils/toast.dart';
class ClickUtils{
  ClickUtils._internal();

  static DateTime _lastPressedAt; //上次点击时间
  //双击返回
static Future<bool> exitBy2Click({int duration = 2000, ScaffoldState status}) async{
  if(status != null && status.isDrawerOpen){
    return Future.value(true);
  }

  if(_lastPressedAt == null ||
      DateTime.now().difference(_lastPressedAt) >
          Duration(microseconds: duration)){
    //两次点击间隔超过2秒则重新计时
    XToast.toast('再按一次退出程序');
    return Future.value(false);
  }
  return Future.value(true);
}

}