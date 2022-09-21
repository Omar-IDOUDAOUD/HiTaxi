import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hitaxi/core/constants/constants.dart';
import 'package:hitaxi/core/utils/assets_explorer.dart';

class AmpereSelectableCard<T> extends StatefulWidget {
  AmpereSelectableCard({
    Key? key,
    required this.label,
    this.id,
    this.prefexIconPath,
    this.onSelected,
    this.sharedValue,
  }) : super(key: key) {
    onSelected ??= (v) {};
  }

  final String label;
  final String? prefexIconPath;
  final T? id;
  final T? sharedValue;
  Function(dynamic id)? onSelected;

  @override
  State<AmpereSelectableCard> createState() => _AmpereSelectableCardState();
}

class _AmpereSelectableCardState extends State<AmpereSelectableCard> {
  bool _isFocus = false;

  @override
  Widget build(BuildContext context) {
    final isSelected = (widget.sharedValue ?? '1') == (widget.id ?? '2');
    final currentColor =
        isSelected ? ColorsCst.clrz : Get.theme.colorScheme.primary;
    return GestureDetector(
      onTap: () {
        widget.onSelected!(widget.id);
      },
      onTapDown: (dts) {
        setState(() {
          _isFocus = true;
        });
      },
      onTapUp: (dts) {
        setState(() {
          _isFocus = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isFocus = false;
        });
      },
      child: AnimatedContainer(
        foregroundDecoration: BoxDecoration(
          color:
              _isFocus ? Get.theme.colorScheme.surface.withOpacity(.2) : null,
          borderRadius: BorderRadius.circular(15),
        ),
        duration: _isFocus ? Duration(milliseconds: 20) : AnimationsCst.adrc,
        decoration: BoxDecoration(
          color: isSelected ? currentColor.withOpacity(.2) : null,
          borderRadius: BorderRadius.circular(15),
          border:
              Border.all(width: isSelected ? 2.5 : 1.5, color: currentColor),
        ),
        // transform: Matrix4.identity()..scale(_isFocus ? .9 : 1.0),
        // transformAlignment: Alignment.center,
        padding: EdgeInsets.all(isSelected ? 9 : 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.prefexIconPath != null) ...[
              SvgPicture.asset(
                widget.prefexIconPath!,
                color: currentColor,
                height: 23,
              ),
              SizedBox(
                width: 5,
              )
            ],
            AnimatedDefaultTextStyle(
              child: Text(widget.label),
              style: TextStyle(
                height: 1,
                fontSize: SizesCst.ftsv,
                color: currentColor,
                fontWeight: FontWeight.w500,
              ),
              duration:
                  _isFocus ? Duration(milliseconds: 20) : AnimationsCst.adrc,
            ),
          ],
        ),
      ),
    );
  }
}
