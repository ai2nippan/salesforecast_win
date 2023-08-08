import 'package:flutter/material.dart';
import 'package:salesforecast/states/authen.dart';
import 'package:salesforecast/utility/my_constant.dart';

final Map<String, WidgetBuilder> map = {
  '/authen' : (BuildContext context) => Authen(),
};

String initRoute = '/authen';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      title: MyConstant.appName,
      
      routes: map,
      initialRoute: initRoute,
    );
  }
}