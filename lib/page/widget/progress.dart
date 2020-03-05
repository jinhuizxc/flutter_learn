import 'package:flutter/material.dart';

class ProgressPage extends StatefulWidget {
  ProgressPage(this.title, {Key key}) : super(key: key);
  final String title;

  @override
  _ProgressPageState createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage>
    with SingleTickerProviderStateMixin {
  double _progress = 0.20;

  Animation<double> _doubleAnimation;
  AnimationController _animationController;
  CurvedAnimation _curvedAnimation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _curvedAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.decelerate);

    // 补间动画
    _doubleAnimation =
        Tween(begin: 0.0, end: 360.0).animate(_animationController);
    _animationController.addListener(() {
      if (mounted) {
        this.setState(() {});
      }
    });

    // 开始动画
    onAnimationStart();
  }

  void onAnimationStart() {
    _animationController.forward(from: 0.0);
  }

  @override
  void reassemble() {
    super.reassemble();
    onAnimationStart();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            // 线性进度条
            LinearProgressIndicator(),
            SizedBox(height: 20.0,),

          ],
        ),
      ),
    );
  }
}
