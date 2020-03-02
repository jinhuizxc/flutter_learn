import 'package:flutter/material.dart';
import 'package:flutter_sample/view/listview_page.dart';

class GridViewPage extends StatefulWidget {

  final List<ListItem> items;

  GridViewPage({this.items, Key key}): super(key: key);

  @override
  _GridViewPageState createState() => _GridViewPageState();
}

class _GridViewPageState extends State<GridViewPage> {
  @override
  Widget build(BuildContext context) {
    return Center();
  }
}
