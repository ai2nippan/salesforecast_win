import 'package:flutter/material.dart';
import 'package:salesforecast/utility/my_constant.dart';
import 'package:salesforecast/widgets/show_image.dart';
import 'package:salesforecast/widgets/show_title.dart';

class MyDialog {
  Future<Null> normalDialog(
      BuildContext context, String title, String message) async {
    showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              title: ListTile(
                leading: ShowImage(path: MyConstant.image1),
                title:
                    ShowTitle(title: title, textStyle: MyConstant().h2Style()),
                subtitle: ShowTitle(
                    title: message, textStyle: MyConstant().h3Style()),
              ),
            ));
  }
}
