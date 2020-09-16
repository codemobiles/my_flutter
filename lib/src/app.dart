import 'package:flutter/material.dart';
import 'package:my_flutter/src/commons/constants.dart';
import 'package:my_flutter/src/pages/home/home_page.dart';
import 'package:my_flutter/src/pages/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final _route = <String, WidgetBuilder>{
      Constants.HOME_ROUTE : (context) => HomePage(),
      Constants.LOGIN_ROUTE : (context) => LoginPage(),
    };

    return MaterialApp(
      routes: _route,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String token = snapshot.data.getString(Constants.PREF_TOKEN) ?? "";
            return token.isEmpty ? LoginPage() : HomePage();
          }
          return SizedBox();
        },
      ),
    );
  }
}
