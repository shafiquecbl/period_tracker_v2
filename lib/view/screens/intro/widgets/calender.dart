import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CalendarWidget extends StatefulWidget {
  final DateTime startDate;
  final DateTime lastDate;

  final Function(DateTime)? onDateSelected;

  const CalendarWidget({
    Key? key,
    required this.startDate,
    required this.lastDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  CalendarWidgetState createState() => CalendarWidgetState();
}

class CalendarWidgetState extends State<CalendarWidget> {
  late PageController _pageController;
  late int _currentPage;
  late List<DateTime> _months;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _currentPage = _calculateInitialPage();
    _months = _generateMonths();
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _calculateInitialPage() {
    final int monthsDiff = widget.lastDate.month - widget.startDate.month;
    final int yearsDiff = widget.lastDate.year - widget.startDate.year;
    return monthsDiff + (yearsDiff * 12);
  }

  List<DateTime> _generateMonths() {
    final List<DateTime> months = [];
    DateTime currentDate = widget.startDate;

    while (currentDate.isBefore(widget.lastDate)) {
      months.add(currentDate);
      currentDate = DateTime(currentDate.year, currentDate.month + 1, 1);
    }

    return months;
  }

  Widget _buildCalendarHeader(DateTime date) {
    final List<String> daysOfWeek = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: daysOfWeek
            .map((day) => Expanded(child: Center(child: Text(day))))
            .toList(),
      ),
    );
  }

  Widget _buildCalendarPage(DateTime date) {
    final int daysInMonth = DateTime(date.year, date.month + 1, 0).day;

    return Column(
      children: [
        _buildCalendarHeader(date),
        _buildCalendarGrid(daysInMonth),
      ],
    );
  }

  Widget _buildCalendarGrid(int daysInMonth) {
    final List<DateTime> dates = _generateDates(daysInMonth);

    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 10),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: dates.length,
      itemBuilder: (BuildContext context, int index) {
        final date = dates[index];

        bool isSelected = date.year == _selectedDate.year &&
            date.month == _selectedDate.month &&
            date.day == _selectedDate.day;
        return GestureDetector(
          onTap: () {
            widget.onDateSelected!(date);
            setState(() {
              _selectedDate = date;
            });
          },
          child: Container(
            decoration: BoxDecoration(
                color: isSelected ? Theme.of(context).primaryColor : null,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                '${date.day}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: isSelected ? Colors.white : null),
              ),
            ),
          ),
        );
      },
    );
  }

  List<DateTime> _generateDates(int daysInMonth) {
    final DateTime firstDate =
        DateTime(_months[_currentPage].year, _months[_currentPage].month, 1);
    final DateTime lastDate = DateTime(
        _months[_currentPage].year, _months[_currentPage].month, daysInMonth);

    final List<DateTime> dates = [];

    for (DateTime date = firstDate;
        date.isBefore(lastDate.add(const Duration(days: 1)));
        date = date.add(const Duration(days: 1))) {
      dates.add(date);
    }

    return dates;
  }

  void _previousMonth() {
    setState(() {
      if (_currentPage > 0) {
        _currentPage--;
        _pageController.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
      }
    });
  }

  void _nextMonth() {
    setState(() {
      if (_currentPage < _months.length - 1) {
        _currentPage++;
        _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 330.h,
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: _previousMonth,
                icon: const Icon(Icons.arrow_back_ios_rounded),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    DateFormat('MMMM yyyy').format(_months[_currentPage]),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
              IconButton(
                onPressed: _nextMonth,
                icon: const Icon(Icons.arrow_forward_ios_rounded),
              ),
            ],
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _months.length,
              itemBuilder: (BuildContext context, int index) {
                final month = _months[index];
                return _buildCalendarPage(month);
              },
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
