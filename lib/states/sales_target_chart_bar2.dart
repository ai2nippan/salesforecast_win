import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:salesforecast/models/sales_target_model.dart';
import 'package:salesforecast/utility/my_constant.dart';
import 'package:salesforecast/widgets/show_progress.dart';
import 'package:salesforecast/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SalesTargetChartBar2 extends StatefulWidget {
  const SalesTargetChartBar2({Key? key}) : super(key: key);

  @override
  State<SalesTargetChartBar2> createState() => _SalesTargetChartBar2State();
}

class _SalesTargetChartBar2State extends State<SalesTargetChartBar2> {
  String? ipHost, svrPort, prgPath, mac, dbSvr, dbPort, dbUser, dbPwd, dbName;
  String? sid, sname, mobile;
  bool loaddata = false;
  bool? havedat;

  List<SalesTargetModel> saleTargets = [];
  List<String> rowIdx = [];

  List<int> renderGroups = [];
  List<double> renderRods = [];

  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();
    qrySalesTarget();

    final barGroup1 = makeGroupData(0, 0, 0);

    final items = [
      barGroup1,
    ];

    rawBarGroups = items;
    showingBarGroups = rawBarGroups;
  }

  // BarChartGroupData makeGroupData(int x, double y1, double y2) {
  //   return BarChartGroupData(barsSpace: 4, x: x, barRods: [
  //     BarChartRodData(
  //       toY: y1,
  //       color: leftBarColor,
  //       width: width,
  //     ),
  //     BarChartRodData(
  //       toY: y2,
  //       color: rightBarColor,
  //       width: width,
  //     ),
  //   ]);
  // }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(toY: y1, color: leftBarColor, width: width),
      BarChartRodData(toY: y2, color: rightBarColor, width: width),
    ]);
  }

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

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  // appBar: AppBar(
  //   title: ShowTitle(
  //     title: 'This is Sales Target Chart',
  //     textStyle: MyConstant().h2Style(),
  //   ),
  // ),
  // body: ChartSection(),
  //     body: SalesTargetAllChart(),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        // color: Color(0xff2c4260),

        child: Padding(
          padding: EdgeInsets.all(16),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: BarChart(
                  BarChartData(
                    titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: true))),
                    barGroups: showingBarGroups,
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SalesTargetAllChart extends StatelessWidget {
  const SalesTargetAllChart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Sales data
class SalesAllTarget {
  final int target;
  final int actual;
  final int diff;
  final int percent;

  SalesAllTarget(this.target, this.actual, this.diff, this.percent);
}
