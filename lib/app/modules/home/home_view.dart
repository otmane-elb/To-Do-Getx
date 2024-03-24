import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todogetx/app/core/utils/extensions.dart';
import 'package:todogetx/app/core/values/colors.dart';
import 'package:todogetx/app/data/models/task.dart';
import 'package:todogetx/app/modules/home/add_card.dart';
import 'package:todogetx/app/modules/home/home_controller.dart';
import 'package:todogetx/app/modules/home/widgets/add_dialog.dart';
import 'package:todogetx/app/modules/home/widgets/task_card.dart';
import 'package:todogetx/app/modules/report/report_view.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        title: Obx(
          () => Padding(
              padding: EdgeInsets.all(4.0.wp),
              child: controller.tabIndex.value == 0
                  ? Row(
                      children: [
                        Icon(
                          Icons.task_outlined,
                          size: 10.0.wp,
                          color: green,
                        ),
                        SizedBox(
                          width: 5.0.wp,
                        ),
                        Text(
                          "My Tasks",
                          style: TextStyle(
                              fontSize: 24.0.sp, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Icon(
                          Icons.show_chart,
                          size: 10.0.wp,
                          color: green,
                        ),
                        SizedBox(
                          width: 5.0.wp,
                        ),
                        Text(
                          "My Report",
                          style: TextStyle(
                              fontSize: 24.0.sp, fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
        ),
      ),
      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children: [
            SafeArea(
              child: ListView(
                children: [
                  Obx(
                    () => GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      children: [
                        ...controller.tasks
                            .map(
                              (element) => LongPressDraggable(
                                data: element,
                                onDragStarted: () =>
                                    controller.changeDeleting(true),
                                onDraggableCanceled: (velocity, offset) =>
                                    controller.changeDeleting(false),
                                onDragEnd: (velocity) =>
                                    controller.changeDeleting(false),
                                feedback: Opacity(
                                  opacity: 0.8,
                                  child: TaskCard(task: element),
                                ),
                                child: TaskCard(task: element),
                              ),
                            )
                            .toList(),
                        AddCard(),
                      ],
                    ),
                  )
                ],
              ),
            ),
            ReportPage()
          ],
        ),
      ),
      floatingActionButton: DragTarget<Task>(
        builder: (_, __, ___) {
          return Obx(
            () => FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              backgroundColor:
                  controller.deleting.value ? Colors.red : Colors.grey[50],
              onPressed: () {
                if (controller.tasks.isNotEmpty) {
                  Get.to(() => AddDialog(), transition: Transition.downToUp);
                } else {
                  EasyLoading.showInfo("Please add a task first");
                }
              },
              child: Icon(controller.deleting.value ? Icons.delete : Icons.add),
            ),
          );
        },
        onAccept: (Task task) {
          controller.deleteTask(task);
          EasyLoading.showSuccess("Task deleted successfully");
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(
        () => Theme(
          data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent),
          child: BottomNavigationBar(
            onTap: (int index) {
              controller.changeTabIndex(index);
            },
            currentIndex: controller.tabIndex.value,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                label: "Home",
                icon: Icon(Icons.apps),
              ),
              BottomNavigationBarItem(
                label: "Report",
                icon: Icon(Icons.data_usage),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
