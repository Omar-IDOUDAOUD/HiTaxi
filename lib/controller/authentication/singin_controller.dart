import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hitaxi/core/constants/route.dart';

class SingInController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  void onClose() {
    // TODO: implement onClose
    this.emailController.dispose();
    this.passController.dispose();
    super.onClose();
  }

  void _goMain(String user_role) {
    var routeTarget =
        user_role == "DRIVER" ? RoutesCst.mainDriver : RoutesCst.mainPassenger;
    Get.offAllNamed(routeTarget);
  }

  void next() {
    /* send request */
    _goMain("PASSENGER");
  }

  void goSingUp() {
    Get.back(); 
  }
}
