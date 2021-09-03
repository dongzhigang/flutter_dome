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

  @override
  Widget build(BuildContext context) {
    print(this._height);
    print(MediaQuery.of(context).size.width);
    return Listener(
        behavior: HitTestBehavior.deferToChild,
        child: Container(
          alignment: Alignment.center,
          color: Colors.blue,
          width: 300.0,
          height: 300.0,
          child: Column(
            children: [
              AnimatedContainer(
                alignment: Alignment.center,
                curve: Curves.elasticIn,
                width: MediaQuery.of(context).size.width,
                duration: Duration(seconds: 1),
                height: this._height,
                child: AnimatedOpacity(
                  duration: Duration(seconds: 1),
                  opacity: this._opacity,
                  child: Container(
                    color: Colors.grey.shade300,
                    alignment: Alignment.center,
                    child: Text("刷新00000"),
                  ),
                ),
              ),
              Text("8888"),
            ],
          ),
        ),
        onPointerDown: (PointerDownEvent event) {
          setState(() {
            this._startY = event.position.dy;
          });
          print("onPointerDown:${event.position.dy}");
        },
        onPointerMove: (PointerMoveEvent event) {
          double _offsetY = event.position.dy - this._startY;
          if (_offsetY >= this._offsetY) {
            print(_offsetY);
            print(this._offsetY);
            setState(() {
              this._height = this._offsetY;
              this._opacity = 1.0;
            });
            print("到了");
          } else {
            print(_offsetY);
            // setState(() {
            //   this._height = _offsetY > 0 ? _offsetY : 0;
            // });
          }
          // print("onPointerMove:${event.position.toString()}");
        },
        onPointerUp: (PointerUpEvent event) {
          print("onPointerUp:${event.position.toString()}");
        });
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
