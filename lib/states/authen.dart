import 'dart:convert';
//import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:salesforecast/models/user_model.dart';
import 'package:salesforecast/states/main_menu.dart';
import 'package:salesforecast/states/system_setting.dart';
import 'package:salesforecast/utility/my_constant.dart';
import 'package:salesforecast/utility/my_dialog.dart';
import 'package:salesforecast/widgets/show_image.dart';
import 'package:salesforecast/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  bool statusRedEye = true;
  final formKey = GlobalKey<FormState>();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? ipHost, svrPort, prgPath, mac, dbSvr, dbPort, dbUser, dbPwd, dbName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      chkSetting();
    });
  }

  Future<void> chkSetting() async {
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

    if (ipHost == null ||
        ipHost!.isEmpty ||
        svrPort == null ||
        svrPort!.isEmpty ||
        prgPath == null ||
        prgPath!.isEmpty ||
        mac == null ||
        mac!.isEmpty ||
        dbSvr == null ||
        dbSvr!.isEmpty ||
        dbPort == null ||
        dbPort!.isEmpty ||
        dbUser == null ||
        dbUser!.isEmpty ||
        dbName == null ||
        dbName!.isEmpty) {
      // preferences.setString('ipHost', '');

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SystemSetting(),
          ));
    } else {
      setState(() {
        userController = TextEditingController(text: '');
        passwordController = TextEditingController(text: '');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        buildBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
              child: SingleChildScrollView(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              behavior: HitTestBehavior.opaque,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Container(
                      margin: const EdgeInsets.only(top: 40, bottom: 40),
                      // color: Colors.white54,
                      // height: 450,
                      height: MediaQuery.of(context).size.height * 0.76,

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white54),
                      child: Form(
                        key: formKey,
                        child: ListView(
                          children: [
                            const SizedBox(height: 100),
                            buildAppName(),
                            const SizedBox(height: 10),
                            buildAppVersion(),
                            buildUser(size),
                            buildPassword(size),
                            const SizedBox(height: 30),
                            buildLogin(size),
                            buildCopyright()
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
        )
      ],
    );
  }

  Row buildCopyright() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Copyright @ALL-IN-ONE SOFT on Mobile",
          style: MyConstant().h5Style(),
        ),
        // Container(
        //   child: Text("Copyright @ALL-IN-ONE SOFT",style: MyConstant().h5Style(),),
        // )
      ],
    );
  }

  Row buildLogin(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          width: size * 0.6,
          child: ElevatedButton(
            // style: MyConstant().ButtonStyle1(),
            onPressed: () {
              // print('user = ${userController.text}, password = ${passwordController.text}');
              if (formKey.currentState!.validate()) {
                String user = userController.text;
                String password = passwordController.text;
                // print('## user = $user, password = $password');
                checkAuthen(user: user, password: password);
              }
            },
            child: const Text("Login"),
          ),
        )
      ],
    );
  }

  // ---------------------------
  // Check if system setting empty value go to system setting
  // <No need because we already check in iniiState>
  // Future<Null>
  // ---------------------------

  // Check userName and Password both keep in db and keep in program

  // Future<Null> checkAuthen({String? user, String? password}) async {
  Future<void> checkAuthen({String? user, String? password}) async {
    if (userController.text == MyConstant.userKey &&
        passwordController.text == MyConstant.passwordKey) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SystemSetting(),
        ),
      ).then((value) async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String? ipHost = preferences.getString('ipHostname');
        String? svrPort = preferences.getString('serverPort');
        String? prgPath = preferences.getString('prgPath');
        String? mac = preferences.getString('machine');
        String? dbSvr = preferences.getString('dbServer');
        String? dbPort = preferences.getString('dbPort');
        String? dbUser = preferences.getString('dbUser');
        String? dbName = preferences.getString('dbName');

        if (ipHost == null ||
            ipHost.isEmpty ||
            svrPort == null ||
            svrPort.isEmpty ||
            prgPath == null ||
            prgPath.isEmpty ||
            mac == null ||
            mac.isEmpty ||
            dbSvr == null ||
            dbSvr.isEmpty ||
            dbPort == null ||
            dbPort.isEmpty ||
            dbUser == null ||
            dbUser.isEmpty ||
            dbName == null ||
            dbName.isEmpty) {
          MyDialog().normalDialog(
              context, 'ข้อมูลกรอกไม่ครบ', 'กรุณากรอกข้อมูลให้ครบถ้วน');
        } else {
          setState(() {
            userController = TextEditingController(text: '');
            passwordController = TextEditingController(text: '');
          });
        }

        // } else {}
      });
    } else {
      // ----- Change again (For Test) ---
      // String apiChkAuthen =
      //     '${MyConstant.domain}${MyConstant.prgPath}?isAdd=${MyConstant.isAdd}&dbhost=${MyConstant.dbhost}&dbuser=${MyConstant.dbuser}&dbpwd=${MyConstant.dbpwd}&dbname=${MyConstant.dbname}&user=$user';
      // ----- Change again (For Test) ---

      // ---(Start) --- Get value from setting ---
      String apiChkAuthen =
          '${MyConstant.dnsprefix}$ipHost:$svrPort/$prgPath/MB_SalesForecast_getUserWhereUser.php?isAdd=${MyConstant.isAdd}&dbhost=$dbSvr&dbuser=$dbUser&dbpwd=$dbPwd&dbname=$dbName&user=$user';
      // ---( End ) --- Get value from setting ---

      // print('apiChkAuthen ==> $apiChkAuthen');
      // print('dir=${Directory.current.toString()}');

      final Dio _dio = Dio(BaseOptions(
          contentType: 'application/json', responseType: ResponseType.json));

      //await Dio().get(apiChkAuthen).then((value) async {
      await _dio.get(apiChkAuthen).then((value) async {
        // return null;
        // print('## value for API ==> $value');
        if (value.toString().trim() == 'null') {
          // No user
          MyDialog()
              .normalDialog(context, 'ผู้ใช้ไม่ถูกต้อง', 'ไม่พบข้อมูล $user');
        } else {
          // have user
          // MyDialog().normalDialog(context, 'ผู้ใช้ถูกต้อง', 'พบข้อมูล $user');
          // var dat = json.decode(value.data);
          // print('Data : ${dat.toString().replaceAll("<br />", "")}');
          // for (var item in json.decode(json.decode(value.data))) {

          // print('value : $value');  
          // print('value1 : ${value.toString().replaceAll('<br />', '')}'); 
          // print('value2 : ${value.toString().replaceAll('<b>Fatal error</b>', '')}');

          // value.toString().replaceAll('<br />', '');

          // var value1 = value.data.toString().replaceAll('<br />', '');
          // print('value1 : ${value1.toString()}');
          // var value2 = value1.toString().replaceAll('<b>Fatal error</b>', '');
          // print('value2 : ${value2.toString()}');

          for (var item in json.decode(value.data)) {
            //for (var item in jsonDecode(value.data)) {
            

            UserModel userModel = UserModel.fromMap(item);
            if (password == userModel.SPASS) {
              // print('pwd ==> $password');
              // MyDialog()
              //     .normalDialog(context, 'รหัสผ่านถูกต้อง', 'พบข้อมูล $user');

              SharedPreferences userPref =
                  await SharedPreferences.getInstance();
              userPref.setString('sid', userModel.SID);
              userPref.setString('sname', userModel.SNAME);
              userPref.setString('mobile', userModel.MOBILE);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainMenu(),
                  ));
            } else {
              MyDialog().normalDialog(
                  context, 'รหัสผ่านไม่ถูกต้อง', 'กรุณาลองใหม่อีกครั้งคะ');
            }
          }
        }
      });
    }
  }

  ShaderMask buildBackground() {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Colors.black, Colors.black12],
        begin: Alignment.bottomCenter,
        end: Alignment.center,
      ).createShader(bounds),
      blendMode: BlendMode.darken,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(MyConstant.image1),
            fit: BoxFit.cover,
            colorFilter:
                const ColorFilter.mode(Colors.black45, BlendMode.darken),
          ),
        ),
      ),
    );
  }

  Row buildPassword(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            controller: passwordController,
            obscureText: statusRedEye,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณาใส่รหัสผ่าน';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'Password :',
              fillColor: Colors.white,
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      statusRedEye = !statusRedEye;
                    });
                  },
                  icon: statusRedEye
                      ? Icon(
                          Icons.remove_red_eye,
                          color: MyConstant.blackcolor1,
                        )
                      : Icon(
                          Icons.remove_red_eye,
                          color: MyConstant.redcolor1,
                        )),
              prefixIcon: const Icon(
                Icons.lock_outline,
                // color: MyConstant.dark,
                color: Colors.white,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Colors.white), //color: MyConstant.dark),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(30),
              ), //focusColor: ,
            ),
          ),
        )
      ],
    );
  }

  Row buildUser(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            controller: userController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณาใส่ชื่อผู้ใช้';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'User :',
              fillColor: Colors.white,
              // filled: true,
              prefixIcon: const Icon(
                Icons.account_circle_outlined,
                // color: MyConstant.dark,
                color: Colors.white,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Colors.white), //color: MyConstant.dark),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(30),
              ), //focusColor: ,
            ),
          ),
        )
      ],
    );
  }

  Row buildAppVersion() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShowTitle(
          title: MyConstant.appVersion,
          textStyle: MyConstant().h4Style(),
        )
      ],
    );
  }

  Row buildAppName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShowTitle(
          title: MyConstant.appName,
          textStyle: MyConstant().h1Style(),
        )
      ],
    );
  }

  Row buildImage(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.all(16.0),
          width: size * 0.9,
          child: ShowImage(path: MyConstant.image1),
        )
      ],
    );
  }
}
