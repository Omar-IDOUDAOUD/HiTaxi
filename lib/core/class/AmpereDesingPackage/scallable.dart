import 'package:flutter/cupertino.dart';
import 'package:hitaxi/core/constants/animation.dart';

class Scallable extends StatefulWidget {
  Function _f = () {};
  Scallable(
      {Key? key,
      required this.child,
      this.maxScaleValue = 1,
      this.minScaleValue = .9,
      this.duration = AnimationsCst.adrb,
      this.curve = AnimationsCst.acra,
      this.onLongPressStart,
      this.onLongPressEnd,
      this.onTap})
      : super(key: key) {
    onTap ??= _f;
    onLongPressStart ??= _f;
    onLongPressEnd ??= _f;
  }
  final Widget child;
  final double maxScaleValue;
  final double minScaleValue;
  final Duration duration;
  final Curve curve;
  Function? onTap;
  Function? onLongPressStart;
  Function? onLongPressEnd;

  @override
  State<Scallable> createState() => _ScallableState();
}

class _ScallableState extends State<Scallable> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (det) {
        print("up");
        // if (_canScaleToDef)
        setState(() {
          print("case 1 ");
          _isFocused = false;
        });
      },
      onTapDown: (det) {
        print("down");
        setState(() {
          _isFocused = true;
        });
      },
      onTap: () {
        widget.onTap!();
      },
      onTapCancel: () {
        setState(() {
          print("case 2 ");
          _isFocused = false;
        });
      },
      onLongPress: () {
        setState(() {
          _isFocused = true;
        });
        widget.onLongPressStart!();
      },
      onLongPressUp: () {
        setState(() {
          _isFocused = false;
        });
        widget.onLongPressEnd!();
      },
      child: AnimatedScale(
        duration: widget.duration,
        scale: _isFocused ? widget.minScaleValue : widget.maxScaleValue,
        child: widget.child,
      ),
    );
  }
}
