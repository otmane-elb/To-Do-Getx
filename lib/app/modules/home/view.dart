import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todogetx/app/modules/home/controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Home page"),
      ),
    );
  }
}
