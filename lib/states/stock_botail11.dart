import 'dart:convert';

import 'package:data_table_2/data_table_2.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:salesforecast/models/product_remain_model.dart';
import 'package:salesforecast/states/stock_botail12.dart';
import 'package:salesforecast/utility/my_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StockBOTail11 extends StatefulWidget {
  final String? prdGenre;
  final String? prdType;
  const StockBOTail11({Key? key, required this.prdGenre, required this.prdType})
      : super(key: key);

  @override
  State<StockBOTail11> createState() => _StockBOTail11State();
}

class _StockBOTail11State extends State<StockBOTail11> {
  String? xsgroup, xidtype;
  String? ipHost, svrPort, prgPath, mac, dbSvr, dbPort, dbUser, dbPwd, dbName;
  List<ProductRemainBOModel> prdRemBOs = [];
  List<String> rowIndexes = [];
  bool loaddata = false;
  bool? havedat;
  // String? seq;

  @override
  void initState() {
    super.initState();
    xsgroup = widget.prdGenre;
    xidtype = widget.prdType;
    QryPrdRemBO();
  }

  Future<void> QryPrdRemBO() async {
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

    String apiPrdRemAndBO = '${MyConstant.dnsprefix}$ipHost:$svrPort/$prgPath';
    apiPrdRemAndBO =
        '${apiPrdRemAndBO}MB_SalesForecast_BackOrder_PrdRemain.php';
    apiPrdRemAndBO = '${apiPrdRemAndBO}?isAdd=${MyConstant.isAdd}';
    apiPrdRemAndBO =
        '${apiPrdRemAndBO}&dbhost=$dbSvr&dbuser=$dbUser&dbpwd=$dbPwd&dbname=$dbName';
    apiPrdRemAndBO = '${apiPrdRemAndBO}&prdgenre=$xsgroup&prdtype=$xidtype';

    // print('apiPrdRemAndBO ==> $apiPrdRemAndBO');

    await Dio().get(apiPrdRemAndBO).then((value) {
      if (value.toString().trim() == 'null') {
        // No data
        loaddata = false;
        havedat = false;
      } else {
        int counter = 1;
        for (var item in json.decode(value.data)) {
          ProductRemainBOModel model = ProductRemainBOModel.fromMap(item);

          setState(() {
            loaddata = false;
            havedat = true;

            // seq = counter.toString();
            // rowIndexes.add(seq.toString());
            rowIndexes.add(counter.toString());
            counter++;

            prdRemBOs.add(model);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ยอดคงเหลือสินค้า และ BO'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Text('data1'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DataTable2(
                  dataRowHeight: 100,
                  headingRowHeight: 30,
                  headingRowColor: MaterialStateProperty.all(Colors.grey),
                  columnSpacing: 12,
                  horizontalMargin: 12,
                  minWidth: 600,
                  columns: const [
                    DataColumn2(
                      label: Text('No.'),
                      size: ColumnSize.S,
                    ),
                    DataColumn2(
                      label: Text('รหัส'),
                      size: ColumnSize.M,
                    ),
                    DataColumn2(
                      label: Text('รายละเอียด'),
                      size: ColumnSize.L,
                    ),
                    DataColumn(label: Text('จำนวนคงเหลือ')),
                    DataColumn2(label: Text('B/O')),
                    DataColumn2(label: Text('หน่วย')),
                  ],
                  rows: List<DataRow2>.generate(
                    rowIndexes.length,
                    (index) {
                      return DataRow2(
                          color: index % 2 == 0
                              ? MaterialStateProperty.all(Colors.amber)
                              : MaterialStateProperty.all(Colors.white),
                          // specificRowHeight: 60,
                          onTap: () {
                            print(
                                'ID ==> ${prdRemBOs[index].ID}, XSGROUP ==> ${prdRemBOs[index].XSGROUP}, XIDTYPE ==> ${prdRemBOs[index].XIDTYPE}');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      StockBOTail12(id: prdRemBOs[index].ID),
                                ));
                          },
                          cells: [
                            // DataCell(Text(index.toString())), // For test
                            DataCell(Text(rowIndexes[index])),
                            DataCell(Text(prdRemBOs[index].ID)),
                            DataCell(Text(prdRemBOs[index].XDESC)),
                            DataCell(Text(prdRemBOs[index].NBAL)),
                            DataCell(Text(prdRemBOs[index].BACKORDER)),
                            DataCell(Text(prdRemBOs[index].UNIT)),
                          ]);
                    },
                  )),
            ), //Text("data2"),
          ],
        ),
      ),
    );
  }
}
