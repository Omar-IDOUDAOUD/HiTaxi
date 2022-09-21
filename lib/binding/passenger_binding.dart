import 'package:get/get.dart';
import 'package:hitaxi/controller/main/passenger_controller.dart';

class PassengerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PassengerController>(() => PassengerController());
  }
}
