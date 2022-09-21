import 'package:get/get.dart';
import 'package:hitaxi/controller/authentication/singin_controller.dart';

class SingInBinging implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SingInController>(() => SingInController());
    print("binding test.");
  }
}
