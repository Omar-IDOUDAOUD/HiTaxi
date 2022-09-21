import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/dialg_button.dart';
import 'package:hitaxi/core/constants/animation.dart';
import 'package:hitaxi/core/constants/size.dart';

enum DialogRecommendedOption {
  confirm,
  discard,
}

class DialogScreen {
  DialogScreen(
    Widget content, {
    bool barrierDismissible = true,
    Duration transitionDuration = AnimationsCst.adrb,
    bool hasConfirm = true,
    bool? hasDiscard = false,
    VoidCallback? onConfirm,
    VoidCallback? onDiscard,
    DialogRecommendedOption? recommendedOption,
    String? confirmLabel,
    String? discardLabel,
    double? padding = SizesCst.ssb,
    double scaleAnimationFrom = .5, 
    AlignmentGeometry? alignment = Alignment.center,
  })  : assert(hasConfirm && confirmLabel != null ||
            !hasConfirm && confirmLabel == null),
        assert(hasDiscard! && discardLabel != null ||
            !hasDiscard && discardLabel == null) {
    onConfirm ??= () {};
    onDiscard ??= () {};
    Get.dialog(
      TweenAnimationBuilder<double>(
        tween: Tween(begin:scaleAnimationFrom, end: 1),
        duration: transitionDuration,
        curve: AnimationsCst.acrb,
        builder: (context, v, c) => Transform.scale(
          scale: v,
          child: Dialog(
            child: Padding(
              padding: EdgeInsets.all(SizesCst.ssa),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  content,
                  Row(
                    children: [
                      hasDiscard!
                          ? Expanded(
                              child: AmpereDilaogButton(
                                label: discardLabel!,
                                onTap: onDiscard!,
                                recommandedOption: recommendedOption ==
                                    DialogRecommendedOption.discard,
                              ),
                            )
                          : SizedBox.shrink(),
                      if (hasDiscard)
                        SizedBox(
                          width: 10,
                        ),
                      hasConfirm
                          ? Expanded(
                              child: AmpereDilaogButton(
                                label: confirmLabel!,
                                onTap: onConfirm!,
                                recommandedOption: recommendedOption ==
                                    DialogRecommendedOption.confirm,
                              ),
                            )
                          : SizedBox.shrink(),
                    ],
                  )
                ],
              ),
            ),
            // child: SizedBox(
            //   height: 200,
            // ),
            insetPadding: EdgeInsets.all(padding!),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(SizesCst.rsb),
            ),
            clipBehavior: Clip.antiAlias,
            elevation: 20,
            alignment: alignment,

            // backgroundColor: Get.theme.backgroundColor,
          ),
        ),
      ),
      useSafeArea: false,
      barrierDismissible: barrierDismissible,
      transitionDuration: transitionDuration,
    );
  }

  static void stop() {
    if (Get.isDialogOpen ?? false) Get.back();
  }
}
