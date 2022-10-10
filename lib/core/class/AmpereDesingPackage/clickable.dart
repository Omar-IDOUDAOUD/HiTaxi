import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

typedef _builder = Widget Function(bool isFocus);

class AmpereClickable extends StatefulWidget {
  const AmpereClickable({
    Key? key,
    required this.builder,
    this.onTap,
    this.onLongPress,
    this.onLongPressStart,
    this.onLongPressEnd,
  }) : super(key: key);
  final _builder builder;
  final Function()? onTap;
  final Function()? onLongPress;
  final Function(LongPressStartDetails details)? onLongPressStart;
  final Function(LongPressEndDetails details)? onLongPressEnd;

  @override
  State<AmpereClickable> createState() => _AmpereClickableState();
}

class _AmpereClickableState extends State<AmpereClickable> {
  bool _isFocus = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTapDown: (dts) => setState(() {
      //   _isFocus = true;
      // }),
      // onTapUp: (dts) => setState(() {
      //   _isFocus = false;
      // }),
      onTapCancel: widget.onLongPress == null
          ? () => setState(() {
                _isFocus = false;
              })
          : null,
      onTap: widget.onTap,
      onLongPressStart: widget.onLongPressStart,
      onLongPressEnd: widget.onLongPressEnd,
      onLongPressDown: (dts) => setState(() {
        _isFocus = true;
      }),
      onLongPressUp: () => setState(() {
        _isFocus = false;
      }),
      onLongPressCancel: () => setState(() {
        _isFocus = false;
      }),
      onLongPress: widget.onLongPress,
      child: widget.builder(_isFocus),
    );
  }
}
