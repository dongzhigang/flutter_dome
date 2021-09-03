import 'package:flutter/material.dart';
// import 'layout/bottomNavigationBars.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "工作",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter Dome1"),
          actions: <Widget>[
            IconButton(onPressed: () => {}, icon: Icon(Icons.qr_code_outlined))
          ],
        ),
        body: Container(
          child: Text("1111"),
        ),
      ),
    );
  }
}
