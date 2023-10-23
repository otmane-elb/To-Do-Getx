import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todogetx/app/core/utils/extensions.dart';
import 'package:todogetx/app/data/models/task.dart';
import 'package:todogetx/app/modules/home/controller.dart';
import 'package:todogetx/app/widgets/icons.dart';

class AddCard extends StatelessWidget {
  final homCtrl = Get.find<HomeController>();
  AddCard({super.key});

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var squarWidth = Get.width - 12.0.wp;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      height: squarWidth / 2,
      width: squarWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
              titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
              radius: 5,
              title: "Task Type",
              content: Form(
                key: homCtrl.formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                      child: TextFormField(
                        controller: homCtrl.editController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Title"),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter your Task title ";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0.wp),
                      child: Wrap(
                        spacing: 2.0.wp,
                        children: icons
                            .map((e) => Obx(() {
                                  final index = icons.indexOf(e);

                                  return SizedBox(
                                    width:
                                        20.0.wp, // Adjust the width as needed
                                    child: ChoiceChip(
                                      selectedColor: Colors.greenAccent,
                                      pressElevation: 0,
                                      backgroundColor: Colors.white,
                                      label: e,
                                      selected:
                                          homCtrl.chipIndex.value == index,
                                      onSelected: (bool selected) {
                                        homCtrl.chipIndex.value =
                                            selected ? index : 0;
                                      },
                                    ),
                                  );
                                }))
                            .toList(),
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            minimumSize: const Size(150, 50)),
                        onPressed: () {
                          if (homCtrl.formKey.currentState!.validate()) {
                            int icon =
                                icons[homCtrl.chipIndex.value].icon!.codePoint;
                            String color =
                                icons[homCtrl.chipIndex.value].color!.toHex();
                            var task = Task(
                                title: homCtrl.editController.text,
                                icon: icon,
                                color: color);
                            Get.back();
                            homCtrl.addTask(task)
                                ? EasyLoading.showSuccess(
                                    "Task added succsefully")
                                : EasyLoading.showError("Task already exists");
                          }
                        },
                        child: const Text("Confirm"))
                  ],
                ),
              ));
          homCtrl.editController.clear();
          homCtrl.changeChipIndex(0);
        },
        child: DottedBorder(
          dashPattern: const [5],
          strokeWidth: 2,
          color: Colors.grey[400]!,
          child: const Center(
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
