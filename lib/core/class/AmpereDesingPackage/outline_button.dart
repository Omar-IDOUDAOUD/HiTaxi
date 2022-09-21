import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hitaxi/core/constants/animation.dart';
import 'package:hitaxi/core/constants/color.dart';
import 'package:hitaxi/core/constants/font.dart';
import 'package:hitaxi/core/constants/size.dart';

class AmpereOutlineButton extends StatefulWidget {
  AmpereOutlineButton(
      {Key? key,
      required this.iconPath,
      required this.label,
      required this.onTap})
      : super(key: key);

  final String iconPath;
  final String label;
  final VoidCallback onTap;

  @override
  State<AmpereOutlineButton> createState() => _AmpereOutlineButtonState();
}

class _AmpereOutlineButtonState extends State<AmpereOutlineButton> {
  bool _isFocussed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (det) {
        setState(() {
          _isFocussed = false;
        });
      },
      onTapDown: (det) {
        setState(() {
          _isFocussed = true;
        });
      },
      onTap: () {
        widget.onTap;
      },
      onTapCancel: () {
        setState(() {
          _isFocussed = false;
        });
      },
      child: AnimatedContainer(
        duration: AnimationsCst.adra,
        curve: AnimationsCst.acra,
        padding: EdgeInsets.symmetric(
            horizontal: _isFocussed ? 3 : 4.2, vertical: _isFocussed ? 1 : 2.2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border:
              Border.all(color: ColorsCst.clrm, width: _isFocussed ? 2.5 : 1.3),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              widget.iconPath,
              color: ColorsCst.clrm,
              height: 13,
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              widget.label,
              style: TextStyle(
                fontSize: SizesCst.ftsd,
                fontWeight: FontsCst.wfa,
                color: ColorsCst.clrm,
              ),
            )
          ],
        ),
      ),
    );
  }
}
