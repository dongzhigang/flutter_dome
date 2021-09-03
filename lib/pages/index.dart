import 'package:flutter/material.dart';
import './home.dart';
import './menu.dart';
import './icons.dart';

class IndexPage extends StatefulWidget {
  @override
  State<IndexPage> createState() => _IndexState();
}

class _IndexState extends State<IndexPage> {
  int currentIndex = 0;
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: "首页",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.now_widgets_outlined),
      label: '工作',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.assignment_outlined),
      label: '联系',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle_outlined),
      label: '我的',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    List<Widget> bodyPage = [
      HomePage(),
      MenuPage(),
      IconPage(),
    ];
    return Scaffold(
      body: bodyPage[this.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: this.currentIndex,
        showUnselectedLabels: true,
        enableFeedback: true,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey.shade600,
        selectedItemColor: Colors.blue,
        items: this.items,
        onTap: (int value) {
          setState(() {
            this.currentIndex = value;
          });
        },
      ),
    );
  }
}
