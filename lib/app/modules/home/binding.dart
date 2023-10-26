import 'package:get/get.dart';
import 'package:todogetx/app/data/providers/task/provider.dart';
import 'package:todogetx/app/data/services/storage/repository.dart';
import 'package:todogetx/app/modules/home/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(
        taskRepository: TaskRepository(taskProvider: TaskProvider())));
  }
}
