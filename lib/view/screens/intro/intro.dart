import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/common/primary_button.dart';
import 'package:food_delivery/controller/intro_controller.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/images.dart';
import 'package:food_delivery/utils/style.dart';
import 'package:get/get.dart';
import 'widgets/calender.dart';
import 'widgets/cycle_length_widget.dart';
import 'widgets/period_length_widget.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  int _selectedPage = 0;

  List<Widget> get pages => [
        const CycleLengthWidget(),
        const PeriodLengthWidget(),
        const SizedBox(),
      ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IntroController>(builder: (con) {
      return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            _gradientBackground(),
            Image.asset(
              Images.splash,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              color: Colors.white.withOpacity(0.05),
            ),
            _dotsIndicator(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      _topTitle(context),
                      const SizedBox(
                        height: 40,
                      ),
                      // child
                      _selectedPage == 2
                          ? Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(radius)),
                              child: CalendarWidget(
                                  startDate: DateTime.now()
                                      .subtract(const Duration(days: 60)),
                                  lastDate: DateTime.now(),
                                  onDateSelected: (date) =>
                                      con.lastperioddate = date))
                          : pages[_selectedPage],
                    ],
                  )),
                  _actionButton(con),
                  const SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: TextButton(
                        onPressed: () {
                          if (_selectedPage > 2) {
                            setState(() {
                              _selectedPage += 1;
                            });
                          } else {
                            con.saveData();
                          }
                        },
                        child: Text(
                          'I don\'t remember',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.white,
                                  ),
                        )),
                  ),
                  _bottomHintWidget(context),
                  SizedBox(height: 30.h),
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  Text _bottomHintWidget(BuildContext context) {
    return Text(
        _selectedPage == 0
            ? '(We will set your cycle length to 22 days. You can change this later in settings.)'
            : _selectedPage == 1
                ? '(We will set your period length to 5 days. You can change this later in settings.)'
                : '(We will set your last period to today. You can change this later in settings.)',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Theme.of(context).cardColor, fontWeight: fontWeightNormal));
  }

  Row _actionButton(IntroController con) => Row(
        children: [
          if (_selectedPage != 0) ...[
            Expanded(
              child: CustomButton(
                  color: Colors.white.withOpacity(0.5),
                  text: 'Back',
                  onPressed: () {
                    if (_selectedPage > 0) {
                      setState(() {
                        _selectedPage -= 1;
                      });
                    }
                  }),
            ),
            const SizedBox(
              width: 15,
            ),
          ],
          Expanded(
            child: CustomButton(
                text: _selectedPage == 2 ? 'Save' : 'Continue',
                onPressed: () {
                  if (_selectedPage == 2) {
                    con.saveData();
                  } else {
                    setState(() {
                      _selectedPage += 1;
                    });
                  }
                }),
          ),
        ],
      );

  Text _topTitle(BuildContext context) => Text(
        _selectedPage == 0
            ? 'What is your average cycle length?'
            : _selectedPage == 1
                ? 'What is your average period length?'
                : 'When did your last period start?',
        style: Theme.of(context)
            .textTheme
            .displayMedium!
            .copyWith(color: Colors.white),
      );

  Positioned _dotsIndicator() => Positioned(
        top: 50,
        right: 30,
        child: SizedBox(
          height: 100,
          width: 30,
          child: ListView.separated(
              itemBuilder: (context, index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color: _selectedPage == index
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                  ),
              separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
              itemCount: pages.length),
        ),
      );

  Widget _gradientBackground() => DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              purpleColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      );
}
