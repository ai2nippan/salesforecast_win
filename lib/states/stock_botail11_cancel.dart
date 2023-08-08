import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:salesforecast/models/product_remain_model.dart';
import 'package:salesforecast/utility/my_constant.dart';
import 'package:salesforecast/widgets/show_progress.dart';
import 'package:salesforecast/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StockBOTail11_Cancel extends StatefulWidget {
  final String? prdGenre;
  final String? prdType;
  const StockBOTail11_Cancel({Key? key, required this.prdGenre, required this.prdType})
      : super(key: key);

  @override
  State<StockBOTail11_Cancel> createState() => _StockBOTail11_CancelState();
}

class _StockBOTail11_CancelState extends State<StockBOTail11_Cancel> {
  String? xsgroup, xidtype;
  String? ipHost, svrPort, prgPath, mac, dbSvr, dbPort, dbUser, dbPwd, dbName;
  List<ProductRemainBOModel> prdRemBOs = [];
  List<String> nos = [];
  bool loaddata = true;
  bool? havedat;
  String? seq;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    xsgroup = widget.prdGenre;
    xidtype = widget.prdType;
    getPrdRemANDBO();
  }

  Future<Null> getPrdRemANDBO() async {
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

    print('apiPrdRemAndBO ==> $apiPrdRemAndBO');

    await Dio().get(apiPrdRemAndBO).then((value) {
      if (value.toString().trim() == 'null') {
        // No data
        loaddata = false;
        havedat = false;
      } else {
        int counter = 0;
        for (var item in json.decode(value.data)) {
          ProductRemainBOModel model = ProductRemainBOModel.fromMap(item);

          setState(() {
            loaddata = false;
            havedat = true;

            counter = counter + 1;
            seq = counter.toString();
            nos.add(seq.toString());
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
        title: Text('ยอดคงเหลือสินค้า + BO (StockBOTail11)'),
      ),
      body: loaddata
          ? ShowProgress()
          : havedat!
              ? LayoutBuilder(
                  builder: (context, constraints) => ListView.builder(
                    itemCount: prdRemBOs.length,
                    itemBuilder: (context, index) => GestureDetector(
                      child: Card(
                        child: Row(
                          children: [
                            Column(
                              children: [
                                ShowTitle(
                                  title: '${nos[index]}',
                                  textStyle: MyConstant().h4Style(),
                                ),
                              ],
                            ),Column(
                              children: [
                                ShowTitle(
                                  title: '${prdRemBOs[index].XDESC}',
                                  textStyle: MyConstant().h4Style(),
                                ),
                              ],
                            ),
                            // Container(
                            //   child: ShowTitle(
                            //     title: 'No: ${nos[index]}',
                            //     textStyle: MyConstant().h1Style(),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Text('Not Found data'),
    );
  }
}
