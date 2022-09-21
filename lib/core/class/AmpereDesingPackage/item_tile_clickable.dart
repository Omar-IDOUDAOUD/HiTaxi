import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hitaxi/core/constants/animation.dart';
import 'package:hitaxi/core/constants/constants.dart';

class AmpereItemRowClickable extends StatefulWidget {
  AmpereItemRowClickable(
      {Key? key, required this.child, this.onTap, this.radius = 0})
      : super(key: key);
  final Widget child;
  final Function()? onTap;
  final double radius;
  @override
  State<AmpereItemRowClickable> createState() => AmpereItemRowClickableState();
}

class AmpereItemRowClickableState extends State<AmpereItemRowClickable> {
  bool _isFocused = false;
  @override
  Widget build(BuildContext context) {
  
    return GestureDetector(
      onTapDown: (dts) {
        setState(() {
          _isFocused = true;
        });
      },
      onTapUp: (dts) {
        setState(() {
          _isFocused = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isFocused = false;
        });
      },
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 50),
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: _isFocused ? Colors.grey.withOpacity(.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(widget.radius),
        ),
        alignment: Alignment.center,
        child: AnimatedScale(
            duration: Duration(milliseconds: 50),
            scale: _isFocused ? .95 : 1,
            alignment: Alignment.center,
            child: widget.child),
      ),
    );
  }
}
