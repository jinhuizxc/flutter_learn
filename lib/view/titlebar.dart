//自定义标题栏
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TitleBar {
  /*
   * 仅含 左侧返回按钮 及中间标题
   * appBar: TitleBar().backAppbar(context, '个人资料'),
   * appBar: TitleBar().backAppbar(context, '个人资料',(){}),
   */
  static backAppbar(BuildContext context, String title,
      {double height = 48, VoidCallback onPressed}) {
    return PreferredSize(
        child: AppBar(
          title: Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          centerTitle: true,
          leading: _leading(context, onPressed),
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        preferredSize: Size.fromHeight(height));
  }

  static _leading(BuildContext context, VoidCallback onPressed) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 44,
          padding: EdgeInsets.all(0),
          child: IconButton(icon: Icon(Icons.chevron_left), onPressed: (){
            if(onPressed == null){
              _popThis(context);
            }else{
              onPressed();
            }
          }),
        )
      ],
    );
  }

  static void _popThis(BuildContext context) {
    Navigator.of(context).pop();
  }
}
