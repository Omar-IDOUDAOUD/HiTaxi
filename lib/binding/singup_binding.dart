import 'package:get/get.dart'; 
import 'package:hitaxi/controller/authentication/singup_controller.dart';

class SingUpBinging implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SingUpController()); 
  }
}
