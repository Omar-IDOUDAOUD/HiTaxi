import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/scallable.dart';

class AmpereSquareButton extends StatelessWidget {
  final Function? onTap;
  final String iconPath;
  final Color color;
  final Function? onLongPressStart;
  final Function? onLongPressEnd;
  /**this argument accepte from 0 to 1 value */
  final double sizeFactor;

  const AmpereSquareButton({
    super.key,
    required this.iconPath,
    required this.onTap,
    required this.color,
    this.onLongPressStart,
    this.onLongPressEnd,
    this.sizeFactor = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Scallable(
      onTap: onTap,
      onLongPressStart: onLongPressStart,
      onLongPressEnd: onLongPressEnd,
      child: Transform.scale(
        scale: sizeFactor,
        child: SizedBox.square(
          dimension: 37.5 ,
          child: Card(
            margin: EdgeInsets.zero,
            elevation: 0,
            color: color.withOpacity(.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: SvgPicture.asset(
                iconPath,
                color: color,
                height: 25 * sizeFactor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
