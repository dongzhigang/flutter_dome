import 'package:flutter/material.dart';

typedef MStartRefrensh = void Function();

class HomeListPage extends StatefulWidget {
  @override
  State<HomeListPage> createState() => _HomeListViewState();
}

class _HomeListViewState extends State<HomeListPage>
    with SingleTickerProviderStateMixin {
  double _headHeight = 0.0;
  double _headNormalheight = 40.0;
  double _dY = 0;
  late double _leng;
  bool _firstJump = false;
  bool _isTouchDown = false;
  late ScrollController _scrollController;
  late AnimationController _animationController;
  late Animation<double> _animation;
  late MStartRefrensh pointerUpListener;

  @override
  initState() {
    super.initState();
    this._scrollController = ScrollController();
    this._animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    this._animation =
        Tween(begin: 1.0, end: 0.0).animate(this._animationController);
    this._animation.addListener(() {
      print("leng:${this._leng}");
      // ignore: unused_element
      setState(() {
        this._headHeight =
            (this._leng - this._headNormalheight) * this._animation.value +
                this._headNormalheight;
      });

      print(
          "leng - _headHeight:${(this._leng - this._headNormalheight) * this._animation.value}");
      // print("_headHeight:${this._headHeight}");
    });
  }

  @override
  void dispose() {
    super.dispose();
    // ignore: unnecessary_null_comparison
    if (this._scrollController != null) this._scrollController.dispose();
    // ignore: unnecessary_null_comparison
    if (this._animationController != null) this._animationController.dispose();
  }

  // 手指按下
  void _onPointerDown(PointerDownEvent event) {
    // 记录Y点距离
    this._dY = event.position.dy;
    this._isTouchDown = true;
  }

  // 手指移动
  void _onPointerMove(PointerMoveEvent event) {
    if (event.position.dy - _dY > 0) {
      setState(() {
        this._headHeight =
            (event.position.dy - this._dY) / 2 + this._headNormalheight;
      });
    }
  }

  // 手指松开
  void _onPointerUp(PointerUpEvent event) {
    if (this._headHeight > this._headNormalheight) {
      this.startUpAnimation(this._headHeight);
    } else {
      setState(() {
        this._headHeight = this._headNormalheight;
      });
    }
    this._isTouchDown = false;
  }

  // 手指结束
  void _onPointerCancel(PointerCancelEvent event) {
    if (this._headHeight > this._headNormalheight) {
      this.startUpAnimation(this._headHeight);
    } else {
      setState(() {
        this._headHeight = this._headNormalheight;
      });
    }
    this._isTouchDown = false;
    print("最后：：${this._headHeight}");
  }

  startUpAnimation(double len) {
    this._leng = len;
    if (this._animationController.isCompleted) {
      this._animationController.reset();
    }
    this._animationController.forward().then((_) {
      this._headHeight = this._headNormalheight;
      this.pointerUpListener();
    });
  }

  _finishLoading() {
    // ignore: unnecessary_null_comparison
    if (this._scrollController != null && this._scrollController.hasClients) {
      print("hh哈哈哈哈哈哈哈哈哈哈");
      this._scrollController.animateTo(
            this._headNormalheight,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 100),
          );
    }
  }

  // 加载header
  _getRfrenshHeader() {
    if (this._headHeight == this._headNormalheight && !this._isTouchDown) {
      print("head1：${this._headHeight}");
      return Container(
        child: SizedBox(
          child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange)),
          height: 20.0,
          width: 20.0,
        ),
        alignment: Alignment.center,
        height: this._headHeight,
      );
    } else {
      print("head2：${this._headHeight}");
      return Container(
        color: Colors.blue,
        alignment: Alignment.center,
        height: this._headHeight,
        child: SizedBox(
          child: Row(
            children: <Widget>[Text("释放刷新")],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          height: 20.0,
        ),
      );
    }
  }

  // 加载数据
  _onRefrensh() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      this._finishLoading();
    });
    print("加载完成...");
  }

  @override
  Widget build(BuildContext context) {
    print("屏幕：${MediaQuery.of(context).size.width}");
    this.pointerUpListener = this._onRefrensh;
    // ignore: unnecessary_null_comparison
    if (this._scrollController == null) {
      this._scrollController =
          ScrollController(initialScrollOffset: this._headNormalheight);
    }
    // 初始化
    if (!this._firstJump) {
      if (!this._firstJump && this._scrollController.hasClients) {
        this._firstJump = true;
        this._scrollController.jumpTo(this._headNormalheight);
        print("_headNormalheight:${this._headNormalheight}");
      }
    }
    return Listener(
      child: ListView.builder(
        controller: this._scrollController,
        itemCount: 100,
        itemBuilder: (BuildContext context, int options) {
          if (options == 0) {
            return this._getRfrenshHeader();
          } else {
            // ignore: unnecessary_brace_in_string_interps
            return Text("data:${options}");
          }
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
