import 'package:flutter/material.dart';
import 'package:flutter_sample/router/router.dart';

class ListViewPage extends StatefulWidget {
  ListViewPage({Key key, this.items}) : super(key: key);

  final List<ListItem> items;

  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          itemCount: widget.items.length, // item 的个数
          separatorBuilder: (BuildContext context, int index) =>
              Divider(height: 1.0, color: Colors.grey), // 添加分割线
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(widget.items[index].title), // item 标题
              leading: Icon(widget.items[index].icon), // item 前置图标
              subtitle: Text(widget.items[index].subTitle), // item 副标题
              trailing: Icon(Icons.keyboard_arrow_right), // item 后置图标
              isThreeLine: false, // item 是否三行显示
              dense: true, // item 直观感受是整体大小
              contentPadding: EdgeInsets.only(
                  left: 20, right: 10, top: 5, bottom: 5), // item 内容内边距
              enabled: true,
              onTap: () {
                XRouter.goto(context, widget.items[index].pageName);
              },
              onLongPress: () {
                print('长按:$index');
              }, // item onLongPress 长按事件
              selected: false, // item 是否选中状态
            );
          },
        ),
      ),
    );
  }
}

class ListItem {
  final IconData icon;
  final String title;
  final String subTitle;
  final String pageName;
  const ListItem(this.icon, this.title, this.subTitle, this.pageName);
}
