import 'package:banquet/Controllers/auth_controller.dart';
import 'package:get/get.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    // Get.put(CommentsController());
    // Get.put(ProfileController());
  }
}
