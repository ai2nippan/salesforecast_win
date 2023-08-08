import 'package:flutter/material.dart';
import 'package:salesforecast/utility/my_constant.dart';
import 'package:salesforecast/utility/my_dialog.dart';
import 'package:salesforecast/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SystemSetting extends StatefulWidget {
  const SystemSetting({Key? key}) : super(key: key);

  @override
  State<SystemSetting> createState() => _SystemSettingState();
}

class _SystemSettingState extends State<SystemSetting> {
  final formKey = GlobalKey<FormState>();
  TextEditingController ipHostnameController = TextEditingController();
  TextEditingController serverPortController = TextEditingController();
  TextEditingController prgPathController = TextEditingController();
  TextEditingController machineController = TextEditingController();
  TextEditingController dbserverController = TextEditingController();
  TextEditingController dbPortController = TextEditingController();
  TextEditingController dbUserController = TextEditingController();
  TextEditingController dbPwdController = TextEditingController();
  TextEditingController dbNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      checkSharedPref();
    });
  }

  Future<void> checkSharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? ipHost = preferences.getString('ipHostname');
    String? svrPort = preferences.getString('serverPort');
    String? prgPath = preferences.getString('prgPath');
    String? mac = preferences.getString('machine');
    String? dbSvr = preferences.getString('dbServer');
    String? dbPort = preferences.getString('dbPort');
    String? dbUser = preferences.getString('dbUser');
    String? dbPwd = preferences.getString('dbPwd');
    String? dbName = preferences.getString('dbName');

    setState(() {
      ipHostnameController = TextEditingController(text: ipHost);
      serverPortController = TextEditingController(text: svrPort);
      prgPathController = TextEditingController(text: prgPath);
      machineController = TextEditingController(text: mac);
      dbserverController = TextEditingController(text: dbSvr);
      dbPortController = TextEditingController(text: dbPort);
      dbUserController = TextEditingController(text: dbUser);
      dbPwdController = TextEditingController(text: dbPwd);
      dbNameController = TextEditingController(text: dbName);
    });
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: SafeArea(
          child: Form(
        key: formKey,
        child: ListView(
          children: [
            buildServer(size),
            const SizedBox(height: 5),
            buildIPHostname(size),
            const SizedBox(height: 5),
            buildServerPort(size),
            const SizedBox(height: 5),
            buildPrgPath(size),
            const SizedBox(height: 5),
            buildMachine(size),
            const SizedBox(height: 5),
            buildDatabase(size),
            const SizedBox(height: 5),
            buildDBServer(size),
            const SizedBox(height: 5),
            buildDBPort(size),
            const SizedBox(height: 5),
            buildDBUser(size),
            const SizedBox(height: 5),
            buildDBPwd(size),
            const SizedBox(height: 5),
            buildDBName(size),
            const SizedBox(height: 5),
            buildButtonGroup(size, context),
          ],
        ),
      )),
    );
  }

  Row buildButtonGroup(double size, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 5),
        Container(
          width: size * 0.4,
          child: ElevatedButton(
            onPressed: () async {
              if (ipHostnameController.text.isNotEmpty ||
                  serverPortController.text.isNotEmpty ||
                  prgPathController.text.isNotEmpty ||
                  machineController.text.isNotEmpty ||
                  dbserverController.text.isNotEmpty ||
                  dbPortController.text.isNotEmpty ||
                  dbUserController.text.isNotEmpty ||
                  dbNameController.text.isNotEmpty) {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.setString('ipHostname', ipHostnameController.text);
                preferences.setString('serverPort', serverPortController.text);
                preferences.setString('prgPath', prgPathController.text);
                preferences.setString('machine', machineController.text);
                preferences.setString('dbServer', dbserverController.text);
                preferences.setString('dbPort', dbPortController.text);
                preferences.setString('dbUser', dbUserController.text);
                preferences.setString('dbPwd', dbPwdController.text);
                preferences.setString('dbName', dbNameController.text);

                Navigator.pop(context);
              } else {
                MyDialog().normalDialog(
                    context, 'ข้อมูลกรอกไม่ครบ', 'กรุณากรอกข้อมูลให้ครบถ้วน');
              }
            },
            child: const Text('บันทึก'),
          ),
        ),
        const SizedBox(width: 40),
        Container(
          width: size * 0.4,
          child: ElevatedButton(
            onPressed: () {
              ipHostnameController.text = '';
              serverPortController.text = '';
              prgPathController.text = '';
              dbserverController.text = '';
              dbPortController.text = '';
              dbUserController.text = '';
              dbPwdController.text = '';
              dbNameController.text = '';
            },
            child: const Text('ตั้งค่าใหม่หมด'),
          ),
        ),
        const SizedBox(width: 6),
      ],
    );
  }

  Row buildServer(size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size,
          decoration: const BoxDecoration(color: Colors.green),
          child: Center(
            child: ShowTitle(
              title: 'Server',
              textStyle: MyConstant().h1Style(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildDatabase(size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size,
          decoration: const BoxDecoration(color: Colors.green),
          child: Center(
            child: ShowTitle(
              title: 'Database',
              textStyle: MyConstant().h1Style(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildIPHostname(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.9,
          child: TextFormField(
            controller: ipHostnameController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณาใส่ IP / Host name';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'IP/Host Name:',
              prefixIcon: Icon(
                Icons.dns,
                color: MyConstant.dark,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        )
      ],
    );
  }

  Row buildServerPort(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.9,
          child: TextFormField(
            controller: serverPortController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณาใส่ Server Port';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'Server Port:',
              prefixIcon: Icon(
                Icons.route,
                color: MyConstant.dark,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        )
      ],
    );
  }

  Row buildPrgPath(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.9,
          child: TextFormField(
            controller: prgPathController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณาใส่ Program Path';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'Program Path:',
              prefixIcon: Icon(
                Icons.local_parking,
                color: MyConstant.dark,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        )
      ],
    );
  }

  Row buildMachine(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.9,
          child: TextFormField(
            controller: machineController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณาใส่ ชื่อเครื่อง';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'Machine:',
              prefixIcon: Icon(
                Icons.phone_android,
                color: MyConstant.dark,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        )
      ],
    );
  }

  Row buildDBServer(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.9,
          child: TextFormField(
            controller: dbserverController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณาใส่ DB Server';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'DB Server:',
              prefixIcon: Icon(
                Icons.dns,
                color: MyConstant.dark,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        )
      ],
    );
  }

  Row buildDBPort(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.9,
          child: TextFormField(
            controller: dbPortController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณาใส่ DB Port';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'DB Port:',
              prefixIcon: Icon(
                Icons.route,
                color: MyConstant.dark,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        )
      ],
    );
  }

  Row buildDBUser(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.9,
          child: TextFormField(
            controller: dbUserController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณาใส่ DB User';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'DB User:',
              prefixIcon: Icon(
                Icons.group,
                color: MyConstant.dark,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        )
      ],
    );
  }

  Row buildDBPwd(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.9,
          child: TextFormField(
            obscureText: true,
            controller: dbPwdController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณาใส่ DB Password';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'DB Password:',
              prefixIcon: Icon(
                Icons.lock,
                color: MyConstant.dark,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        )
      ],
    );
  }

  Row buildDBName(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.9,
          child: TextFormField(
            controller: dbNameController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณาใส่ DB Name';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'DB Name:',
              prefixIcon: Icon(
                Icons.format_list_bulleted,
                color: MyConstant.dark,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        )
      ],
    );
  }
}
