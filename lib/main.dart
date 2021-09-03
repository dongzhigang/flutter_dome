import 'package:flutter/material.dart';
import './utils/routers.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Dome",
      initialRoute: '/',
      routes: Routers().init(),
    );
  }
}
