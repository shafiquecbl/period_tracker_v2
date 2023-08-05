import 'package:flutter/material.dart';
import 'package:food_delivery/data/model/user_data.dart';
import 'package:food_delivery/data/storage/profile.dart';
import 'package:food_delivery/helper/navigation.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/images.dart';
import 'package:food_delivery/view/base/animated_widget.dart';
import 'package:food_delivery/view/screens/dashboard/dashboard.dart';
import 'package:food_delivery/view/screens/intro/intro.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    UserData data = await ProfileStorage.instance.getProfile();

    Future.delayed(const Duration(seconds: 3), () {
      launchScreen(
          data.cycleLength == null ? const IntroPage() : const DashboardPage(),
          duration: const Duration(milliseconds: 500));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            Images.splash,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            color: periodDayColor.withOpacity(0.15),
          ),
          // bottom text
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Text(
                '❤️ Period Tracker ❤️',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
          CustomAnimatedWidget(
              child: Center(
            child: Image.asset(
              Images.logo,
              width: 150,
              height: 150,
            ),
          )),
        ],
      ),
    );
  }
}
