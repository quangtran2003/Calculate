import 'package:get/get.dart';

import '../calculate_controller/calculate_controller.dart';

class CalculateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CalculateController());
  }
}
