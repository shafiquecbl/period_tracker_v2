// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:food_delivery/controller/data_controller.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/style.dart';
import 'package:food_delivery/view/base/divider.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:food_delivery/data/model/event.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  CalendarScreenState createState() => CalendarScreenState();
}

class CalendarScreenState extends State<CalendarScreen> {
  late List<DateTime> _months;
  double _bottomSheetHeight = 200.0;
  bool _isExpanded = false;
  DateTime _selectedDate = DateTime.now().copyWith(
    hour: 0,
    minute: 0,
    second: 0,
    millisecond: 0,
    microsecond: 0,
  );

  @override
  void initState() {
    super.initState();
    _months = _generateMonths();
  }

  List<DateTime> _generateMonths() {
    final currentMonth = DateTime.now().month;
    final currentYear = DateTime.now().year;
    final List<DateTime> months = [];

    for (int i = -1; i <= 12; i++) {
      final month = (currentMonth + i) % 12;
      final year = currentYear + ((currentMonth + i) ~/ 12);
      final DateTime date = DateTime(year, month + 1, 1);
      months.add(date);
    }

    return months;
  }

  void _toggleBottomSheet() {
    setState(() {
      _isExpanded = !_isExpanded;
      _bottomSheetHeight =
          _isExpanded ? MediaQuery.of(context).size.height - 150 : 200.0;
    });
  }

  Widget _buildCalendarHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 10),
      child: Row(
        children: [
          'MO',
          'TU',
          'WE',
          'TH',
          'FR',
          'SA',
          'SU',
        ].map((day) => Expanded(child: Center(child: Text(day)))).toList(),
      ),
    );
  }

  Widget _buildMonthTitle(DateTime date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        DateFormat('MMMM yyyy').format(date),
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }

  Widget _buildCalendarPage(DateTime date) {
    final int daysInMonth = DateTime(date.year, date.month + 1, 0).day;

    return GetBuilder<DataController>(builder: (con) {
      return SizedBox(
        height: 340,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildMonthTitle(date),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: daysInMonth,
                itemBuilder: (BuildContext context, int index) {
                  final datee = DateTime(
                    _months[_months.indexOf(date)].year,
                    _months[_months.indexOf(date)].month,
                    index + 1,
                  );

                  final isSelected = _selectedDate.month == datee.month &&
                      _selectedDate.day == datee.day &&
                      _selectedDate.year == datee.year;

                  List<Event> events = con.events
                      .where((element) =>
                          element.date.day == datee.day &&
                          element.date.month == datee.month &&
                          element.date.year == datee.year)
                      .toList();
                  events.removeWhere((element) => element.predictedDay == 0);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDate = datee;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(isSelected ? 1.5 : 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radius),
                        border: isSelected
                            ? Border.all(
                                width: 2,
                                color: Theme.of(context).primaryColor,
                              )
                            : null,
                      ),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              for (int i = 0; i < events.length; i++)
                                Expanded(
                                    child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(i == 0 ? radius : 0),
                                      bottom: Radius.circular(
                                          i == events.length - 1 ? radius : 0),
                                    ),
                                    color: getColor(events[i].predictedDay),
                                  ),
                                ))
                            ],
                          ),
                          Center(
                              child: Text('${datee.day}',
                                  style: Theme.of(context).textTheme.bodyLarge))
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildBottomSheetContent() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: _bottomSheetHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.2),
              blurRadius: 10.0,
              spreadRadius: 2.0,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: IconButton(
                onPressed: _toggleBottomSheet,
                icon: Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_up,
                  size: 30,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            // show color dots and their meaning
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                spacing: 15,
                runSpacing: 5,
                children: [
                  _colorWidget(periodDayColor, 'Period Day'),
                  _colorWidget(fertileDayColor, 'Fertile Day'),
                  _colorWidget(ovulationDayColor, 'Ovulation Day'),
                ],
              ),
            ),
            const CustomDivider(padding: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // show events of selected day
                      Text(DateFormat('EEEE, dd MMMM yyyy')
                          .format(_selectedDate)),
                      const SizedBox(height: 10),
                      GetBuilder<DataController>(builder: (con) {
                        List<String> events =
                            con.generatePredictions(_selectedDate);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var item in events)
                              Text(
                                item,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              )
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _colorWidget(Color color, String text) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: fontWeightNormal),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            _buildCalendarHeader(),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                color: const Color(0xffFEF9F9),
                child: ListView.builder(
                  itemCount: _months.length,
                  itemBuilder: (BuildContext context, int index) =>
                      _buildCalendarPage(_months[index]),
                ),
              ),
            ),
            const SizedBox(height: 140),
          ],
        ),
        _buildBottomSheetContent(),
      ],
    );
  }
}

Color getColor(int day) {
  switch (day) {
    case 0:
      return cycleDayColor;
    case 1:
      return periodDayColor;
    case 2:
      return fertileDayColor;
    case 3:
      return ovulationDayColor;
    default:
      return Colors.white;
  }
}

String getText(int day) {
  switch (day) {
    case 0:
      return 'Cycle Day';
    case 1:
      return 'Period Day';
    case 2:
      return 'Fertile Day';
    case 3:
      return 'Ovulation Day';
    default:
      return '';
  }
}
