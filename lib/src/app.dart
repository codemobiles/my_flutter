import 'package:flutter/material.dart';
import 'package:my_flutter/src/commons/constants.dart';
import 'package:my_flutter/src/pages/home/home_page.dart';
import 'package:my_flutter/src/pages/login/login_page.dart';
import 'package:my_flutter/src/pages/map/map_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // feedDemo();

    final _route = <String, WidgetBuilder>{
      Constants.HOME_ROUTE : (context) => HomePage(),
      Constants.LOGIN_ROUTE : (context) => LoginPage(),
      Constants.MAP_ROUTE : (context) => MapPage(),
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

  // feedDemo() async {
  //   var url = 'https://jsonplaceholder.typicode.com/posts';
  //   var response = await http.get(url,);
  //   print('Response status: ${response.statusCode}');
  //   print('Response body: ${response.body}');
  // }
}
