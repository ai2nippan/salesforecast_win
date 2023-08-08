import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:salesforecast/models/user_model.dart';
import 'package:salesforecast/states/sales_target_table_for_graph_ok.dart';
import 'package:salesforecast/utility/my_constant.dart';
import 'package:salesforecast/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SalesTargetList extends StatefulWidget {
  const SalesTargetList({Key? key}) : super(key: key);

  @override
  State<SalesTargetList> createState() => _SalesTargetListState();
}

class _SalesTargetListState extends State<SalesTargetList> {
  
  List<UserModel> userModels = [];
  String? ipHost, svrPort, prgPath, mac, dbSvr, dbPort, dbUser, dbPwd, dbName;
  bool loaddata = false;
  bool? havedat;

  @override
  void initState() {
    super.initState();
    qrySalesList();
  }

  Future<Null> qrySalesList() async {
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

    String apiSalesList = '${MyConstant.dnsprefix}$ipHost:$svrPort/$prgPath';
    apiSalesList = '${apiSalesList}MB_SalesForecast_LoadSalesList.php';
    apiSalesList = '${apiSalesList}?isAdd=${MyConstant.isAdd}';
    apiSalesList =
        '${apiSalesList}&dbhost=$dbSvr&dbuser=$dbUser&dbpwd=$dbPwd&dbname=$dbName';

    print('apiSalesList ==> $apiSalesList');

    await Dio().get(apiSalesList).then((value) {
      if (value.toString().trim() == 'null') {
        // No data
        loaddata = false;
        havedat = false;
      } else {
        for (var item in json.decode(value.data)) {
          UserModel model = UserModel.fromMap(item);

          setState(() {
            loaddata = false;
            havedat = true;

            userModels.add(model);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sw = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('รายชื่อพนักงานขาย'),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => ListView.builder(
            itemCount: userModels.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                print('SID ==> ${userModels[index].SID}');
                //Navigator.push(context, MaterialPageRoute(builder: (context) => SalesTargetTable(sid: userModels[index].SID,sname: userModels[index].SNAME,),));

              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Row(
                    children: [
                      Container(
                        width: sw * 0.5,
                        child: ShowTitle(
                            title: userModels[index].SNAME,
                            textStyle: MyConstant().h2Style()),
                      ),
                      Container(
                        width: sw * 0.3,
                        child: ShowTitle(
                            title: userModels[index].MOBILE, textStyle: MyConstant().h2Style()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
