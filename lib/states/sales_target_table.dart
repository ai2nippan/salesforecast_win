import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:salesforecast/utility/my_constant.dart';
import 'package:salesforecast/widgets/show_title.dart';

class SalesTargetTable extends StatefulWidget {
  const SalesTargetTable({ Key? key }) : super(key: key);

  @override
  State<SalesTargetTable> createState() => _SalesTargetTableState();
}

class _SalesTargetTableState extends State<SalesTargetTable> {

  List<String> rowIdx = [];
  List<String> months = [];
  String? sid, sname;
  String? ipHost, svrPort, prgPath, mac, dbSvr, dbPort, dbUser, dbPwd, dbName;
  bool loaddata = false;
  bool? havedat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('เป้าหมายแบบตาราง'),),body: SingleChildScrollView(
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
      ),,
    );
  }
}