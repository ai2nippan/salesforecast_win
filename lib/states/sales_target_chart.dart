import 'package:flutter/material.dart';
import 'package:salesforecast/states/sales_target_chart_bar2.dart';

class SalesTargetChart extends StatefulWidget {
  const SalesTargetChart({ Key? key }) : super(key: key);

  @override
  State<SalesTargetChart> createState() => _SalesTargetChartState();
}

class _SalesTargetChartState extends State<SalesTargetChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SalesTargetChartBar2(),
    );
  }
}