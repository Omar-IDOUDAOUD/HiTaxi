import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/loading_indicator.dart';

class WaitingScreen {
  static void start() {
    Get.generalDialog(
      pageBuilder: (context, animation, animation2) => Center(
        child: AmpereLoadingIndicator(),
      ),
    );
  }

  static void stop(){
    if (Get.isDialogOpen ?? false) Get.back(); 
  }
}
