import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todogetx/app/core/utils/extensions.dart';
import 'package:todogetx/app/core/values/colors.dart';
import 'package:todogetx/app/modules/home/home_controller.dart';

class DoingList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DoingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeCtrl.doingtodos.isEmpty && homeCtrl.doneTodos.isEmpty
          ? Column(
              children: [
                Image.asset(
                  "assets/task.png",
                  fit: BoxFit.cover,
                  width: 65.0.wp,
                ),
                Text(
                  "Add Task",
                  style: TextStyle(
                      fontSize: 15.0.sp,
                      fontWeight: FontWeight.bold,
                      color: blueish),
                ),
              ],
            )
          : ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                ...homeCtrl.doingtodos
                    .map((element) => Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0.wp, vertical: 1.0.hp),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: Checkbox(
                                  fillColor: MaterialStateProperty.resolveWith(
                                      (states) => Colors.grey),
                                  value: element['done'],
                                  onChanged: ((value) {
                                    homeCtrl.doneTodo(element['title']);
                                  }),
                                ),
                              ),
                              SizedBox(
                                width: 3.0.wp,
                              ),
                              Text(
                                element['title'],
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ))
                    .toList()
              ],
            ),
    );
  }
}
