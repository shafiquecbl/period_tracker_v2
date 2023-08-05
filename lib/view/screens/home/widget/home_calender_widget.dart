import 'package:flutter/material.dart';
import 'package:food_delivery/controller/data_controller.dart';
import 'package:food_delivery/utils/style.dart';
import 'package:intl/intl.dart';

class HomePageCalender extends StatefulWidget {
  const HomePageCalender({super.key});

  @override
  HomePageCalenderState createState() => HomePageCalenderState();
}

class HomePageCalenderState extends State<HomePageCalender> {
  late PageController _pageController;
  int _currentPage = DateTime.now().month;
  late ScrollController _scrollController;
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
    _pageController = PageController(initialPage: _currentPage - 1);
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback(
        (_) => {_scrollToCurrentDate(), _selectDate(_selectedDate)});
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToCurrentDate() {
    final currentDate = DateTime.now();
    final currentMonth = currentDate.month;
    final currentDay = currentDate.day;

    final int index = currentMonth - 1;

    if (index >= 0 && index <= _pageController.page!.toInt()) {
      final scrollOffset = 75.0 * (currentDay - 1);
      _scrollController.jumpTo(scrollOffset);
    }
  }

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
    DataController.to.selectedDate = date;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125,
      child: PageView.builder(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 12,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page + 1;
          });
        },
        itemBuilder: (BuildContext context, int index) {
          final month = _currentPage;
          final year = DateTime.now().year + (month - 1) ~/ 12;
          final daysInMonth = DateTime(year, month % 12 + 1, 0).day;

          // final selectedDateText =
          //     DateFormat('EEEE, d MMMM').format(_selectedDate);

          return Column(
            children: [
              Row(
                children: [
                  _previousMonth(),
                  const Spacer(),
                  _currentMonth(),
                  const Spacer(),
                  _nextMonth(),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              _buildCalendarPage(daysInMonth),
            ],
          );
        },
      ),
    );
  }

  Widget _previousMonth() => IconButton(
        padding: EdgeInsets.zero,
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        onPressed: () {
          setState(() {
            _currentPage -= 1;
          });
        },
        icon: const Icon(Icons.arrow_back_ios_rounded),
      );
  Widget _nextMonth() => IconButton(
        padding: EdgeInsets.zero,
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        onPressed: () {
          setState(() {
            _currentPage += 1;
          });
        },
        icon: const Icon(Icons.arrow_forward_ios_rounded),
      );

  Widget _currentMonth() => Text(
        DateFormat('MMMM yyyy').format(DateTime(
          DateTime.now().year + ((_currentPage - 1) ~/ 12),
          (_currentPage - 1) % 12 + 1,
          1,
        )),
      );

  Widget _buildCalendarPage(int daysInMonth) {
    final List<DateTime> dates = _generateDates(daysInMonth);

    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        itemCount: dates.length,
        itemBuilder: (BuildContext context, int index) {
          final date = dates[index];

          final isSelected = date.year == _selectedDate.year &&
              date.month == _selectedDate.month &&
              date.day == _selectedDate.day;

          return GestureDetector(
            onTap: () => _selectDate(date),
            child: Container(
              padding: EdgeInsets.all(isSelected ? 2 : 0),
              decoration: BoxDecoration(
                border: isSelected
                    ? Border.all(
                        width: 2, color: Theme.of(context).primaryColor)
                    : null,
                borderRadius: BorderRadius.circular(radius),
              ),
              child: Container(
                width: 75,
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(radius),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _getDayOfWeek(date),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: isSelected ? Colors.white : null,
                          ),
                    ),
                    Text(
                      '${date.day}',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: isSelected ? Colors.white : null,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 10),
      ),
    );
  }

  List<DateTime> _generateDates(int daysInMonth) {
    final int currentMonth = (_currentPage - 1) % 12 + 1;
    final int currentYear = DateTime.now().year + ((_currentPage - 1) ~/ 12);

    final List<DateTime> dates = [];

    for (int i = 1; i <= daysInMonth; i++) {
      final DateTime date = DateTime(currentYear, currentMonth, i);
      dates.add(date);
    }

    return dates;
  }

  String _getDayOfWeek(DateTime date) {
    final List<String> daysOfWeek = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun'
    ];
    final int dayIndex = date.weekday - 1;
    return daysOfWeek[dayIndex];
  }
}
