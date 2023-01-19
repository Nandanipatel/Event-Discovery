import 'package:flutter/material.dart';
import './views/homePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // primaryColor: Colors.white,
          appBarTheme: AppBarTheme(
        color: Color.fromARGB(255, 28, 181, 219),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      )),
      home: Home(),
    );
  }
}
