import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todogetx/app/core/utils/extensions.dart';
import 'package:todogetx/app/modules/home/home_controller.dart';

class DoneList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  DoneList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeCtrl.doneTodos.isEmpty
          ? Container()
          : ListView(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: [
                homeCtrl.doingtodos.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0.wp, vertical: 1.0.hp),
                        child: Divider(),
                      )
                    : Container(),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 7.0.wp, vertical: 1.0.hp),
                  child: Text(
                    "Completed (${homeCtrl.doneTodos.length.toString()})",
                    style: TextStyle(fontSize: 15.0.sp),
                  ),
                ),
                ...homeCtrl.doneTodos
                    .map((element) => Dismissible(
                          key: ObjectKey(element),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            homeCtrl.deletDoneTodo(element);
                          },
                          background: Container(
                            padding: EdgeInsets.only(right: 2.0.wp),
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.delete),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0.wp, vertical: 1.0.hp),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Checkbox(
                                    fillColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) => Colors.grey),
                                    value: element['done'],
                                    onChanged: ((value) {
                                      homeCtrl.undoneTodo(element['title']);
                                    }),
                                  ),
                                ),
                                SizedBox(
                                  width: 3.0.wp,
                                ),
                                Text(
                                  element['title'],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                    .toList()
              ],
            ),
    );
  }
}
