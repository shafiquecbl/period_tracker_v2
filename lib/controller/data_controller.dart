import 'package:food_delivery/data/model/event.dart';
import 'package:food_delivery/data/model/user_data.dart';
import 'package:food_delivery/data/storage/profile.dart';
import 'package:food_delivery/helper/timeago.dart';
import 'package:get/get.dart';

class DataController extends GetxController implements GetxService {
  static DataController get to => Get.find();

  int _cyclelength = 22;
  int _periodlength = 5;
  DateTime _lastperioddate = DateTime.now()
      .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
  final List<Event> _events = [];

  int get cyclelength => _cyclelength;
  int get periodlength => _periodlength;
  DateTime get lastperioddate => _lastperioddate;
  List<Event> get events => _events;

  getUserData() async {
    UserData data = await ProfileStorage.instance.getProfile();
    _cyclelength = data.cycleLength!;
    _periodlength = data.periodLength!;
    _lastperioddate = data.lastPeriodDate!;
    _events.clear();
    _events.addAll(generateEventList(
      _cyclelength,
      _periodlength,
      _lastperioddate,
    ));
    update();
  }

  List<Event> generateEventList(
    int averageCycleLength,
    int averagePeriodLength,
    DateTime lastPeriodStartDate,
  ) {
    List<Event> events = [];

    // Start generating events from lastPeriodStartDate
    DateTime currentPeriodDate = lastPeriodStartDate;
    DateTime currentCycleDate = lastPeriodStartDate;

    // Generate events for 12 months
    for (int i = 0; i < 12; i++) {
      // Add the period events
      for (int day = 1; day <= averagePeriodLength; day++) {
        DateTime periodDay = currentPeriodDate.add(Duration(days: day - 1));
        events.add(Event(date: periodDay, predictedDay: 1));
      }

      // Calculate the fertility window
      DateTime fertilityStart = currentCycleDate.add(const Duration(days: 3));
      DateTime fertilityEnd = fertilityStart.add(const Duration(days: 6));

      // Add the fertility window events
      getDatesBetween(fertilityStart, fertilityEnd).forEach((fertilityDay) {
        events.add(Event(date: fertilityDay, predictedDay: 2));
      });

      // Calculate the ovulation date
      DateTime ovulationDate = fertilityEnd.subtract(const Duration(days: 1));
      events.add(Event(date: ovulationDate, predictedDay: 3));

      // Calculate the next period date and cycle date based on the actual cycle length
      currentPeriodDate =
          currentPeriodDate.add(Duration(days: averageCycleLength));
      currentCycleDate =
          currentCycleDate.add(Duration(days: averageCycleLength));

      // add the cycle day events ()
      var list = getDatesBetween(lastPeriodStartDate, currentCycleDate);
      for (int i = 1; i <= list.length - 1; i++) {
        events.add(Event(date: list[i - 1], predictedDay: 0, cycleday: i));
      }
    }

    return events;
  }

// Function to generate predictions for a selected date
  List<String> generatePredictions(DateTime selectedDate) {
    Event ovulationEvent = events.firstWhere(
      (event) => event.predictedDay == 3 && event.date.isAfter(selectedDate),
    );

    Event cycleDayEvent = events.firstWhere(
        (event) => event.predictedDay == 0 && event.date == selectedDate);

    int daysUntilFertile =
        ovulationEvent.date.difference(selectedDate).inDays - 5;

    if (daysUntilFertile.isNegative) {
      daysUntilFertile = 17 + (5 - daysUntilFertile.abs());
    }

    int daysUntilOvulation =
        ovulationEvent.date.difference(selectedDate).inDays + 1;

    int? cycleDay = cycleDayEvent.cycleday;

    int? periodDate = cycleDay > 5 ? null : cycleDay;

    return [
      if (periodDate != null)
        '$periodDate${_getDayCountSuffix(cycleDay)} day of period',

      //
      daysUntilFertile != 0
          ? '$daysUntilFertile days until fertile'
          : 'Today is your fertile window',

      //
      daysUntilOvulation != 0
          ? '${daysUntilOvulation - 1} days until ovulation'
          : 'You are ovulating',

      //
      '$cycleDay${_getDayCountSuffix(cycleDay)} day of cycle'
    ];
  }

  DateTime _selectedDate = DateTime.now().copyWith(
    hour: 0,
    minute: 0,
    second: 0,
    millisecond: 0,
    microsecond: 0,
  );
  DateTime get selectedDate => _selectedDate;

  set selectedDate(DateTime value) {
    _selectedDate = value;
    update();
  }

  Event? get selectedEvent {
    return _events.firstWhereOrNull(
      (e) =>
          e.date.day == _selectedDate.day &&
          e.date.month == _selectedDate.month &&
          e.date.year == _selectedDate.year,
    );
  }

  String get predictedDay {
    Event? event = selectedEvent;

    switch (event!.predictedDay) {
      case 0:
        return 'Cycle Day';
      case 1:
        return 'Period Day';
      case 2:
        return 'Fertility Day';

      case 3:
        return 'Ovulation Day';
      default:
        return 'Cycle Day';
    }
  }

  String get predictedDayCount {
    Event event = selectedEvent!;
    int predictedDay = event.predictedDay;

    int dayCount = 1; // Start with 1 as the initial day count

    // Find the previous events with the same predicted day and count them
    for (int i = _events.indexOf(event) - 1; i >= 0; i--) {
      if (_events[i].predictedDay == predictedDay) {
        dayCount++;
      } else {
        break;
      }
    }

    return '$dayCount${_getDayCountSuffix(dayCount)}';
  }

  String _getDayCountSuffix(int dayCount) {
    if (dayCount == 1) {
      return 'st';
    } else if (dayCount == 2) {
      return 'nd';
    } else if (dayCount == 3) {
      return 'rd';
    } else {
      return 'th';
    }
  }

  String get chanceOfGettingPregnent {
    Event? event = selectedEvent;
    switch (event!.predictedDay) {
      case 0:
        return 'Low';
      case 1:
        return 'High';
      case 2:
        return 'Medium';
      case 3:
        return 'Medium';
      default:
        return 'Low';
    }
  }
}
