import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/clickable.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/loading_indicator.dart';
import 'package:hitaxi/core/constants/animation.dart';
import 'package:hitaxi/core/constants/color.dart';
import 'package:hitaxi/core/constants/font.dart';
import 'package:hitaxi/core/constants/size.dart';

class AmpereButton extends StatefulWidget {
  AmpereButton({
    Key? key,
    required this.label,
    this.suffixIconPath,
    required this.onTap,
    this.isLoading = false,
    this.height = SizesCst.ssg,
    this.color,
    this.textColor,
  }) : super(key: key) {
    this.color ??= ColorsCst.clrab;
    this.textColor ??= Colors.white;
  }
  final String label;
  final String? suffixIconPath;
  final VoidCallback onTap;
  final bool isLoading;
  final double height;
  Color? color;
  Color? textColor;
  @override
  AmpereButtonState createState() => AmpereButtonState();
}

class AmpereButtonState extends State<AmpereButton> {
  @override
  Widget build(BuildContext context) {
    return AmpereClickable(
        onTap: widget.onTap,
        builder: (focus) {
          return AnimatedScale(
            scale: focus ? .9 : 1,
            duration: AnimationsCst.adrb,
            curve: AnimationsCst.acra,
            child: PhysicalModel(
              color: Colors.transparent,
              shape: BoxShape.circle,
              elevation: 10,
              shadowColor: Colors.black54.withOpacity(.5),
              child: Container(
                height: widget.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SizesCst.rsa),
                  color: widget.color,
                ),
                padding: EdgeInsets.all(SizesCst.pmsd),
                child: widget.isLoading
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AmpereLoadingIndicator(),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(),
                          Expanded(
                            flex: 2,
                            child: Text(
                              widget.label,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: widget.textColor,
                                fontSize: SizesCst.ftsv,
                                // fontWeight: FontsCst.wfg,
                              ),
                            ),
                          ),
                          Expanded(
                            child: widget.suffixIconPath != null
                                ? AnimatedAlign(
                                    alignment: focus
                                        ? Alignment(-.4, 0)
                                        : Alignment(0, 0),
                                    duration: AnimationsCst.adrb,
                                    curve: AnimationsCst.acra,
                                    child: SvgPicture.asset(
                                      widget.suffixIconPath!,
                                      height: 20,
                                      color: widget.textColor,
                                    ),
                                  )
                                : SizedBox.shrink(),
                          ),
                        ],
                      ),
              ),
            ),
          );
        });
  }
}
