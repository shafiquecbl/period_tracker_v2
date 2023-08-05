import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:food_delivery/controller/data_controller.dart';
import 'package:food_delivery/controller/localization_controller.dart';
import 'package:food_delivery/controller/intro_controller.dart';
import 'package:food_delivery/controller/theme_controller.dart';
import 'package:food_delivery/data/model/language.dart';
import 'package:food_delivery/data/repository/language_repo.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

Future<Map<String, Map<String, String>>> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  await Hive.initFlutter();
  await Hive.openBox('profile');
  Get.lazyPut(() => sharedPreferences);

  // Repository
  Get.lazyPut(() => LanguageRepo());

  // Controller
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
  Get.lazyPut(() => IntroController());
  Get.lazyPut(() => DataController());

  // Retrieving localized data
  Map<String, Map<String, String>> languages = {};
  for (LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = jsonDecode(jsonStringValues);
    Map<String, String> json = {};
    mappedJson.forEach((key, value) {
      json[key] = value.toString();
    });
    languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        json;
  }
  return languages;
}
