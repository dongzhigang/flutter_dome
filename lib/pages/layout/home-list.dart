import 'package:flutter/material.dart';

class HomeListPage extends StatefulWidget {
  @override
  State<HomeListPage> createState() => _HomeListViewState();
}

class _HomeListViewState extends State<HomeListPage> {
  double _height = 0.0, _opacity = 0.0, _startY = 0, _offsetY = 80.0;
  @override
  void initState() {
    super.initState();
  }

  // 手指按下
  void _onPointerDown(PointerDownEvent event) {}
  // 手指移动
  void _onPointerMove(PointerMoveEvent event) {}
  // 手指松开
  void _onPointerUp(PointerUpEvent event) {}
  // 手指结束
  void _onPointerCancel(PointerCancelEvent event) {}
  // 加载header
  _getRfrenshHeader() {
    return Container(
      child: SizedBox(
        child: Row(
          children: <Widget>[Text("释放刷新")],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        height: 20.0,
      ),
      alignment: Alignment.center,
      height: 40.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    print(this._height);
    print(MediaQuery.of(context).size.width);
    return Listener(
      child: ListView.builder(
        itemCount: 100,
        itemBuilder: (BuildContext context, int options) {
          if (options == 0) {
            return this._getRfrenshHeader();
          }
          return Text("data");
        },
      ),
      onPointerDown: this._onPointerDown,
      onPointerMove: this._onPointerMove,
      onPointerUp: this._onPointerUp,
      onPointerCancel: this._onPointerCancel,
    );
    // return RefreshIndicator(
    //   notificationPredicate: (notificationPredicate) => true,
    //   // strokeWidth: 50.0,
    //   displacement: 40.0,
    //   onRefresh: () async {
    //     print("888");
    //   },
    //   child: ListView.builder(
    //     shrinkWrap: true,
    //     physics: AlwaysScrollableScrollPhysics(),
    //     itemCount: 100,
    //     itemBuilder: (BuildContext context, int index) {
    //       return Container(
    //         child: Text("data"),
    //       );
    //     },
    //   ),
    // );
  }
}
