import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hitaxi/core/constants/animation.dart';
import 'package:hitaxi/core/constants/color.dart';
import 'package:hitaxi/core/constants/font.dart';
import 'package:hitaxi/core/constants/size.dart';

class AmpereSingTopBar extends StatefulWidget {
  /// this widget needs three images assets in "assets/images/" they names are:
  ///  1."singin_top_bar_ass"
  ///  2.online_taxi_image1.png
  ///  3.online_taxi_image2.png
  const AmpereSingTopBar({
    Key? key,
    required this.title,
    required this.titleIconPath,
    required this.additionText,
    required this.additionTextLink,
    required this.barColor,
    required this.additionTextLinkTap,
    this.additionTextLinkIconPath,
    this.isRegester = true,
  }) : super(key: key);
  final String title;
  final String titleIconPath;
  final String additionText;
  final String additionTextLink;
  final String? additionTextLinkIconPath;
  final VoidCallback additionTextLinkTap;
  final Color barColor;
  final bool isRegester;

  @override
  State<AmpereSingTopBar> createState() => _AmpereSingTopBarState();
}

class _AmpereSingTopBarState extends State<AmpereSingTopBar> {
  bool _isAdditionTextLinkDFocused = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.surface.withOpacity(.05),
        border: Border.all(
          color: Get.theme.colorScheme.surface.withOpacity(.1),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(SizesCst.rsa),
      ),
      clipBehavior: Clip.none,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            child: Image.asset(
              "assets/images/singin_top_bar_ass.png",
              height: 90,
            ),
          ),
          Positioned(
            bottom: -10,
            right: 0,
            child: Image.asset(
              widget.isRegester
                  ? "assets/images/online_taxi_image1.png"
                  : "assets/images/online_taxi_image2.png",
              height: 55,
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            top: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: SizesCst.ftsf,
                        fontWeight: FontsCst.wfb,
                        color: Get.theme.colorScheme.surface,
                      ),
                    ),
                    SvgPicture.asset(
                      widget.titleIconPath,
                      height: 30,
                      color: Get.theme.colorScheme.primary,
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.additionText,
                  style: TextStyle(
                    height: 1.2,
                    fontSize: SizesCst.ftsc,
                    color: Get.theme.colorScheme.surface,
                    fontWeight: FontsCst.wfb,
                  ),
                ),
                GestureDetector(
                  onTap: widget.additionTextLinkTap,
                  onTapUp: (det) {
                    print("up");
                    setState(() {
                      _isAdditionTextLinkDFocused = false;
                    });
                  },
                  onTapDown: (det) {
                    print("down");
                    setState(() {
                      _isAdditionTextLinkDFocused = true;
                    });
                  },
                  onTapCancel: () {
                    setState(() {
                      _isAdditionTextLinkDFocused = false;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.additionTextLink,
                        style: TextStyle(
                          height: 1.2,
                          fontSize: SizesCst.ftsc,
                          color: ColorsCst.clrcl,
                          fontWeight: FontsCst.wfb,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (widget.additionTextLinkIconPath != null)
                        SvgPicture.asset(
                          widget.additionTextLinkIconPath!,
                          height: 17,
                          color: ColorsCst.clrcl,
                        )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
