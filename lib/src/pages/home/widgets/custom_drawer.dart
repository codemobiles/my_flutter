import 'package:flutter/material.dart';
import 'package:my_flutter/src/commons/constants.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountEmail: Text("cm@gmail.com"),
            accountName: Text("Cat Lover"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSxJb3HRYNw61YQXFK2QWxVntb3AhB4eJw1NA&usqp=CAU",
              ),
            ),
          ),
          ListTile(
            title: Text("Google map"),
            leading: Icon(Icons.map),
            onTap: (){
              Navigator.pushNamed(context, Constants.MAP_ROUTE);
            },
          ),
        ],
      ),
    );
  }
}
