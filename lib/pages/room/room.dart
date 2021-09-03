import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/dioClient.dart';

class StateRoomPage extends StatefulWidget {
  @override
  // State<StatefulWidget> createState() {
  //   return _MyRoomPageState();
  // }
  _MyRoomPageState createState() => _MyRoomPageState();
}

class _MyRoomPageState extends State<StateRoomPage>
    with SingleTickerProviderStateMixin {
  // tabText
  List mTabs = [
    {"text": "进行中", "value": 0},
    {"text": "已完成", "value": 1}
  ];
  late TabController _tabController;

  @override
  void initState() {
    // 初始化
    super.initState();
    _tabController = new TabController(length: mTabs.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "交付批次",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          brightness: Brightness.light,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30.0,
            ),
            onPressed: () => {},
          ),
          title: Text(
            "交付批次",
            style: TextStyle(
              fontSize: 24.0,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          actions: <Widget>[
            IconButton(
                onPressed: () => {},
                icon: Icon(
                  Icons.search_outlined,
                  color: Colors.black,
                  size: 30.0,
                ))
          ],
          bottom: TabBar(
            automaticIndicatorColorAdjustment: true,
            unselectedLabelColor: Colors.grey.shade600,
            unselectedLabelStyle: TextStyle(fontSize: 20.0),
            labelColor: Colors.blue.shade600,
            labelStyle: TextStyle(fontSize: 20.0),
            tabs: mTabs.map((item) {
              return Tab(text: item["text"]);
            }).toList(),
            controller: _tabController,
          ),
        ),
        body: TabBarView(
          physics: ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: mTabs.map<Widget>((item) {
            if (item["value"] == 0) return _UnfinishedListRefreshIndicator();
            return _FinishedListRefreshIndicator();
          }).toList(),
          controller: _tabController,
        ),
      ),
    );
  }
}

// 未完成
// ignore: must_be_immutable
class _UnfinishedListRefreshIndicator extends StatelessWidget {
  dynamic unListData = [];

  void _initData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("data") != null) {
      final data = prefs.getString("data");
      this.unListData = jsonDecode(data);
    }
  }

  Widget build(BuildContext context) {
    // 请求接口
    DioClient().get("/im/profile/test");
    _initData();
    return _ListRefreshIndicator(unListData);
  }
}

// 已完成
// ignore: must_be_immutable
class _FinishedListRefreshIndicator extends StatelessWidget {
  dynamic listData = [1, 2];
  void _initData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("data") != null) {
      final data = prefs.getString("data");
      this.listData = jsonDecode(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    _initData();
    return _ListRefreshIndicator(this.listData);
  }
}

// ignore: must_be_immutable
class _ListRefreshIndicator extends StatefulWidget {
  dynamic listData;
  _ListRefreshIndicator(this.listData);
  // List listData;
  @override
  State<StatefulWidget> createState() {
    print(this.listData);
    return _ListBox(this.listData);
  }
}

// listbox
class _ListBox extends State<_ListRefreshIndicator>
    with SingleTickerProviderStateMixin {
  _ListBox(this.listData);
  dynamic listData;

  ScrollController _scrollcontroller =
      new ScrollController(initialScrollOffset: 10.0, keepScrollOffset: false);

  // 获取数据
  void _initData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("data") != null) {
      final data = prefs.getString("data");
      this.listData = jsonDecode(data);
    }
  }

  // 初始状态
  @override
  void initState() {
    super.initState();
    // 添加滚动方法
    _scrollcontroller.addListener(() {
      if (_scrollcontroller.position.pixels > 1.0 &&
          _scrollcontroller.position.pixels ==
              _scrollcontroller.position.maxScrollExtent) {
        setState(() {
          this.listData.add(3);
        });
        print("滚动到底部....");
      }
    });
  }

  @override
  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    _scrollcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      // 下拉刷新
      onRefresh: () async {
        //模拟网络请求
        await Future.delayed(Duration(milliseconds: 2000));
        this._initData();
        _initData();
        // return Future.value(this.listData);
      },
      child: Scrollbar(
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: this.listData.length,
          itemBuilder: (BuildContext context, int index) {
            return _ListItem();
          },
          controller: _scrollcontroller,
        ),
      ),
    );
  }
}

// item
class _ListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            // 标题
            alignment: Alignment.bottomLeft,
            child: Text("广州埃文斯一期正式交付广州埃文斯一期正式交付广州埃文斯一期正式交付",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Align(
            // 日期
            alignment: Alignment.bottomLeft,
            child: Text("2020-01-01至2020-01-31",
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[600],
                )),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 10.0),
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey.shade200)),
            ),
            width: MediaQuery.of(context).size.width,
            child: Wrap(
              spacing: 8.0,
              children: <Widget>[
                Chip(
                  // 标签
                  backgroundColor: Colors.red[50],
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1.0, color: Colors.red.shade200),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  label: Text("已超时27天"),
                  labelStyle: TextStyle(
                    color: Colors.red[500],
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey.shade200)),
            ),
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: _NumBox(), // 数量
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey.shade200)),
            ),
            child: Row(
              children: <Widget>[
                Text(
                  "同步基础数据",
                  style: TextStyle(color: Colors.blue.shade500, fontSize: 20.0),
                ),
                Icon(Icons.check_circle, color: Colors.blue.shade400),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.0, color: Colors.grey.shade200),
              ),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.only(left: 0),
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text(
                "开始查验",
                style: TextStyle(fontSize: 20.0, color: Colors.grey.shade700),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.0, color: Colors.grey.shade200),
              ),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.only(left: 0),
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text(
                "整改情况",
                style: TextStyle(fontSize: 20.0, color: Colors.grey.shade700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 数量
class _NumBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          // 未交付
          child: Column(
            children: [
              Text(
                "未交付",
                style: TextStyle(color: Colors.grey[700]),
              ),
              Text(
                "110",
                style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          // 已交付
          child: Column(
            children: [
              Text(
                "已交付",
                style: TextStyle(color: Colors.grey[700]),
              ),
              Text(
                "210",
                style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          // 批次总套数
          child: Column(
            children: [
              Text(
                "批次总套数",
                style: TextStyle(color: Colors.grey[700]),
              ),
              Text(
                "320",
                style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          // 问题总数
          child: Column(
            children: [
              Text(
                "问题总数",
                style: TextStyle(color: Colors.grey[700]),
              ),
              Text(
                "2863",
                style: TextStyle(
                  color: Colors.red[600],
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
