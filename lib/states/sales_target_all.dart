import 'package:flutter/material.dart';
import 'package:salesforecast/states/sales_target_chart.dart';
import 'package:salesforecast/states/sales_target_table_for_graph_ok.dart';
import 'package:salesforecast/utility/my_constant.dart';

class SalesTargetAll extends StatefulWidget {
  const SalesTargetAll({Key? key}) : super(key: key);

  @override
  State<SalesTargetAll> createState() => _SalesTargetAllState();
}

class _SalesTargetAllState extends State<SalesTargetAll> {
  List<Widget> widgets = [SalesTargetTable(), SalesTargetChart()];
  List<String> titles = ['Table', 'Chart'];

  int indexPosition = 0;

  List<BottomNavigationBarItem> bottomNavigationBarItems = [];
  List<IconData> icons = [Icons.table_rows, Icons.insert_chart];

  @override
  void initState() {
    super.initState();

    int i = 0;
    for (var item in titles) {
      bottomNavigationBarItems
          .add(createBottomNavigationBarItem(icons[i], item));
      i++;
    }
  }

  BottomNavigationBarItem createBottomNavigationBarItem(
          IconData iconData, String string) =>
      BottomNavigationBarItem(
        icon: Icon(iconData),
        label: string,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales Target ${titles[indexPosition]}'),
      ),
      body: widgets[indexPosition],//Text('This is Sales Target ALL'),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: MyConstant.light,
        unselectedItemColor: Colors.grey,
        currentIndex: indexPosition,
        items: bottomNavigationBarItems,
        onTap: (value) {
          setState(() {
            indexPosition = value;
          });
        },
      ),
    );
  }
}
