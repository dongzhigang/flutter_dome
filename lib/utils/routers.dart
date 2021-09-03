import 'package:flutter/material.dart';
import '../pages/index.dart';

class Routers {
  init<Map>() {
    return <String, WidgetBuilder>{
      "/": (BuildContext context) => IndexPage(),
    };
  }
}
