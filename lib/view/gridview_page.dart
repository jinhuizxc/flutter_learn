import 'package:flutter/material.dart';
import 'package:flutter_sample/router/router.dart';
import 'package:flutter_sample/view/listview_page.dart';

// 列表项
class GridViewPage extends StatefulWidget {
  final List<ListItem> items;

  GridViewPage({this.items, Key key}) : super(key: key);

  @override
  _GridViewPageState createState() => _GridViewPageState();
}

class _GridViewPageState extends State<GridViewPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: GridView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: widget.items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, //横轴元素个数
                mainAxisSpacing: 10.0, //纵轴间距
                crossAxisSpacing: 10.0, //横轴间距
                childAspectRatio: 1.0), //子组件宽高长度比例),
            itemBuilder: (BuildContext context, int index) {
              return getItemContainer(widget.items[index]);
            }));
  }

  Widget getItemContainer(ListItem item) {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(
                color: Color.fromRGBO(233, 233, 233, 0.9), width: 1)),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Icon(
                item.icon,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(item.title, style: TextStyle(fontSize: 12)),
            ),
            SizedBox(height: 15)
          ],
        ),
      ),
      onTap: () {
        XRouter.goto(context, item.pageName);
      },
    );
  }
}
