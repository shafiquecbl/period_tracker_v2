import 'package:flutter/material.dart';
import 'package:food_delivery/controller/theme_controller.dart';
import 'package:get/get.dart';

class CustomDivider extends StatelessWidget {
  final double padding;
  final double thickness;
  const CustomDivider({this.padding = 5, this.thickness = 1, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: GetBuilder<ThemeController>(builder: (con) {
        return Divider(
            height: 0,
            thickness: thickness,
            color: con.darkTheme ? Colors.grey[800] : Colors.grey[300]!);
      }),
    );
  }
}
