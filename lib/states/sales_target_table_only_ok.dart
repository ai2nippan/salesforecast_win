import 'dart:convert';

import 'package:data_table_2/data_table_2.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:salesforecast/models/sales_target_model.dart';
import 'package:salesforecast/utility/my_constant.dart';
import 'package:salesforecast/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SalesTargetTableOnlyOK extends StatefulWidget {
  final String sid;
  final String sname;
  const SalesTargetTableOnlyOK({Key? key, required this.sid, required this.sname})
      : super(key: key);

  @override
  State<SalesTargetTableOnlyOK> createState() => _SalesTargetTableOnlyOKState();
}

class _SalesTargetTableOnlyOKState extends State<SalesTargetTableOnlyOK> {
  List<SalesTargetModel> saleTargets = [];
  List<String> rowIdx = [];
  List<String> months = [];
  String? sid, sname;
  String? ipHost, svrPort, prgPath, mac, dbSvr, dbPort, dbUser, dbPwd, dbName;
  bool loaddata = false;
  bool? havedat;

  

  @override
  void initState() {
    super.initState();
    sid = widget.sid;
    sname = widget.sname;
    qrySalesTarget();
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
        for (var item in json.decode(value.data)) {
          SalesTargetModel model = SalesTargetModel.fromMap(item);

          setState(() {
            loaddata = false;
            havedat = true;

            rowIdx.add(counter.toString());
            counter++;
            saleTargets.add(model);
            months.add(model.MONTH);
          });
        }
        // print('rowIdx ==> ${rowIdx}');
        // print('salesTarget ==> ${saleTargets}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เป้าหมายแบบตาราง'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ShowTitle(
              title: 'รหัส : $sname',
              textStyle: MyConstant().h2Style(),
            ),
            ShowTitle(
              title: 'ชื่อ : $sname',
              textStyle: MyConstant().h2Style(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DataTable2(
                  dataRowHeight: 100,
                  headingRowHeight: 30,
                  headingRowColor: MaterialStateProperty.all(Colors.green[200]),
                  columnSpacing: 12,
                  horizontalMargin: 12,
                  minWidth: 600,
                  columns: [
                    DataColumn2(label: Text('เดือน')),
                    DataColumn2(label: Text('เป้า')),
                    DataColumn2(label: Text('ACTUAL')),
                    DataColumn2(label: Text('DIFF')),
                    DataColumn2(label: Text('%')),
                  ],
                  rows: List<DataRow2>.generate(
                      saleTargets.length,
                      (index) => DataRow2(cells: [
                            DataCell(Text(saleTargets[index].MONTH)),
                            DataCell(Text(saleTargets[index].TARGET)),
                            DataCell(Text(saleTargets[index].ACTUAL)),
                            DataCell(Text(
                                '${double.parse(saleTargets[index].TARGET) - double.parse(saleTargets[index].ACTUAL)}')),
                            DataCell(Text(
                                '${(double.parse(saleTargets[index].TARGET) - double.parse(saleTargets[index].ACTUAL)) / (double.parse(saleTargets[index].TARGET)) * 100} ')),
                          ]))),
            )
          ],
        ),
      ),
      
    );
  }
}
