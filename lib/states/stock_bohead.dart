// ignore: file_names
import 'dart:convert';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:salesforecast/models/genre_model.dart';
import 'package:salesforecast/models/type_model.dart';
import 'package:salesforecast/states/stock_botail11.dart';
import 'package:salesforecast/utility/my_constant.dart';
import 'package:salesforecast/widgets/show_progress.dart';
import 'package:salesforecast/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StockBOHead extends StatefulWidget {
  const StockBOHead({Key? key}) : super(key: key);

  @override
  State<StockBOHead> createState() => _StockBOHeadState();
}

class _StockBOHeadState extends State<StockBOHead> {
  final formKey = GlobalKey<FormState>();
  // Product Genre
  final List<ProductGenreModel> prdGenres = [];
  // final List<String> strPrdGenres = ['x1', 'x2', 'x3'];
  final List<String> strPrdGenres = [];

  // Product Type
  final List<ProductTypeModel> prdtypes = [];
  final List<String> strPrdTypes = [];

  // Product Genre (ประเภทสินค้า)
  final productGenreDropdownCtrl = TextEditingController(),
      productGenreFormDropdownCtrl = TextEditingController(),
      productGenreSearchDropdownCtrl = TextEditingController();

  // Product Type (ชนิดสินค้า)
  final productTypeDropdownCtrl = TextEditingController(),
      productTypeFormDropdownCtrl = TextEditingController(),
      productTypeSearchDropdownCtrl = TextEditingController();

