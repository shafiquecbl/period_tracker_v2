import 'package:food_delivery/data/model/language.dart';
import 'package:food_delivery/utils/app_constants.dart';

class LanguageRepo {
  List<LanguageModel> getAllLanguages() {
    return AppConstants.languages;
  }
}
