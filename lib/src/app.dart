import 'package:flutter/material.dart';
import 'package:my_flutter/src/pages/home/home_page.dart';
import 'package:my_flutter/src/pages/login/login_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }//command + option + l
   //ctrl + alt + l
}

