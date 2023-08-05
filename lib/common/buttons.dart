import 'package:flutter/material.dart';
import 'package:food_delivery/controller/localization_controller.dart';
import 'package:food_delivery/controller/theme_controller.dart';
import 'package:food_delivery/utils/icons.dart';
import 'package:food_delivery/utils/style.dart';
import 'package:get/get.dart';
import 'icons.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8)
          .copyWith(left: !isLtr ? 0 : 16, right: !isLtr ? 16 : 0),
      child: CustomIcon(
        icon: FFIcons.leftArrow2,
        iconSize: 28,
        border: 8,
        onTap: () => Navigator.pop(context),
      ),
    );
  }
}

class SocialLoginButton extends StatelessWidget {
  final String image;
  final VoidCallback onPressed;
  const SocialLoginButton(
      {required this.image, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return CustomIcon(
      iconSize: 36,
      padding: 8,
      color: isDark ? Colors.white : Theme.of(context).cardColor,
      image: image,
      iconColor: null,
      border: radius,
      onTap: onPressed,
    );
  }
}

class AnimatedTabButton extends StatelessWidget {
  final String text;
  final bool selected;
  final Function()? onTap;
  final bool small;
  const AnimatedTabButton(
      {required this.text,
      required this.onTap,
      this.selected = false,
      this.small = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: small ? 40 : 45,
          decoration: BoxDecoration(
            color: selected
                ? Theme.of(context).scaffoldBackgroundColor
                : Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: Theme.of(context)
                          .hintColor
                          .withOpacity(Get.isDarkMode ? 0.1 : 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
