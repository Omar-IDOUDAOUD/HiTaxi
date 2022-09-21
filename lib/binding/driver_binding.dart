import 'package:get/get.dart'; 
import 'package:hitaxi/controller/main/driver_controller.dart';

class DriverBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverController>(() => DriverController());
  }
}
