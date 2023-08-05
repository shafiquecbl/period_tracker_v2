import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/images.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child;
  const BackgroundWidget({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            Images.splash,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            color: periodDayColor.withOpacity(0.1),
          ),
          child,
        ],
      ),
    );
  }
}
