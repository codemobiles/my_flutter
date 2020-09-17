import 'package:flutter/material.dart';
import 'package:my_flutter/src/commons/constants.dart';
import 'package:my_flutter/src/models/product_response.dart';
import 'package:my_flutter/src/pages/home/widgets/custom_drawer.dart';
import 'package:my_flutter/src/pages/home/widgets/stock.dart';
import 'package:my_flutter/src/services/network_service.dart';
import 'package:my_flutter/src/viewmodels/tab_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  final List<TabModel> tabViewModel = TabViewModel().getTabItem();

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = tabViewModel.map((tab) => tab.widget).toList();

    return DefaultTabController(
      length: tabViewModel.length,
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: _buildAppBar(context),
        body: TabBarView(
          children: widgets,
        ),
        // context
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    List<Tab> tabs = tabViewModel.map((tab) => tab.tab).toList();
    return AppBar(
      title: Text("My Stock"),
      bottom: TabBar(
        tabs: tabs,
      ),
      actions: [
        IconButton(
          onPressed: () async {
            SharedPreferences.getInstance().then((pref) {
              pref.remove(Constants.PREF_TOKEN);
              //pref.clear();

              Navigator.pushNamedAndRemoveUntil(
                  context,
                  Constants.LOGIN_ROUTE,
                  (
                    Route<dynamic> route,
                  ) =>
                      false);
            });
          },
          icon: Icon(Icons.exit_to_app),
        ),
      ],
    );
  }
}
