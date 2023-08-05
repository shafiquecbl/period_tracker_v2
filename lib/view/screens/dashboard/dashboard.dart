import 'package:flutter/material.dart';
import 'package:food_delivery/controller/data_controller.dart';
import 'package:food_delivery/view/screens/calender/calender.dart';
import 'package:food_delivery/view/screens/home/home.dart';
import 'package:get/get.dart';
import 'package:food_delivery/view/screens/settings/settings.dart';
import 'package:iconsax/iconsax.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _selectedIndex = 0;
  List<Widget> pages = [
    const HomePage(),
    const CalendarScreen(),
    const SettingPage()
  ];

  @override
  void initState() {
    DataController.to.getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          itemCount: pages.length,
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => SafeArea(child: pages[index])),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).hintColor,
          backgroundColor: Theme.of(context).cardColor,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: Theme.of(context).textTheme.bodySmall,
          unselectedLabelStyle: Theme.of(context).textTheme.bodySmall,
          onTap: (int index) {
            setState(() {
              _pageController.jumpToPage(index);
              _selectedIndex = index;
            });
          },
          items: [
            _bottomItem(Iconsax.home, 'home'.tr),
            _bottomItem(Iconsax.calendar, 'Calender'.tr),
            _bottomItem(Iconsax.more_square, 'More'.tr),
          ]),
    );
  }

  _bottomItem(IconData icon, String label) => BottomNavigationBarItem(
      backgroundColor: Theme.of(context).cardColor,
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: Icon(icon),
      ),
      label: label);
}
