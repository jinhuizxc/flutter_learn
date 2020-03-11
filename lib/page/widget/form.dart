import 'package:flutter/material.dart';
import 'package:flutter_sample/utils/toast.dart';
import 'package:flutter_sample/view/loading_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FormPage extends StatefulWidget {
  FormPage(this.title, {Key key}) : super(key: key);
  final String title;

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  // 响应空白处的焦点的Node
  FocusNode blankNode = new FocusNode();
  bool _isShowPassword = false;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  GlobalKey _fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GestureDetector(
        onTap: () {
          // 点击空白页面关闭键盘
          closeKeyboard(context);
        },
        // 单子滚动视图
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

  // 构建表单
  Widget buildForm(BuildContext context) {
    return Form(
        key: _fromKey, //设置globalKey，用于后面获取FormState
        autovalidate: true, //开启自动校验
        child: Column(
          children: <Widget>[
            Center(
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
                  labelText: '用户名',
                  hintText: '用户名或邮箱',
                  icon: Icon(Icons.person)),
              //校验用户名
              validator: (val) {
                return val
                    .trim()
                    .length > 0 ? null : '用户名不能为空';
              },
            ),
            TextFormField(
                controller: _pwdController,
                decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "您的登录密码",
                  icon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                      icon: Icon(
                        _isShowPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: showPassWord),
                ),
                obscureText: !_isShowPassword, // 是否是密码
                //校验密码
                validator: (v) {
                  return v
                      .trim()
                      .length >= 8 ? null : "密码不能少于8位";
                }),
            // 登录按钮
            Padding(padding: const EdgeInsets.only(top: 28.0),
              child: Row(
                children: <Widget>[
                  Expanded(child: Builder(builder: (context) {
                    return RaisedButton(
                        padding: EdgeInsets.all(15.0),
                        child: Text('登录'),
                        color: Theme
                            .of(context)
                            .primaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          //由于本widget也是Form的子代widget，所以可以通过下面方式获取FormState
                          if (Form.of(context).validate()) {
                            onSubmit(context);
                          }
                        });
                  }))
                ],
              ),)

          ],
        ));
  }

  ///点击控制密码是否显示
  void showPassWord() {
    setState(() {
      _isShowPassword = !_isShowPassword;
    });
  }

  //验证通过提交数据
  void onSubmit(BuildContext context) {
    closeKeyboard(context);

    showDialog(context: context, barrierDismissible: false,
        builder: (BuildContext context) {
          return LoadingDialog(
            content: '登录中...',
            loadingView: SpinKitCircle(color: Colors.lightBlue,),
          );
        });
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context); // 清空dialog
      XToast.success(
          "用户名:" + _nameController.text + ",密码:" + _pwdController.text);
    });
  }
}
