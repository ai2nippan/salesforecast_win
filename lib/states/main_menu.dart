import 'package:flutter/material.dart';
import 'package:salesforecast/states/sales_target_table.dart';
// import 'package:salesforecast/states/ex_datatable2.dart';
// import 'package:salesforecast/states/ex_dropdown.dart';
// import 'package:salesforecast/states/sales_target_all.dart';
// import 'package:salesforecast/states/sales_target_list.dart';
//import 'package:salesforecast/states/sales_target_table_only_ok.dart';
import 'package:salesforecast/states/stock_bohead.dart';
import 'package:salesforecast/states/system_setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Menu'),
      ),
      body: SafeArea(
          child: ListView(
        children: [
          buildSalesTarget(sheight, size),
          buildStockBackOrder(sheight, size),
          buildFinancialLimit(sheight, size),
          buildSerialMovement(sheight, size),
          buildSystemSetting(sheight, size),
        ],
      )),
    );
  }

  Row buildSalesTarget(double sheight, double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          height: sheight / 8,
          width: size * 0.8,
          child: ElevatedButton(
            onPressed: () async{
              String? sid,sname;

              SharedPreferences preferences = await SharedPreferences.getInstance();
              sid = preferences.getString('sid');
              sname = preferences.getString('sname');
              // Navigator.push(context, MaterialPageRoute(builder: (context) => SalesTargetList(),)); // Work_1
              //Navigator.push(context, MaterialPageRoute(builder: (context) => SalesTargetTable(sid: sid!, sname: sname!),)); // Work_2
              //Navigator.push(context, MaterialPageRoute(builder: (context) => SalesTargetAll(),)); // Work_3 for graph
              Navigator.push(context, MaterialPageRoute(builder: (context) => SalesTargetTable(sid: sid!, sname: sname!),)); 
            },
            child: Text('แสดงเป้า'),
          ),
        ),
      ],
    );
  }

  Row buildStockBackOrder(double sheight, double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          height: sheight / 8,
          width: size * 0.8,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StockBOHead(),//ExDataTable2(),//DropDown(),
                ),
              );
            },
            child: Text('ยอด Stock/BO'),
          ),
        ),
      ],
    );
  }

  Row buildFinancialLimit(double sheight, double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          height: sheight / 8,
          width: size * 0.8,
          child: ElevatedButton(
            onPressed: () {},
            child: Text('ยอดวงเงิน'),
          ),
        ),
      ],
    );
  }

  Row buildSerialMovement(double sheight, double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          height: sheight / 8,
          width: size * 0.8,
          child: ElevatedButton(
            onPressed: () {},
            child: Text('เคลื่อนไหว Serial'),
          ),
        ),
      ],
    );
  }

  Row buildSystemSetting(double sheight, double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          height: sheight / 8,
          width: size * 0.8,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SystemSetting(),
                ),
              );
            },
            child: Text('ตั้งค่า'),
          ),
        ),
      ],
    );
  }
}
