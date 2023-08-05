import 'package:flutter/material.dart';
import 'package:food_delivery/controller/intro_controller.dart';
import 'package:food_delivery/view/base/horizontal_wheel.dart';

class CycleLengthWidget extends StatefulWidget {
  const CycleLengthWidget({super.key});

  @override
  State<CycleLengthWidget> createState() => _CycleLengthWidgetState();
}

class _CycleLengthWidgetState extends State<CycleLengthWidget> {
  List<int> get _cycleLengths => List<int>.generate(59, (index) => index + 22);

  @override
  Widget build(BuildContext context) => HorizontalWheelWidget(
      list: _cycleLengths,
      onSelectedItemChanged: (value) {
        IntroController.to.cyclelength = value;
      });
}
