import 'package:flutter/material.dart';
import 'package:food_delivery/controller/intro_controller.dart';
import 'package:food_delivery/view/base/horizontal_wheel.dart';

class PeriodLengthWidget extends StatefulWidget {
  const PeriodLengthWidget({Key? key}) : super(key: key);

  @override
  State<PeriodLengthWidget> createState() => _PeriodLengthWidgetState();
}

class _PeriodLengthWidgetState extends State<PeriodLengthWidget> {
  List<int> get _periodLengths => List<int>.generate(8, (index) => index + 2);

  @override
  Widget build(BuildContext context) => HorizontalWheelWidget(
      list: _periodLengths,
      onSelectedItemChanged: (value) {
        IntroController.to.periodlength = value;
      });
}