  String? ipHost, svrPort, prgPath, mac, dbSvr, dbPort, dbUser, dbPwd, dbName;
  bool loadPrdGenre = true;
  bool loadPrdType = true;
  bool? havePrdGenre;
  bool? havePrdType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadProductGenre();
    loadProductType();
  }

  @override
  void dispose() {
    // Product Genre
    productGenreDropdownCtrl.dispose();
    productGenreFormDropdownCtrl.dispose();
    productGenreSearchDropdownCtrl.dispose();

    // Product Type
    productTypeDropdownCtrl.dispose();
    productTypeFormDropdownCtrl.dispose();
    productTypeSearchDropdownCtrl.dispose();

    super.dispose();
  }

  // Future<void> getSystemSetting() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   // setState(() {
  //   ipHost = preferences.getString('ipHostname');
  //   svrPort = preferences.getString('serverPort');
  //   prgPath = preferences.getString('prgPath');
  //   mac = preferences.getString('machine');
  //   dbSvr = preferences.getString('dbServer');
  //   dbPort = preferences.getString('dbPort');
  //   dbUser = preferences.getString('dbUser');
  //   dbPwd = preferences.getString('dbPwd');
  //   dbName = preferences.getString('dbName');
  //   // });

  //   print("ipHost1 ==> $ipHost");
  // }

  Future<void> loadProductGenre() async {
    // getSystemSetting();

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

    // print("ipHost2 ==> $ipHost");

    String apiLoadProductGenre =
        '${MyConstant.dnsprefix}$ipHost:$svrPort/$prgPath/MB_SalesForecast_LoadProductGenre.php?isAdd=${MyConstant.isAdd}&dbhost=$dbSvr&dbuser=$dbUser&dbpwd=$dbPwd&dbname=$dbName';

    print('apiGenre ==> $apiLoadProductGenre');

    await Dio().get(apiLoadProductGenre).then((value) {
      //return null;
      if (value.toString().trim() == 'null') {
        setState(() {
          havePrdGenre = false;
          loadPrdGenre = false;
        });
      } else {
        String? prdGenreAll;
        for (var item in json.decode(value.data)) {
          ProductGenreModel productGenreModel = ProductGenreModel.fromMap(item);

          setState(() {
            loadPrdGenre = false;
            havePrdGenre = true;

            // prdGenres.add(prdgenre);
            // strPrdGenres.add(productGenreModel.IVGID);

//             const string = 'Hello world!';
// final splitted = string.split(' ');
// print(splitted); // [Hello, world!];    

            prdGenreAll = productGenreModel.IVGID;
            prdGenreAll = '${prdGenreAll} ${productGenreModel.IVGDESC}';
            strPrdGenres.add(prdGenreAll!);
          });
        }
      }
    });
  }

  Future<void> loadProductType() async {
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

    String apiLoadProductType =
        '${MyConstant.dnsprefix}$ipHost:$svrPort/$prgPath/MB_SalesForecast_LoadProductType.php?isAdd=${MyConstant.isAdd}&dbhost=$dbSvr&dbuser=$dbUser&dbpwd=$dbPwd&dbname=$dbName';

    await Dio().get(apiLoadProductType).then((value) {
      if (value.toString().trim() == 'null') {
        setState(() {
          havePrdType = false;
          loadPrdType = false;
        });
      } else {
        String? prdTypeAll;
        for (var item in json.decode(value.data)) {
          ProductTypeModel productTypeModel = ProductTypeModel.fromMap(item);

          setState(() {
            loadPrdType = false;
            havePrdType = true;

            //strPrdTypes.add(productTypeModel.IDTID);
            prdTypeAll = productTypeModel.IDTID;
            prdTypeAll = '${prdTypeAll} ${productTypeModel.IDTDESC}';
            strPrdTypes.add(prdTypeAll!);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;
    // double size1 = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        // systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
        //   statusBarColor: Colors.white,
        // ), //backgroundColor: Colors.white,
        title: Text('Stock Back Order'),
      ),
      body: SafeArea(
        child: Container(
          // color: Colors.yellow,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const SizedBox(height: 8),
              buildProductGenreName(),
              const SizedBox(height: 8),
              strPrdGenres.length == 0
                  ? ShowProgress()
                  : buildProductGenreDropdown(),
              const SizedBox(height: 8),
              buildProductTypeName(),
              const SizedBox(height: 8),
              strPrdTypes.length == 0
                  ? ShowProgress()
                  : buildProductTypeDropdown(),
              const SizedBox(height: 30),
              const Divider(height: 0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      
                      // const string = 'Hello world!';
                      // final splitted = string.split(' ');
                      // print(splitted); // [Hello, world!];   
                      String? prdgenrebefsplit = productGenreSearchDropdownCtrl.text; 
                      final prdgenresplit = prdgenrebefsplit.split(' ');
                      // print('prdgenresplit[0] ==> ${prdgenresplit[0]}, prdgenresplit[1] ==> ${prdgenresplit[1]}');

                      String? prdtypebefsplit = productTypeSearchDropdownCtrl.text;
                      final prdtypesplit = prdtypebefsplit.split(' ');
                      // print('prdtypesplit[0] ==> ${prdtypesplit[0]}, prdtypesplit[1] ==> ${prdtypesplit[1]}');

                      
                      // print(
                      //     'prdGenreSearch ==> ${productGenreSearchDropdownCtrl.text}');

                      // print(
                      //     'prdTypeSearch ==> ${productTypeSearchDropdownCtrl.text}');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StockBOTail11(
                              // prdGenre: productGenreSearchDropdownCtrl.text,
                              // prdType: productTypeSearchDropdownCtrl.text,
                              prdGenre: prdgenresplit[0],
                              prdType: prdtypesplit[0],
                            ),
                          ));
                    },
                    child: Text('แสดง')),
              ),

              //   CustomDropdown(
              //   hintText: 'เลือกประเภทสินค้า',
              //   items: strPrdGenres,
              //   controller: productGenreSearchDropdownCtrl,
              //   excludeSelected: false,
              // ),

              // CustomDropdown.search(
              //   hintText: 'เลือกประเภทสินค้า',
              //   items: strPrdGenres,
              //   controller: productGenreSearchDropdownCtrl,
              // ),
            ],
          ),
        ),
      ),

      // SafeArea(
      //     child: Column(
      //   children: [
      //     Container(
      //       margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      //       width: size.width ,
      //       height: size.height/2  ,
      //       color: Colors.yellow,
      //       child: ListView(
      //         padding: const EdgeInsets.all(16),
      //         children: [
      //           buildProductGenreName(),
      //           buildProductGenreDropdown(),
      //           // Form(
      //           //   key: formKey,
      //           //   child: Column(
      //           //     children: [Text('ประเภทสินค้า')],
      //           //   ),
      //           // ),
      //         ],
      //       ),
      //     )
      //   ],
      // )),
    );
  }

  CustomDropdown buildProductTypeDropdown() {
    return CustomDropdown.search(
      hintText: 'เลือกชนิดสินค้า',
      items: strPrdTypes,
      controller: productTypeSearchDropdownCtrl,
    );
  }

  CustomDropdown buildProductGenreDropdown() {
    return CustomDropdown.search(
      hintText: 'เลือกประเภทสินค้า',
      items: strPrdGenres,
      controller: productGenreSearchDropdownCtrl,
      excludeSelected: false,
    );
  }

  Row buildProductGenreName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ShowTitle(
          title: 'ประเภทสินค้า',
          textStyle: MyConstant().h1Style(),
        ),
        // Text(
        //   'ประเภทสินค้า',
        // )
      ],
    );
  }

  Row buildProductTypeName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ShowTitle(
          title: 'ชนิดสินค้า',
          textStyle: MyConstant().h1Style(),
        ),
      ],
    );
  }
}
