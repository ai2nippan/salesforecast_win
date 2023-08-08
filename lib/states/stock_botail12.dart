import 'dart:convert';

import 'package:data_table_2/data_table_2.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salesforecast/models/doc_send_pending_model.dart';
import 'package:salesforecast/utility/my_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StockBOTail12 extends StatefulWidget {
  final String id;
  const StockBOTail12({Key? key, required this.id}) : super(key: key);

  @override
  State<StockBOTail12> createState() => _StockBOTail12State();
}

class _StockBOTail12State extends State<StockBOTail12> {
  String? pid;
  String? ipHost, svrPort, prgPath, mac, dbSvr, dbPort, dbUser, dbPwd, dbName;
  List<DocSendPendingModel> docSendPindings = [];
  List<String> rowIdx = [];
  bool loaddata = false;
  bool? havedat;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pid = widget.id;
    qryDocSendPending();
  }

  Future<Null> qryDocSendPending() async {
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

    String apiDocSendPending =
        '${MyConstant.dnsprefix}$ipHost:$svrPort/$prgPath';
    apiDocSendPending =
        '${apiDocSendPending}MB_SalesForecast_DocSendPending.php';
    apiDocSendPending = '${apiDocSendPending}?isAdd=${MyConstant.isAdd}';
    apiDocSendPending =
        '${apiDocSendPending}dbhost=$dbSvr&dbuser=$dbUser&dbpwd=$dbPwd&dbname=$dbName';
    apiDocSendPending = '${apiDocSendPending}&id=$pid';

    await Dio().get(apiDocSendPending).then((value) {
      if (value.toString().trim() == 'null') {
        // No data
        loaddata = false;
        havedat = false;
      } else {
        int counter = 1;
        for (var item in json.decode(value.data)) {
          DocSendPendingModel model = DocSendPendingModel.fromMap(item);

          setState(() {
            rowIdx.add(counter.toString());
            counter++;

            docSendPindings.add(model);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เอกสารค้างส่ง'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Text('รวม (จำนวน)'),
            ],
          ),
          DataTable2(
              dataRowHeight: 100,
              headingRowHeight: 30,
              headingRowColor: MaterialStateProperty.all(Colors.grey),
              columnSpacing: 12,
              horizontalMargin: 12,
              minWidth: 600,
              columns: [
                DataColumn2(label: Text('ลำดับ')),
                DataColumn2(label: Text('เอกสาร')),
                DataColumn2(label: Text('วันที่')),
                DataColumn2(label: Text('ลูกค้า')),
                DataColumn2(label: Text('จำนวน')),
                DataColumn2(label: Text('หน่วย')),
              ],
              rows: List<DataRow2>.generate(rowIdx.length, (index) {
                return DataRow2(
                    color: MaterialStateProperty.resolveWith(
                        (states) => states.contains(MaterialState.hovered)
                            ? Colors.blue
                            : index % 2 == 0
                                ? Colors.red
                                : Colors.amber),
                    cells: [
                      DataCell(Text(rowIdx[index])),
                      DataCell(Text(docSendPindings[index].DOCNO)),
                      DataCell(Text(docSendPindings[index].DATEDOC)),
                      DataCell(Text(docSendPindings[index].XCOMP)),
                      DataCell(Text(docSendPindings[index].REMAIN)),
                      DataCell(Text(docSendPindings[index].UNIT_SAL)),
                    ]);
              })),
        ],
      ),
    );
  }
}
