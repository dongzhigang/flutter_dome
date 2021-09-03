import 'package:flutter/material.dart';
import 'package:flutter_dome/pages/layout/home-list.dart';

// _HomeStateFulWidget
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomeStateMaterialApp();
}

// _HomeStateMaterialApp
class _HomeStateMaterialApp extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // return NestedScrollView(
    //   scrollDirection: Axis.vertical,
    //   headerSliverBuilder: (BuildContext context, innerBoxIsScrolled) {
    //     return [
    //       SliverAppBar(
    //         title: Text("Flutter Dome"),
    //         floating: true,
    //         pinned: true,
    //         actions: <Widget>[
    //           IconButton(
    //               onPressed: () => {}, icon: Icon(Icons.qr_code_outlined))
    //         ],
    //       ),
    //     ];
    //   },
    //   body: Container(
    //     decoration: BoxDecoration(color: Colors.white),
    //     child: _BodyContent(),
    //   ),
    // );
    return MaterialApp(
      title: "首页",
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Flutter Dome"),
          actions: <Widget>[
            IconButton(onPressed: () => {}, icon: Icon(Icons.qr_code_outlined))
          ],
        ),
        body: _BodyContent(),
      ),
    );
  }
}

// body
class _BodyContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      margin: EdgeInsets.only(top: 20.0),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: <Widget>[
            IntrinsicHeight(
              child: _SearchContent(),
            ),
            IntrinsicHeight(
              child: _MoveServer(),
            ),
            // _SearchContent(),
            // _MoveServer(),
            // Expanded(child: ListView())
            IntrinsicHeight(
              child: _BacklogTitle(),
            ),
            Expanded(
              child: HomeListPage(),
            ),
          ],
        ),
      ),
    );
  }
}

// 搜索
class _SearchContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.grey.shade500),
        padding: MaterialStateProperty.all(EdgeInsets.all(10.0)),
        side: MaterialStateProperty.all(
          BorderSide(width: 1.0, color: Colors.grey.shade300),
        ),
      ),
      onPressed: () => {print(99)},
      child: Row(
        children: <Widget>[Icon(Icons.search), Text("搜索任务")],
      ),
    );
  }
}

// 移动服务
// ignore: must_be_immutable
class _MoveServer extends StatelessWidget {
  List<BoxShadow> boxShadow = [
    BoxShadow(
      color: Colors.grey.shade200,
      offset: Offset(1, 1),
      blurRadius: 2,
    ),
    BoxShadow(
      color: Colors.grey.shade200,
      offset: Offset(-1, -1),
      blurRadius: 2,
    ),
    BoxShadow(
      color: Colors.grey.shade200,
      offset: Offset(1, -1),
      blurRadius: 2,
    ),
    BoxShadow(
      color: Colors.grey.shade200,
      offset: Offset(-1, 1),
      blurRadius: 5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(top: 10.0),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        boxShadow: boxShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        textBaseline: TextBaseline.alphabetic,
        children: <Widget>[
          _MoveServerItem(data: {
            "title": "移动驾驶舱",
            "label": "全景数据服务",
            "color": Colors.red.shade500,
            "icon": Icons.timeline,
            "iconColor": Colors.white,
            "callback": () => {print("111")}
          }),
          SizedBox(
            width: 1.0,
            height: 40.0,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.grey.shade300),
            ),
          ),
          _MoveServerItem(data: {
            "title": "移动报事",
            "label": "随时随地服务",
            "color": Colors.blue.shade500,
            "icon": Icons.timeline,
            "iconColor": Colors.white,
            "callback": () => {print("222")}
          }),
        ],
      ),
    );
  }
}

// 移动服务-item
// ignore: must_be_immutable
class _MoveServerItem extends StatelessWidget {
  Map<String, dynamic> data;

  _MoveServerItem({Key? key, required this.data}) : super(key: key);

  // 文本left
  Widget _textBox() {
    return Expanded(
      flex: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            this.data["title"],
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            this.data["label"],
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }

  // 图标right
  Widget _iconBox() {
    return Expanded(
      flex: 1,
      child: Container(
        height: 40.0,
        decoration: BoxDecoration(
          color: this.data["color"],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(Icons.timeline, color: this.data["iconColor"]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.black),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ),
        focusNode: FocusNode(),
        clipBehavior: Clip.antiAlias,
        autofocus: true,
        onPressed: this.data["callback"],
        child: Row(
          children: <Widget>[
            this._textBox(),
            this._iconBox(),
          ],
        ),
      ),
    );
  }
}

// 待办title
class _BacklogTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(
              "待办任务",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.all(0)),
              foregroundColor: MaterialStateProperty.all(Colors.grey.shade600),
            ),
            onPressed: () {
              print("跳转");
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  "已办",
                  style: TextStyle(fontSize: 18.0),
                ),
                Icon(Icons.arrow_forward),
              ],
            ),
          )
        ],
      ),
    );
  }
}
