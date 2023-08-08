import 'package:flutter/material.dart';

class MyConstant {
  // App Name & Version
  static String appName = 'Sales Data';
  static String appVersion = 'Version 1.0';

  // keyword go to system setting
  static String userKey = 'aio';
  static String passwordKey = 'aio';


  // For Test
  // Connected information
  static String domain = 'http://192.168.1.112:80';
  //static String domain = 'https://8d82-2405-9800-b820-171c-64c3-3747-7cb-c586.ngrok.io';

  // dbhost = 192.168.1.112 or localhost
  static String dnsprefix = 'http://';
  static String dbhost = 'localhost';
  static String dbuser = 'root';
  static String dbpwd  = '';
  static String dbname = 'TKC_data2016_15Feb2565';

  static String prgPath = '/Mobile/Project/Flutter/AIO/Customer/TKC/Sales/php/OnLocal/MB_SalesForecast_getUserWhereUser.php';

  static String isAdd = 'true';

  // Route screen
  static String routeAuthen = '/authen';

  // Images
  static String image1 = 'assets/images/image1.png';

  // General Color
  static Color primary = const Color(0xFE0f41e2);
  // static Color dark = const Color(0x27EC70);
  static Color dark = const Color(0xFC325ca8);
  static Color light = const Color(0xDF237fca);

  static Color blackcolor1 = Colors.black;
  static Color redcolor1 = Colors.red;

  // Color Theme
  static Color primarySwatch = Colors.blue;

  // Style

  // Font Style
  TextStyle h1Style() => TextStyle(
        fontSize: 24,
        color: dark,
        fontWeight: FontWeight.bold,
      );

  TextStyle h2Style() => TextStyle(
        fontSize: 18,
        color: dark,
        fontWeight: FontWeight.w700,
      );

  TextStyle h3Style() => TextStyle(
        fontSize: 16,
        color: dark,
        fontWeight: FontWeight.normal,
      );

  TextStyle h4Style() => const TextStyle(
        fontSize: 14,
        color: Color.fromARGB(100, 255, 0, 0),
        fontWeight: FontWeight.w900,
      );

  TextStyle h5Style() => TextStyle(
        fontSize: 10,
        color: Colors.white,
        fontWeight: FontWeight.w900,
      );

  // Button Style

  // ElevatedButton

  ButtonStyle ButtonStyle1() => ElevatedButton.styleFrom(
        primary: MyConstant.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      );

  // TextButton

  ButtonStyle buttonStyle2() => TextButton.styleFrom(
        primary: MyConstant.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      );
}
