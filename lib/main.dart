import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/view/screens/splash/splash.dart';
import 'package:get/get.dart';
import 'package:food_delivery/controller/theme_controller.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'helper/get_di.dart' as di;
import 'controller/localization_controller.dart';
import 'theme/dark_theme.dart';
import 'theme/light_theme.dart';
import 'utils/messages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Map<String, Map<String, String>> languages = await di.init();
  runApp(MyApp(languages: languages));
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;
  const MyApp({required this.languages, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: ((themeController) {
      return GetBuilder<LocalizationController>(builder: (localizeController) {
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => GetMaterialApp(
            title: AppConstants.APP_NAME,
            debugShowCheckedModeBanner: false,
            theme: themeController.darkTheme
                ? themeController.darkColor == null
                    ? dark()
                    : dark(color: themeController.darkColor!)
                : themeController.lightColor == null
                    ? light()
                    : light(color: themeController.lightColor!),
            locale: localizeController.locale,
            translations: Messages(languages: languages),
            fallbackLocale: Locale(AppConstants.languages[0].languageCode,
                AppConstants.languages[0].countryCode),
            home: const SplashScreen(),
          ),
        );
      });
    }));
  }
}
