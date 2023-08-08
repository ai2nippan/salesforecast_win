import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:salesforecast/models/sales_target_model.dart';
import 'package:salesforecast/utility/my_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SalesTargetChartStackBar extends StatefulWidget {
  const SalesTargetChartStackBar({Key? key}) : super(key: key);

  @override
  State<SalesTargetChartStackBar> createState() =>
      _SalesTargetChartStackBarState();
}

class _SalesTargetChartStackBarState extends State<SalesTargetChartStackBar> {
  String? ipHost, svrPort, prgPath, mac, dbSvr, dbPort, dbUser, dbPwd, dbName;
  String? sid, sname, mobile;
  bool loaddata = false;
  bool? havedat;

  List<SalesTargetModel> saleTargets = [];
  List<String> rowIdx = [];

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 22,
    List<int> showTooltips = const [],
  }) {return BarChartRodData(toY: isTouched ? y + 1 : y,);}

  Future<void> qrySalesTarget() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    ipHost = preferences.getString('ipHostname');
    svrPort = preferences.getString('serverPort');
    prgPath = preferences.getString('prgPath');
    mac = preferences.getString('machine');
    dbSvr = preferences.getString('dbServer');
    dbPort = preferences.getString('dbPort');
    dbUser = preferences.getString('dbUser');
    dbPwd = preferences.getString('dbPwd');
    dbName = preferences.getString('dbName');

    sid = preferences.getString('sid');
    sname = preferences.getString('sname');

    String apiSalesTarget = '${MyConstant.dnsprefix}$ipHost:$svrPort/$prgPath';
    apiSalesTarget = '${apiSalesTarget}MB_SalesForecast_SalesTarget.php';
    apiSalesTarget = '${apiSalesTarget}?isAdd=${MyConstant.isAdd}';
    apiSalesTarget =
        '${apiSalesTarget}&dbhost=$dbSvr&dbuser=$dbUser&dbpwd=$dbPwd&dbname=$dbName';
    apiSalesTarget = '${apiSalesTarget}&sid=$sid';

    print('apiSalesTarget ==> ${apiSalesTarget}');

    await Dio().get(apiSalesTarget).then((value) {
      if (value.toString().trim() == 'null') {
        // No data
        loaddata = false;
        havedat = false;
      } else {
        int counter = 1;
        String salesmonth;
        for (var item in json.decode(value.data)) {
          SalesTargetModel model = SalesTargetModel.fromMap(item);

          setState(() {
            loaddata = false;
            havedat = true;

            rowIdx.add(counter.toString());

            showingBarGroups.add(makeGroupData(counter,
                double.parse(model.TARGET), double.parse(model.ACTUAL)));

            // showingBarGroups.add(makeGroupData(counter, 10, 20));

            counter++;

            // switch (model.MONTH) {
            //   case 'Jan':
            //     break;
            //   default:
            // }

            saleTargets.add(model);
            // months.add(model.MONTH);
          });
        }
        // print('rowIdx ==> ${rowIdx}');
        // print('salesTarget ==> ${saleTargets}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
