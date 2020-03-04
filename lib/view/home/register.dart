import 'package:flutter/material.dart';
import 'package:flutter_sample/i10n/localization_intl.dart';
import 'package:flutter_sample/utils/http.dart';
import 'package:flutter_sample/utils/toast.dart';
import 'package:flutter_sample/view/loading_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // 响应空白处的焦点的Node
  bool _isShowPassWord = false;
  bool _isShowPassWordRepeat = false;
  FocusNode blankNode = FocusNode();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  TextEditingController _pwdRepeatController = TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Languages.of(context).register)),
      body: GestureDetector(
        onTap: () {
          // 点击空白页面关闭键盘
          closeKeyboard(context);
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: buildForm(context),
        ),
      ),
    );
  }

  void closeKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(blankNode);
  }

  //构建表单
  Widget buildForm(BuildContext context) {
    return Form(
        key: _formKey, //设置globalKey，用于后面获取FormState
        autovalidate: true, //开启自动校验
        child: Column(
          children: <Widget>[
            TextFormField(
              autofocus: false,
              controller: _nameController,
              decoration: InputDecoration(
                labelText: Languages.of(context).loginName,
                hintText: Languages.of(context).loginNameHint,
                icon: Icon(Icons.person),
              ),
              //校验用户名
              validator: (v) {
                v.trim().length > 0
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
                        icon: Icon(
                          _isShowPassWord
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        ),
                        onPressed: showPassWord)),
                obscureText: !_isShowPassWord,
                //校验密码
                validator: (v) {
                  return v.trim().length >= 6
                      ? null
                      : Languages.of(context).passwordError;
                }),
            TextFormField(
                controller: _pwdRepeatController,
                decoration: InputDecoration(
                    labelText: Languages.of(context).repeatPassword,
                    hintText: Languages.of(context).passwordHint,
                    icon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                        icon: Icon(
                          _isShowPassWordRepeat
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        ),
                        onPressed: showPassWordRepeat)),
                obscureText: !_isShowPassWordRepeat,
                //校验密码
                validator: (v) {
                  return v.trim().length >= 6
                      ? null
                      : Languages.of(context).passwordError;
                }),

            // 登录按钮
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Row(
                children: <Widget>[
                  Expanded(child: Builder(builder: (context) {
                    return RaisedButton(
                        padding: EdgeInsets.all(15.0),
                        child: Text(Languages.of(context).register),
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
        ));
  }

  ///点击控制密码是否显示
  void showPassWord() {
    setState(() {
      _isShowPassWord = !_isShowPassWord;
    });
  }

  ///点击控制密码是否显示
  void showPassWordRepeat() {
    setState(() {
      _isShowPassWordRepeat = !_isShowPassWordRepeat;
    });
  }

  //验证通过提交数据
  void onSubmit(BuildContext context) {
    closeKeyboard(context);

//    String name = _nameController.text;
//    if(name.length == null || name.isEmpty){
//      XToast.toast('用户名为空');
//      return;
//    }
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return LoadingDialog(
            showContent: false,
            backgroundColor: Colors.black38,
            loadingView: SpinKitCircle(
              color: Colors.white,
            ),
          );
        });

    XHttp.post("/user/register", {
      "username": _nameController.text,
      "password": _pwdController.text,
      "repassword": _pwdRepeatController.text
    }).then((response) {
      Navigator.pop(context);
      if (response['errorCode'] == 0) {
        XToast.toast(Languages.of(context).registerSuccess);
        Navigator.of(context).pop();
      } else {
        XToast.error(response['errorMsg']);
      }
    }).catchError((onError) {
      Navigator.of(context).pop();
      XToast.error(onError);
    });
  }
}
