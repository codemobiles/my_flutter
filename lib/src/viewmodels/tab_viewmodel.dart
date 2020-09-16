
import 'package:flutter/material.dart';
import 'package:my_flutter/src/pages/home/home_page.dart';
import 'package:my_flutter/src/pages/home/widgets/stock.dart';

class TabModel {
 final Tab tab;
 final Widget widget;

  TabModel(this.tab, this.widget);
}

class TabViewModel {
  List<TabModel> getTabItem(){
    return [
      TabModel(
        Tab(
          icon: Icon(Icons.store),
          child: Text("STOCK"),
        ),
        Stock(),
      ),
      TabModel(
        Tab(
          icon: Icon(Icons.create),
          child: Text("CREATE"),
        ),
        Text("Create"),
      ),
    ].toList();
  }
}
