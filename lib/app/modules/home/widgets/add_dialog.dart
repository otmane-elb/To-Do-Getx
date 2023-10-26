import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todogetx/app/core/utils/extensions.dart';
import 'package:todogetx/app/modules/home/home_controller.dart';

class AddDialog extends StatelessWidget {
  final homectrl = Get.find<HomeController>();
  AddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: homectrl.formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(2.0.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Get.back();
                      homectrl.editController.clear();
                      homectrl.changeTask(null);
                    },
                  ),
                  TextButton(
                      style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent)),
                      onPressed: () {
                        if (homectrl.formKey.currentState!.validate()) {
                          if (homectrl.task.value == null) {
                            EasyLoading.showError("Please select a task");
                          } else {
                            var success = homectrl.updateTask(
                                homectrl.task.value!,
                                homectrl.editController.text);
                            if (success) {
                              EasyLoading.showSuccess(
                                  "Task added successfully");
                              Get.back();
                              homectrl.changeTask(null);
                            } else {
                              EasyLoading.showError("Task already exists");
                            }
                            homectrl.editController.clear();
                          }
                        }
                      },
                      child: Text(
                        "Done",
                        style: TextStyle(fontSize: 14.0.sp, color: Colors.blue),
                      ))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: Text(
                "New Task ",
                style:
                    TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: TextFormField(
                controller: homectrl.editController,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                ),
                autofocus: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your task ";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 5.0.wp, top: 5.0.wp, right: 5.0.wp, bottom: 2.0.wp),
              child: Text(
                "Add to",
                style: TextStyle(fontSize: 14.0.sp, color: Colors.grey),
              ),
            ),
            ...homectrl.tasks
                .map(
                  (element) => Obx(
                    () => InkWell(
                      onTap: () => homectrl.changeTask(element),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.0.wp, vertical: 1.0.hp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  IconData(element.icon,
                                      fontFamily: "MaterialIcons"),
                                  color: HexColor.fromHex(element.color),
                                  size: 7.0.wp,
                                ),
                                SizedBox(
                                  width: 2.0.wp,
                                ),
                                Text(
                                  element.title,
                                  style: TextStyle(
                                      fontSize: 13.0.sp,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                            if (homectrl.task.value == element)
                              const Icon(
                                Icons.check,
                                color: Colors.blue,
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList()
          ],
        ),
      ),
    );
  }
}
