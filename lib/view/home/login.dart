import 'package:flutter/material.dart';
import 'package:flutter_sample/i10n/localization_intl.dart';
import 'package:flutter_sample/router/router.dart';
import 'package:flutter_sample/utils/http.dart';
import 'package:flutter_sample/utils/provider.dart';
import 'package:flutter_sample/utils/toast.dart';
import 'package:flutter_sample/view/home/register.dart';
import 'package:flutter_sample/view/loading_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

// 登录页面
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 响应空白处的焦点的Node
  FocusNode _blankNode = FocusNode();
  bool _isShowPassWord = false;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();

  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text(Languages.of(context).login),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  XRouter.gotoWidget(context, RegisterPage());
                },
                child: Text(Languages.of(context).register),
                textColor: Colors.white,
              )
            ],
          ),
          body: GestureDetector(
            onTap: () {
              // 点击空白页面关闭键盘
              closeKeyboard(context);
            },
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              child: buildForm(context),
            ),
          ),
        ),
        onWillPop: () async {
          return Future.value(false);
        });
  }

  Widget _leading(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 4),
          child: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }

  void closeKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(_blankNode);
  }

//构建表单
  Widget buildForm(BuildContext context) {
    return Form(
      key: _formKey, //设置globalKey，用于后面获取FormState
      autovalidate: true, //开启自动校验
      child: Column(
        children: <Widget>[
          Center(
            // 说明: 宽度系数和高度系数是指Center的宽高是其子控件宽高的比率，
            // 例如heightFactor是2.0的话，那么Center的高度将是子控件高度的二倍。
            heightFactor: 1.5,
            child: Image(
              image: AssetImage('assets/images/flutter.png'),
              height: 64,
              width: 64,
            ),
          ),
          TextFormField(
            autofocus: false,
            controller: _nameController,
            decoration: InputDecoration(
              labelText: Languages.of(context).loginName,
              hintText: Languages.of(context).loginNameHint,
              icon: Icon(Icons.person),
            ),
            validator: (v) {
              return v.trim().length > 0
                  ? null
                  : Languages.of(context).loginNameError;
            },
          ),
          TextFormField(
            controller: _pwdController,
            decoration: InputDecoration(
                labelText: Languages.of(context).password,
                hintText: Languages.of(context).passwordHint,
                icon: Icon(Icons.lock),
                suffixIcon: IconButton(
                    icon: _isShowPassWord
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                    onPressed: showPassWord)),
            obscureText: !_isShowPassWord,
            //校验密码
            validator: (v){
              return v.trim().length >= 6 ? null : Languages.of(context).passwordError;
            },
          ),
          // 登录按钮
          Padding(
            padding: EdgeInsets.only(top: 28.0),
            child: Row(
              children: <Widget>[
                Expanded(child: Builder(builder: (context) {
                  return RaisedButton(
                      padding: EdgeInsets.all(15.0),
                      child: Text(Languages.of(context).login),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: () {
                        //由于本widget也是Form的子代widget，所以可以通过下面方式获取FormState
                        if (Form.of(context).validate()) {
                          onSubmit(context);
                        }
                      });
                }))
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///点击控制密码是否显示
  void showPassWord() {
    setState(() {
      _isShowPassWord = !_isShowPassWord;
    });
  }

  //验证通过提交数据
  void onSubmit(BuildContext context) {
    closeKeyboard(context);

    showDialog(
        context: context,
        barrierDismissible: false, // barrierDismissible可以控制点击对话框以外的区域是否隐藏对话框
        builder: (BuildContext context) {
          return LoadingDialog(
            showContent: false,
            backgroundColor: Colors.black38,
            loadingView: SpinKitCircle(
              color: Colors.white,
            ),
          );
        });

    UserProfile userProfile = Provider.of<UserProfile>(context, listen: false);
    print('打印提交的结果 0:');
    XHttp.post("/user/login", {
      "username": _nameController.text,
      "password": _pwdController.text
    }).then((response) {
      print('打印提交的结果: $response');
      Navigator.pop(context); // 取消进度条的效果
      if (response['errorCode'] == 0) {
        userProfile.nickName = response['data']['nickname'];
        XToast.toast(Languages.of(context).loginSuccess);
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        XToast.error(response['errorMsg']);
      }
    }).catchError((onError) {
      Navigator.of(context).pop();
      XToast.error(onError);
    });
  }
}
