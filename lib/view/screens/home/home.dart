import 'package:flutter/material.dart';
import 'package:food_delivery/controller/data_controller.dart';
import 'package:food_delivery/view/base/background_widget.dart';
import 'package:food_delivery/view/screens/calender/calender.dart';
import 'package:get/get.dart';
import 'widget/home_calender_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DataController>(builder: (con) {
      List<String> predictions = con.events.isNotEmpty
          ? con.generatePredictions(con.selectedDate)
          : [];
      return BackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const HomePageCalender(),
              const SizedBox(
                height: 15,
              ),
              if (con.selectedEvent != null)
                Expanded(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              crossAxisCount: 2,
                              childAspectRatio: 1.5),
                      itemBuilder: (context, index) {
                        String prediction = predictions[index];
                        String title = prediction.split(' ').first;
                        String subtitle = prediction.replaceAll(title, '');

                        return Container(
                          padding: const EdgeInsets.all(10),
                          height: 120,
                          decoration: BoxDecoration(
                              color: getColor(prediction.contains('period')
                                  ? 1
                                  : prediction.contains('fertile')
                                      ? 2
                                      : prediction.contains('ovulation')
                                          ? 3
                                          : 0),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // title
                              Text(
                                title,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontSize: 24),
                              ),

                              // subtitle
                              Text(
                                subtitle,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: predictions.length),
                )
            ],
          ),
        ),
      );
    });
  }
}
