import 'package:flutter/material.dart';

// ignore: must_be_immutable
class IconPage extends StatelessWidget {
  List<String> _iconData = ["ac_unit"];
  _iconList() {
    return this._iconData.map<Widget>((String e) {
      return Column(
        children: [Icon(Icons.ac_unit), Text(e)],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "图标",
      home: Scaffold(
        appBar: AppBar(
          title: Text("图标"),
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
            child: Row(
              children: this._iconList(),
            ),
          ),
        ),
      ),
    );
  }
}
