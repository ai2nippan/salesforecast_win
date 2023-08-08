import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartSection extends StatelessWidget {
  const ChartSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sheight = MediaQuery.of(context).size.height;
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        padding: EdgeInsets.only(bottom: 8.0),
        // decoration: BoxDecoration(
        //     color: Colors.grey,
        //     border: Border.all(color: Colors.redAccent, width: 2)),
        // color: Colors.grey,
        margin: EdgeInsets.all(16),
        // height: sheight * 2,
        child: BarChart(BarChartData(
            titlesData: FlTitlesData(
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: true,)),
            ),
            
            barGroups: [
              BarChartGroupData(x: 1, barRods: [
                BarChartRodData(
                  toY: 5,
                  color: Colors.red,
                  width: 3,
                  borderRadius: BorderRadius.circular(10),
                ),
                BarChartRodData(
                  toY: 4,
                  color: Colors.blue,
                  width: 3,
                  borderRadius: BorderRadius.circular(10),
                ),
              ]),
              BarChartGroupData(x: 2, barRods: [
                BarChartRodData(
                  toY: 1,
                  color: Colors.red,
                  width: 3,
                  borderRadius: BorderRadius.circular(10),
                ),
                BarChartRodData(
                  toY: 3,
                  color: Colors.blue,
                  width: 3,
                  borderRadius: BorderRadius.circular(10),
                ),
              ]),
              BarChartGroupData(x: 3, barRods: [
                BarChartRodData(
                  toY: 2,
                  color: Colors.red,
                  width: 3,
                  borderRadius: BorderRadius.circular(10),
                ),
                BarChartRodData(
                  toY: 3,
                  color: Colors.blue,
                  width: 3,
                  borderRadius: BorderRadius.circular(10),
                ),
              ]),
              BarChartGroupData(x: 4, barRods: [
                BarChartRodData(
                  toY: 5,
                  color: Colors.red,
                  width: 3,
                  borderRadius: BorderRadius.circular(10),
                ),
                BarChartRodData(
                  toY: 3,
                  color: Colors.blue,
                  width: 3,
                  borderRadius: BorderRadius.circular(10),
                ),
              ]),
              BarChartGroupData(x: 5, barRods: [
                BarChartRodData(
                  toY: 5,
                  color: Colors.red,
                  width: 3,
                  borderRadius: BorderRadius.circular(10),
                ),
                BarChartRodData(
                  toY: 3,
                  color: Colors.blue,
                  width: 3,
                  borderRadius: BorderRadius.circular(10),
                ),
              ]),
              BarChartGroupData(x: 6, barRods: [
                BarChartRodData(
                  toY: 5,
                  color: Colors.red,
                  width: 3,
                  borderRadius: BorderRadius.circular(10),
                ),
                BarChartRodData(
                  toY: 3,
                  color: Colors.blue,
                  width: 3,
                  borderRadius: BorderRadius.circular(10),
                ),
              ]),
            ])),
      ),
    );
  }
}