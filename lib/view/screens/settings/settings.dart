import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/helper/navigation.dart';
import 'package:food_delivery/utils/style.dart';
import 'package:food_delivery/view/base/divider.dart';
import 'package:food_delivery/view/screens/intro/intro.dart';
import 'package:get/get.dart';
import 'package:food_delivery/controller/theme_controller.dart';
import 'package:food_delivery/utils/icons.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title
            Text(
              'Settings'.tr,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: fontWeightBold,
                  ),
            ),
            const SizedBox(height: 20),
            _customTile(
              context,
              FFIcons.user,
              'Update Data',
              () => launchScreen(const IntroPage()),
            ),
            _customTile(
              context,
              FFIcons.share,
              'Share with your friends',
              () {},
            ),
            _customTile(
              context,
              FFIcons.star,
              'Rate app',
              () {},
            ),
            _customTile(
              context,
              FFIcons.email,
              'Contact Us',
              () {},
            ),
            _customTile(
              context,
              FFIcons.info,
              'Privacy Policy',
              () {},
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  _customTile(
      BuildContext context, IconData icon, String text, Function() onPressed,
      {bool theme = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: 0,
          visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
          leading: Icon(icon),
          title: Text(text.tr,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 15,
                    fontWeight: fontWeightNormal,
                  )),
          trailing: theme
              ? GetBuilder<ThemeController>(builder: (themeController) {
                  return CupertinoSwitch(
                    value: themeController.darkTheme,
                    onChanged: (value) {
                      themeController.toggleTheme();
                    },
                  );
                })
              : null,
          onTap: onPressed,
        ),
        const CustomDivider(),
      ],
    );
  }
}
