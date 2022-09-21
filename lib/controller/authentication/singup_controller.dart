import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/alert_dialog.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/loading_indicator.dart';
import 'package:hitaxi/core/constants/animation.dart';
import 'package:hitaxi/core/constants/route.dart';
import 'package:hitaxi/core/constants/validation_error.dart';
import 'package:hitaxi/core/shared/dialog_screen.dart';
import 'package:hitaxi/core/shared/waiting_screen.dart';
import 'package:image_picker/image_picker.dart';

class SingUpController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController typicalTravelsTypeFromPlaceController =
      TextEditingController();
  final TextEditingController typicalTravelsTypeToPlaceController =
      TextEditingController();
  final TextEditingController whatsappAccountLinkController =
      TextEditingController();
  final TextEditingController facebookAccountLinkController =
      TextEditingController();
  final TextEditingController instagramAccountLinkController =
      TextEditingController();
  final TextEditingController otherLinkController = TextEditingController();
  final TextEditingController emailVerificationController =
      TextEditingController();
  final ScrollController bodyScrollController = ScrollController();
  final PageController bodyPageController = PageController();

  String role = "DRIVER";
  RxString travelesType = "RANDOM".obs;
  File? avatarImage = null;
  List<String> _validatedInputes = [];

  @override
  void onClose() {
    // TODO: implement onClose
    this.emailController.dispose();
    this.passController.dispose();
    this.nameController.dispose();
    this.phoneNumberController.dispose();
    this.typicalTravelsTypeFromPlaceController.dispose();
    this.typicalTravelsTypeToPlaceController.dispose();
    this.whatsappAccountLinkController.dispose();
    this.facebookAccountLinkController.dispose();
    this.instagramAccountLinkController.dispose();
    this.otherLinkController.dispose();
    this.emailVerificationController.dispose();
    this.bodyScrollController.dispose();
    this.bodyPageController.dispose();
    super.dispose();
  }

  void _goMain() {
    var routeTarget =
        role == "DRIVER" ? RoutesCst.mainDriver : RoutesCst.mainPassenger;
    Get.offAllNamed(routeTarget);
  }

  void next() async {
    ///
    print(bodyPageController.page);
    if (bodyPageController.page == 0) {
      if (_checkLogicalOperations()) {
        WaitingScreen.start();
        /* send reqeust */;
        await Future.delayed(Duration(seconds: 3));
        WaitingScreen.stop();
        /* preocess req response... */
        /* if all is well: */
        Get.focusScope!.unfocus();
        await bodyScrollController.animateTo(
          0,
          duration: Duration(seconds: 1),
          curve: AnimationsCst.acra,
        );
        await bodyPageController.animateToPage(
          1,
          duration: AnimationsCst.adra,
          curve: AnimationsCst.acra,
        );
      }
    } else if (bodyPageController.page == 1) {
      if (_checkLogicalOperations()) {
        WaitingScreen.start();
        // send this code to server:
        // emailVerificationController.text.substring(0, 4);
        await Future.delayed(Duration(seconds: 5));
        WaitingScreen.stop();
      }
    }
    //go to main after verification of code;
  }

  void goSingIn() {
    Get.offAndToNamed(RoutesCst.singin);
  }

  bool _checkLogicalOperations() {
    if (_validatedInputes.indexOf("NAME") >= 0 &&
        _validatedInputes.indexOf("EMAIL") >= 0 &&
        _validatedInputes.indexOf("PASS") >= 0 &&
        _validatedInputes
            .where((element) => element.contains("COMMUNICATION-LINK"))
            .isNotEmpty) {
      if (travelesType == "TYPICAL" &&
          typicalTravelsTypeFromPlaceController.text.isEmpty &&
          typicalTravelsTypeToPlaceController.text.isEmpty)
        travelesType = "RANDOM".obs;

      if (bodyPageController.page == 1) {
        var s = emailVerificationController.text.substring(0, 4);
        if (s.isNumericOnly)
          return true;
        else {
          DialogScreen(
            AmpereAlertDialog(
              title: "code not validated",
              descreption: "recheck your entered verification code.",
              type: AmpereAlertTypes.fail,
            ),
            confirmLabel: "Ok",
            onConfirm: () {
              DialogScreen.stop();
            },
          );
          return false;
        }
      }
      return true;
    }
    DialogScreen(
      AmpereAlertDialog(
        title: "fields not validated",
        descreption:
            "first you must valid all list fields, and then you can to next.",
        type: AmpereAlertTypes.fail,
      ),
      barrierDismissible: bodyPageController.page != 1,
      confirmLabel: "Ok",
      onConfirm: () {
        DialogScreen.stop();
        bodyPageController.animateTo(1,
            duration: AnimationsCst.adrb, curve: AnimationsCst.acra);
      },
    );
    return false;
  }

  void setAvatar(ImageSource source) {
    // avatar setting
  }

  void setRole(String role) {
    this.role = role;
  }

  void setTravelesType(String type) {
    // FocusScope.of(Get.context!).unfocus();
    Get.focusScope!.unfocus();
    this.travelesType.value = type;
  }

  // Fields validators
  _nameValidator() {
    var l = nameController.text.split(' ');
    if (nameController.text.isEmpty)
      return ValidationErrorsCst.userNameNotTyped;
    else if (l.length == 2 || l.length == 1) {
      if (!GetUtils.isUsername(l.first))
        return ValidationErrorsCst.userNameIncorrect;
      if (!GetUtils.isUsername(l.last))
        return ValidationErrorsCst.userNameIncorrect;
      return;
    }
    return ValidationErrorsCst.userNameIncorrect;
  }

  Map<String, String>? nameValidator() {
    var res = this._nameValidator();
    if (res == null)
      this._validatedInputes.add("NAME");
    else
      this._validatedInputes.removeWhere((s) => s == "NAME");
    return res;
  }

  _emailValidator() {
    if (emailController.text.isEmpty)
      return ValidationErrorsCst.emailNotTyped;
    else if (!emailController.text.isEmail)
      return ValidationErrorsCst.emailIncorrect;
    return;
  }

  Map<String, String>? emailValidator() {
    var res = this._emailValidator();
    if (res == null)
      this._validatedInputes.add("EMAIL");
    else
      this._validatedInputes.removeWhere((s) => s == "EMAIL");
    return res;
  }

  _passValidator() {
    if (passController.text.isEmpty)
      return ValidationErrorsCst.passwordNotTyped;
    else if (passController.text.length < 8)
      return ValidationErrorsCst.passwordSmall;
    return;
  }

  Map<String, String>? passValidator() {
    var res = this._passValidator();
    if (res == null)
      this._validatedInputes.add("PASS");
    else
      this._validatedInputes.removeWhere((s) => s == "PASS");
    return res;
  }

  _phoneNumberValidator() {
    if (phoneNumberController.text.isEmpty)
      return ValidationErrorsCst.phoneNumberNotTyped;
    else if (phoneNumberController.text.length < 15 ||
        phoneNumberController.text.length > 8) {
      if (phoneNumberController.text.startsWith('+'))
        phoneNumberController.text.replaceFirst('+', '');
      try {
        int.parse(phoneNumberController.text);
        if (phoneNumberController.text.length > 15 ||
            phoneNumberController.text.length < 8)
          return ValidationErrorsCst.phoneNumberIncorrect;
      } catch (e) {
        return ValidationErrorsCst.phoneNumberIncorrect;
      }
    }
    return;
  }

  Map<String, String>? phoneNumberValidator() {
    var res = this._phoneNumberValidator();
    if (res == null)
      this._validatedInputes.add("PHONE-NUMBER");
    else
      this._validatedInputes.removeWhere((s) => s == "PHONE-NUMBER");
    return res;
  }

  _linkValidator(String? webSiteName, TextEditingController controller) {
    if (controller.text.isEmpty)
      return;
    else if (!controller.text.isURL)
      return ValidationErrorsCst.linkIncorrect(webSiteName);
    else if (webSiteName != null) if (!controller.text
        .contains("www.$webSiteName.com/"))
      return ValidationErrorsCst.linkIncorrect(webSiteName);
    return;
  }

  Map<String, String>? linkValidator(
      String? webSiteName, TextEditingController controller) {
    var res = this._linkValidator(webSiteName, controller);
    if (res == null)
      this._validatedInputes.add("COMMUNICATION-LINK-$webSiteName");
    else
      this
          ._validatedInputes
          .removeWhere((s) => s == "COMMUNICATION-LINK-$webSiteName");
    return res;
  }
}
