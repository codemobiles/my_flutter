import 'package:flutter/material.dart';
import 'package:my_flutter/src/commons/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Stock"),
        actions: [
          IconButton(
            onPressed: () async {
              SharedPreferences.getInstance().then((pref) {
                pref.remove(Constants.PREF_TOKEN);
                //pref.clear();
              });
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, count) {
          return Card(
            child: Column(
              children: [
                Image.network(
                    "https://miro.medium.com/max/11400/1*lS9ZqdEGZrRiTcL1JUgt9w.jpeg"),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Title"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("111 บาท"),
                          Text("9 สต๊อก"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: 20,
      ),
      // context
    );
  }
}
