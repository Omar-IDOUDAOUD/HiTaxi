import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitaxi/core/constants/animation.dart';
import 'package:hitaxi/core/constants/color.dart';
import 'package:hitaxi/core/constants/font.dart';
import 'package:hitaxi/core/constants/size.dart';

class AmpereDilaogButton extends StatefulWidget {
  const AmpereDilaogButton(
      {Key? key,
      required this.recommandedOption,
      required this.label,
      required this.onTap})
      : super(key: key);

  final bool recommandedOption;
  final String label;
  final VoidCallback onTap;

  @override
  State<AmpereDilaogButton> createState() => _AmpereDilaogButtonState();
}

class _AmpereDilaogButtonState extends State<AmpereDilaogButton> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      onTapDown: (dest) {
        setState(() {
          _isFocused = true;
        });
      },
      onTapUp: (dets) {
        setState(() {
          _isFocused = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isFocused = false;
        });
      },
      child: AnimatedContainer(
        duration: AnimationsCst.adrb,
        curve: AnimationsCst.acra,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          color: _isFocused
              ? Get.theme.colorScheme.surface.withOpacity(.15)
              : null,
          border: _isFocused
              ? Border.all(color: Colors.transparent, width: SizesCst.bsa)
              : widget.recommandedOption
                  ? Border.all(color: ColorsCst.clrm, width: SizesCst.bsa)
                  : Border.all(color: Colors.transparent, width: SizesCst.bsa),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          widget.label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: SizesCst.ftsv,
            fontWeight: FontsCst.wfg,
            color: Get.theme.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
