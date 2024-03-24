import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todogetx/app/core/utils/extensions.dart';
import 'package:todogetx/app/data/services/storage/services.dart';
import 'package:todogetx/app/modules/home/binding.dart';

import 'app/modules/home/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure widgets are initialized
  await GetStorage.init(); // Initialize GetStorage
  await Get.putAsync(
      () => StorageService().init()); // Initialize StorageService
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To do app',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: Future.delayed(const Duration(milliseconds: 500)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: Image.asset(
                  "assets/task.png",
                  fit: BoxFit.cover,
                  width: 65.0.wp,
                ),
              ),
            );
          } else {
            return const HomePage();
          }
        },
      ),
      initialBinding: HomeBinding(),
      builder: EasyLoading.init(),
    );
  }
}
