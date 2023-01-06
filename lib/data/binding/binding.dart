import 'package:get/get.dart';
import '../controller/controller.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ControllerLogic());
  }
}
