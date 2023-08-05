import 'package:food_delivery/data/model/user_data.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProfileStorage {
  ProfileStorage._();
  static ProfileStorage instance = ProfileStorage._();

  final _box = Hive.box('profile');

  // save cycle length, period length, last period date in hive
  saveProfile(
      {required int cycleLength,
      required int periodLength,
      required DateTime lastPeriodDate}) async {
    await Future.wait([
      _box.put('cycleLength', cycleLength),
      _box.put('periodLength', periodLength),
      _box.put('lastPeriodDate', lastPeriodDate)
    ]);
  }

  // get cycle length, period length, last period date from hive
  Future<UserData> getProfile() async {
    final cycleLength = _box.get('cycleLength');
    final periodLength = _box.get('periodLength');
    final lastPeriodDate = _box.get('lastPeriodDate');
    var json = {
      'cycleLength': cycleLength,
      'periodLength': periodLength,
      'lastPeriodDate': lastPeriodDate
    };
    return UserData.fromMap(json);
  }
}
