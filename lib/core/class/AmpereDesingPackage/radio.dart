import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitaxi/core/constants/animation.dart';

typedef _OnSelected<T> = Function(T value);

class AmpereRadio<T> extends StatefulWidget {
  AmpereRadio({
    Key? key,
    required this.sharedValue,
    required this.id,
    this.onSelected,
  }) : super(key: key) {
    onSelected ??= (v) {};
  }
  final T id;
  dynamic onSelected;
  final T sharedValue;

  @override
  State<AmpereRadio> createState() => _AmpereRadioState();
}

class _AmpereRadioState extends State<AmpereRadio> {
  final _color = Get.theme.colorScheme.primary;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onSelected(widget.id);
      },
      child: SizedBox.square(
        dimension: 20,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(width: 1.5, color: _color),
            shape: BoxShape.circle,
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Builder(
              builder: (context) {
                final double demension =
                    widget.sharedValue == widget.id ? 10 : 2;
                final Color color = widget.sharedValue == widget.id
                    ? _color
                    : Colors.transparent;
                return AnimatedContainer(
                  height: demension,
                  width: demension,
                  curve: Cubic(0.175, 0.885, 0.32, 1.60),
                  duration: AnimationsCst.adrb,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
