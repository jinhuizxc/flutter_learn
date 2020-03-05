

import 'package:flutter/material.dart';

// 控制开关
class ControlPage extends StatefulWidget {
  ControlPage(this.title, {Key key}) : super(key: key);

  final String title;

  @override
  _ControlPageState createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  bool _check = false;
  int selectValue = -1;

  double sliderValue = 0.0;

  bool isCheck = false;
  List<bool> isChecks = [false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical, // 水平listView
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text('切换'),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () => {
                  setState(() {
                    _check = !_check;
                  })
                },
              ),
              Row(children: <Widget>[
                Text('MD风格: '),
                Switch(
                    value: _check,
                    onChanged: (bool value) {
                      setState(() {
                        _check = value;
                      });
                      print("onChanged:" + value.toString());
                    }),
                SizedBox(width: 10),
                Text("适配风格:"),
                Switch.adaptive(
                    value: _check,
                    activeColor: Colors.blue, // 激活时原点颜色
                    onChanged: (bool val) {
                      setState(() {
                        _check = val;
                      });
                      print("onChanged:" + val.toString());
                    })
              ]),
              SwitchListTile(
                title: const Text('灯光'),
                value: _check,
                onChanged: (bool val) {
                  setState(() {
                    _check = val;
                  });
                  print("onChanged:" + val.toString());
                },
                secondary: const Icon(Icons.lightbulb_outline),
              ),
              Divider(height: 3),

              //===============Radio==================//


            ],
          ),
        ),
      ),
    );
  }
}
