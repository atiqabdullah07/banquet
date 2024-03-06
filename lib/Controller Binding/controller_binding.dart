import 'package:banquet/Controllers/customer_controller.dart';
import 'package:get/get.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    // Get.put(AuthController());
    Get.put(CustomerController());
  }
}
