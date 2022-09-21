import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hitaxi/core/constants/constants.dart';

class BottomSheetScreen {
  BottomSheetScreen(Widget child, {BottomSheetTopBar? topBar}) {
    print(Get.bottomBarHeight);
    Get.bottomSheet(
      _BottomSheet(child: child, topBar: topBar),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      backgroundColor: Get.theme.backgroundColor,
    );
  }

  static void hide() {
    if (Get.isBottomSheetOpen ?? false) Get.back();
  }
}

enum SheetTopBarRecommandedExitOptions {
  confirm,
  discard,
}

class BottomSheetTopBar {
  final bool? hasDiscard;
  final bool? hasConfirm;
  final SheetTopBarRecommandedExitOptions? recommandedOption;
  final String title;
  final Function()? onConfirm;
  final Function()? onDiscard;
  final String? confirmeIconPath;
  final String? discardIconPath;
  final bool? withTopResizeBars;
  BottomSheetTopBar({
    this.hasDiscard = true,
    this.hasConfirm = true,
    this.recommandedOption = SheetTopBarRecommandedExitOptions.discard,
    required this.title,
    this.onConfirm,
    this.onDiscard,
    this.confirmeIconPath = 'assets/icons/checkmark-outline.svg',
    this.discardIconPath = 'assets/icons/close-outline.svg',
    this.withTopResizeBars = true,
  });
}

class _BottomSheet extends StatefulWidget {
  const _BottomSheet({Key? key, required this.child, this.topBar})
      : super(key: key);

  final Widget child;
  final BottomSheetTopBar? topBar;

  @override
  State<_BottomSheet> createState() => __BottomSheetState();
}



class __BottomSheetState extends State<_BottomSheet> {
  final _greyColor = Colors.grey.withOpacity(.2);
  final _greyFocusColor = Colors.grey.withOpacity(.4);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(SizesCst.ssd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.topBar != null) ...[
              widget.topBar!.withTopResizeBars!
                  ? Column(
                      children: [
                        _getResizeingBar(40),
                        SizedBox(
                          height: 3,
                        ),
                        _getResizeingBar(20),
                      ],
                    )
                  : SizedBox.shrink(),
              Row(
                children: [
                  widget.topBar!.hasDiscard!
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: SizedBox.square(
                            dimension: 45,
                            child: MaterialButton(
                              hoverElevation: 0,
                              elevation: 0,
                              highlightElevation: 0,
                              splashColor: _greyFocusColor,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              color: widget.topBar!.recommandedOption ==
                                      SheetTopBarRecommandedExitOptions.discard
                                  ? _greyColor
                                  : Colors.transparent,
                              onPressed: widget.topBar!.onDiscard,
                              child: SvgPicture.asset(
                                widget.topBar!.discardIconPath!,
                                color: Get.theme.colorScheme.primary,
                              ),
                              shape: CircleBorder(),
                            ),
                          ),
                        )
                      : SizedBox.square(
                          dimension: 45,
                        ),
                  Expanded(
                    flex: 5,
                    child: Center(
                      child: Text(
                        widget.topBar!.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Get.theme.colorScheme.primary,
                          fontSize: SizesCst.ftsv,
                          fontWeight: FontsCst.wfg,
                        ),
                      ),
                    ),
                  ),
                  widget.topBar!.hasConfirm!
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: SizedBox.square(
                            dimension: 45,
                            child: MaterialButton(
                              hoverElevation: 0,
                              elevation: 0,
                              highlightElevation: 0,
                              splashColor: _greyFocusColor,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              color: widget.topBar!.recommandedOption ==
                                      SheetTopBarRecommandedExitOptions.confirm
                                  ? _greyColor
                                  : Colors.transparent,
                              onPressed: widget.topBar!.onConfirm,
                              child: SvgPicture.asset(
                                widget.topBar!.confirmeIconPath!,
                                color: Get.theme.colorScheme.primary,
                              ),
                              shape: CircleBorder(),
                            ),
                          ),
                        )
                      : SizedBox(
                          width: 45,
                          child: ColoredBox(color: Colors.green),
                        ),
                ],
              )
            ],
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: widget.child,
            )
          ],
        ),
      ),
    );
  }

  Widget _getResizeingBar(double w) => SizedBox(
        height: 4,
        width: w,
        child: Container(
          decoration: BoxDecoration(
            color: _greyColor,
            borderRadius: BorderRadius.circular(2.5),
          ),
        ),
      );
}
