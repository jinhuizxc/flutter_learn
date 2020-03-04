//状态管理
import 'package:flutter/material.dart';
import 'package:flutter_sample/utils/shared_preference.dart';
import 'package:provider/provider.dart';

class Store {
  Store._internal();

  //全局初始化
  static init(Widget child) {
    //多个Provider
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter(10)),
        ChangeNotifierProvider(create: (_) => AppTheme(getDefaultTheme())),
        ChangeNotifierProvider.value(value: LocaleModel(SPUtils.getLocale())),
        ChangeNotifierProvider.value(value: UserProfile(SPUtils.getNickName())),
      ],
      child: child,
    );
  }

  //获取值 of(context)  这个会引起页面的整体刷新，如果全局是页面级别的
  static T value<T>(BuildContext context, {bool listen = false}) {
    return Provider.of<T>(context, listen: listen);
  }

  //获取值 of(context)  这个会引起页面的整体刷新，如果全局是页面级别的
  static T of<T>(BuildContext context, {bool listen = true}) {
    return Provider.of<T>(context, listen: listen);
  }

  // 不会引起页面的刷新，只刷新了 Consumer 的部分，极大地缩小你的控件刷新范围
  static Consumer connect<T>({builder, child}) {
    return Consumer<T>(builder: builder, child: child);
  }

}

// 获取默认主题
MaterialColor getDefaultTheme() {
  return AppTheme._materialColors[SPUtils.getThemeColorIndex()];
}

//计数演示
class Counter with ChangeNotifier {
  int _count;

  Counter(this._count);

  // 添加方法
  void add() {
    _count++;
    notifyListeners();
  }

  // get方法
  get count => _count;
}

///主题
class AppTheme with ChangeNotifier {
  // 定义一组颜色变量
  static final List<MaterialColor> _materialColors = [
    Colors.blue,
    Colors.lightBlue,
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.grey,
    Colors.orange,
    Colors.amber,
    Colors.yellow,
    Colors.lightGreen,
    Colors.green,
    Colors.lime
  ];

  MaterialColor _themeColor;

  AppTheme(this._themeColor);

  // 设置颜色
  void setColor(MaterialColor color) {
    _themeColor = color;
    notifyListeners();
  }

  // 改变颜色
  void changeColor(int index) {
    _themeColor = _materialColors[index];
    SPUtils.saveThemeColorIndex(index);
    notifyListeners();
  }

  get themeColor => _themeColor;
}

///语言
class LocaleModel with ChangeNotifier {
  // 获取当前Locale的字符串表示
  String _locale;

  LocaleModel(this._locale);

  // 获取当前Locale的字符串表示
  String get locale => _locale;

  // 获取当前用户的APP语言配置Locale类，如果为null，则语言跟随系统语言
  Locale getLocale() {
    if (_locale == null) return null;
    var t = _locale.split('_');
    return Locale(t[0], t[1]); // _languageCode, _countryCode
  }

  // 用户改变APP语言后，通知依赖项更新，新语言会立即生效
  set locale(String locale) {
    if (_locale != locale) {
      _locale = locale;
      SPUtils.saveLocale(_locale);
      notifyListeners();
    }
  }
}

///用户账户信息  Profile: 配置信息
class UserProfile with ChangeNotifier {
  String _nickName;

  UserProfile(this._nickName);

  String get nickName => _nickName;

  set nickName(String value) {
    _nickName = value;
    SPUtils.saveNickName(_nickName);
    notifyListeners();
  }
}
