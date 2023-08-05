import 'package:food_delivery/data/storage/profile.dart';
import 'package:food_delivery/helper/navigation.dart';
import 'package:food_delivery/view/screens/dashboard/dashboard.dart';
import 'package:get/get.dart';

class IntroController extends GetxController implements GetxService {
  static IntroController get to => Get.find();

  int _cyclelength = 22;
  int _periodlength = 5;
  DateTime _lastperioddate = DateTime.now()
      .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);

  int get cyclelength => _cyclelength;
  int get periodlength => _periodlength;
  DateTime get lastperioddate => _lastperioddate;

  set cyclelength(int value) {
    _cyclelength = value;
    update();
  }

  set periodlength(int value) {
    _periodlength = value;
    update();
  }

  set lastperioddate(DateTime value) {
    _lastperioddate = value;
    update();
  }

  saveData() async {
    await ProfileStorage.instance.saveProfile(
      cycleLength: _cyclelength,
      periodLength: _periodlength,
      lastPeriodDate: _lastperioddate,
    );
    launchScreen(const DashboardPage());
  }
}
