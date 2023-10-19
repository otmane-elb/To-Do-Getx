import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todogetx/app/core/utils/extensions.dart';
import 'package:todogetx/app/data/models/task.dart';
import 'package:todogetx/app/modules/home/controller.dart';

class TaskCard extends StatelessWidget {
  final Homectrl = Get.find<HomeController>();
  final Task task;
  TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    var squarWidth = Get.width - 12.0.wp;

    return Container();
  }
}
