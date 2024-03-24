import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todogetx/app/core/utils/extensions.dart';
import 'package:todogetx/app/core/values/colors.dart';
import 'package:todogetx/app/modules/home/home_controller.dart';

class ReportPage extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          var completedTasks = homeCtrl.getTotalDoneTask();
          var totalTasks = homeCtrl.getTotalTask();
          var liveTasks = totalTasks - completedTasks;
          var percent = (completedTasks / totalTasks * 100).toStringAsFixed(0);
          return ListView(
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 15.0.sp, vertical: 2.0.hp),
                child: Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: TextStyle(
                      fontSize: 15.0.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ),
              const Divider(),
              SizedBox(
                height: 3.0.hp,
              ),
              Padding(
                padding: EdgeInsets.only(right: 5.0.wp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatus(Colors.orange, liveTasks, "Live Tasks"),
                    _buildStatus(
                        Colors.green, completedTasks, "Completed Tasks"),
                    _buildStatus(Colors.blue, totalTasks, "All Tasks"),
                  ],
                ),
              ),
              SizedBox(
                height: 5.0.hp,
              ),
              UnconstrainedBox(
                child: SizedBox(
                  width: 70.0.wp,
                  height: 70.0.wp,
                  child: CircularStepProgressIndicator(
                    totalSteps: totalTasks == 0 ? 1 : totalTasks,
                    currentStep: completedTasks,
                    stepSize: 20,
                    selectedStepSize: 22,
                    selectedColor: green,
                    unselectedColor: Colors.grey[200],
                    padding: 0,
                    width: 150,
                    height: 150,
                    roundedCap: (p0, p1) => true,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${totalTasks == 0 ? 0 : percent} %",
                            style: TextStyle(fontSize: 20.0.sp),
                          )
                        ]),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  _buildStatus(Color color, int number, String title) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: 3.0.wp,
              width: 3.0.wp,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: color, width: 0.5.wp)),
            ),
            SizedBox(
              width: 5.0.wp,
            ),
            Text(
              number.toString(),
              style: TextStyle(color: Colors.grey, fontSize: 15.0.sp),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 7.0.wp, top: 1.0.hp),
          child: Text(
            title,
            style: TextStyle(color: Colors.grey, fontSize: 13.0.sp),
          ),
        )
      ],
    );
  }
}
