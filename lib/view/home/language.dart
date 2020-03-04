import 'package:flutter/material.dart';
import 'package:flutter_sample/i10n/localization_intl.dart';
import 'package:flutter_sample/utils/provider.dart';
import 'package:provider/provider.dart';

// 语言页面
class LanguagePage extends StatefulWidget {
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    Color color = Theme
        .of(context)
        .primaryColor;
    LocaleModel localeModel = Provider.of<LocaleModel>(context);
    Languages languages = Languages.of(context);

    // 设置item项
    Widget _buildLanguageItem(String lan, String value) {
      return ListTile(
        title: Text(lan, style: TextStyle(
            color: localeModel.locale == value ? color : null,
        ),),
        trailing: localeModel.locale == value ? Icon(Icons.done, color: color,) : null,
        onTap: (){
          // 切换语言
          // 此行代码会通知MaterialApp重新build
          localeModel.locale = value;
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(languages.language),),
      body: ListView(
        children: <Widget>[
          _buildLanguageItem(languages.chinese, "zh_CN"),
          _buildLanguageItem(languages.english, "en_US"),
          _buildLanguageItem(languages.auto, null),
        ],
      ),
    );
  }


}
