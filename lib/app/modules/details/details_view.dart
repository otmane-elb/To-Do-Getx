import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todogetx/app/core/utils/extensions.dart';
import 'package:todogetx/app/modules/details/widgets/doing_list.dart';
import 'package:todogetx/app/modules/details/widgets/done_list.dart';
import 'package:todogetx/app/modules/home/home_controller.dart';

class DetailPage extends StatelessWidget {
  final homectrl = Get.find<HomeController>();
  DetailPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var task = homectrl.task.value!;
    var color = HexColor.fromHex(task.color);
    return WillPopScope(
      onWillPop: () async {
        homectrl.updateTodos();
        homectrl.changeTask(null);
        homectrl.editController.clear();
        return true;
      },
      child: Scaffold(
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
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Get.back();
                        homectrl.updateTodos();
                        homectrl.changeTask(null);
                        homectrl.editController.clear();
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                child: Row(
                  children: [
                    Icon(
                      IconData(
                        task.icon,
                        fontFamily: 'MaterialIcons',
                      ),
                      color: color,
                      size: 12.0.wp,
                    ),
                    SizedBox(
                      width: 3.0.wp,
                    ),
                    Text(
                      task.title,
                      style: TextStyle(
                          fontSize: 17.0.sp, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Obx(() {
                var totalTodos =
                    homectrl.doingtodos.length + homectrl.doneTodos.length;
                return Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 3.0.hp, horizontal: 16.0.wp),
                  child: Row(
                    children: [
                      Text(
                        "${totalTodos.toString()} Tasks",
                        style: TextStyle(fontSize: 12.0.sp, color: Colors.grey),
                      ),
                      SizedBox(
                        width: 3.0.wp,
                      ),
                      Expanded(
                        child: StepProgressIndicator(
                          totalSteps: totalTodos == 0 ? 1 : totalTodos,
                          currentStep: homectrl.doneTodos.length,
                          size: 5,
                          padding: 0,
                          selectedGradientColor: LinearGradient(
                              colors: [color.withOpacity(0.5), color],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          unselectedGradientColor: const LinearGradient(
                              colors: [Colors.grey, Colors.grey],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                        ),
                      )
                    ],
                  ),
                );
              }),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.0.wp, vertical: 2.0.hp),
                child: TextFormField(
                  controller: homectrl.editController,
                  autofocus: true,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    prefixIcon: Icon(
                      Icons.check_box_outline_blank_outlined,
                      color: Colors.grey,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (homectrl.formKey.currentState!.validate()) {
                          var success =
                              homectrl.addTodo(homectrl.editController.text);
                          if (success) {
                            EasyLoading.showSuccess('Task added successfully');
                          } else {
                            EasyLoading.showError("Task already exist ");
                          }
                          homectrl.editController.clear();
                        }
                      },
                      icon: Icon(Icons.done),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter something";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              DoingList(),
              DoneList()
            ],
          ),
        ),
      ),
    );
  }
}
