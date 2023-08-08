import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
// import 'package:data_table_2/data_table_2.dart';

class ExDataTable2 extends StatelessWidget {
  ExDataTable2({Key? key}) : super(key: key);

  // List<String> keyCell = ['1','2','3'];
  LocalKey? keyIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Data Table in Flutter'),
        ),
        body: Column(
          children: [
            DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                minWidth: 600,
                columns: [
                  DataColumn2(label: Text('Name')),
                  DataColumn2(label: Text('Father Name')),
                  DataColumn2(label: Text('City')),
                  DataColumn2(label: Text('Contact')),
                  DataColumn2(label: Text('Country')),
                ],
                rows: <DataRow2>[
                  DataRow2(
                    onTap: () {
                    print('object');
                  }, cells: <DataCell>[
                    DataCell(Text('AAA')),
                    DataCell(Text('BBB')),
                    DataCell(Text('CCC')),
                    DataCell(Text('DDD')),
                    DataCell(Text('EEE')),
                  ])
                ])
          ],
        ));
  }
}
