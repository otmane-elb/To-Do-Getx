import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todogetx/app/core/utils/extensions.dart';
import 'package:todogetx/app/data/models/task.dart';
import 'package:todogetx/app/modules/home/add_card.dart';
import 'package:todogetx/app/modules/home/home_controller.dart';
import 'package:todogetx/app/modules/home/widgets/add_dialog.dart';
import 'package:todogetx/app/modules/home/widgets/task_card.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(4.0.wp),
              child: Text(
                "My Tasks",
                style:
                    TextStyle(fontSize: 24.0.sp, fontWeight: FontWeight.bold),
              ),
            ),
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
                          onDragStarted: () => controller.changeDeleting(true),
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
      floatingActionButton: DragTarget<Task>(
        builder: (_, __, ___) {
          return Obx(
            () => FloatingActionButton(
              backgroundColor: controller.deleting.value ? Colors.red : null,
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
    );
  }
}
