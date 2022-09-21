

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hitaxi/core/constants/animation.dart';
import 'package:hitaxi/core/constants/color.dart';
import 'package:hitaxi/core/constants/font.dart';
import 'package:hitaxi/core/constants/size.dart';

class AmpereVerificationCodeField extends StatefulWidget {
  const AmpereVerificationCodeField(
      {Key? key, required this.onFinish, required this.fieldController})
      : super(key: key);

  final Function(int code) onFinish;
  final TextEditingController fieldController;
  @override
  State<AmpereVerificationCodeField> createState() =>
      _AmpereVerificationCodeFieldState();
}

class _AmpereVerificationCodeFieldState
    extends State<AmpereVerificationCodeField> {
  /// true: focused,
  /// false: unfocused.
  List<bool> _fields = [
    true,
    false,
    false,
    false,
    false,
  ];
  late ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    _scrollController = ScrollController()
      ..addListener(() {
        _scrollController.jumpTo(0);
      });
  }

  void _provider(String s) {
    if (s.length <= 5 && s.isNotEmpty) {
      for (var i = 0; i < s.length; i++) {
        var ss = s[i];
        if (!ss.isNumericOnly) {
          widget.fieldController.text = "";
          setState(() {
            _fields = List.generate(5, (index) => index == 0);
          });
        } else {
          setState(() {
            _fields = [];
            _fields.addAll(List.generate(5, (index) => index == s.length));
          });
        }
      }
      return;
    }
    widget.fieldController.text = "";
    setState(() {
      _fields = List.generate(5, (index) => index == 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxHeight: 60,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _OneKeyZone(focused: _fields[0]),
              SizedBox(
                width: 10,
              ),
              _OneKeyZone(focused: _fields[1]),
              SizedBox(
                width: 10,
              ),
              _OneKeyZone(focused: _fields[2]),
              SizedBox(
                width: 10,
              ),
              _OneKeyZone(focused: _fields[3]),
              SizedBox(
                width: 10,
              ),
              _OneKeyZone(focused: _fields[4]),
            ],
          ),
          Positioned(
            right: 11,
            left: 11,
            child: TextField(
              expands: false,
              controller: widget.fieldController,
              keyboardType: TextInputType.number,
              scrollController: _scrollController,
              enableInteractiveSelection: false,
              style: TextStyle(
                letterSpacing: 33.5,
                fontSize: SizesCst.ftsf,
                fontWeight: FontsCst.wfb,
                color: Get.theme.colorScheme.primary,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
              onChanged: (String value) {
                _provider(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _OneKeyZone extends StatefulWidget {
  const _OneKeyZone({
    Key? key,
    required this.focused,
  }) : super(key: key);
  final bool focused;
  @override
  State<_OneKeyZone> createState() => __OneKeyZoneState();
}

class __OneKeyZoneState extends State<_OneKeyZone> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: 40,
      duration: AnimationsCst.adrb,
      curve: AnimationsCst.acra,
      decoration: widget.focused
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(SizesCst.rsc),
              border: Border.all(
                color: ColorsCst.clrz,
                width: SizesCst.bsb,
              ),
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(SizesCst.rsc),
              border: Border.all(
                color: Get.theme.colorScheme.secondary,
                width: SizesCst.bsa,
              ),
            ),
    );
  }
}
