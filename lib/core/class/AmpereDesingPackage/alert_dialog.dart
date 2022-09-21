import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/dialg_button.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/scallable.dart';
import 'package:hitaxi/core/constants/color.dart';
import 'package:hitaxi/core/constants/font.dart';
import 'package:hitaxi/core/constants/size.dart';

class AmpereAlertDialog extends StatefulWidget {
  const AmpereAlertDialog({
    Key? key,
    required this.title,
    required this.descreption,
    required this.type,
  }) : super(key: key);

  final String title;
  final String descreption;
  final Map type;
  // final List<Widget, Function>

  @override
  State<AmpereAlertDialog> createState() => _AmpereAlertDialogState();
}

class _AmpereAlertDialogState extends State<AmpereAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontSize: SizesCst.ftsv,
            fontWeight: FontsCst.wfg,
            color: Get.theme.colorScheme.surface,
          ),
        ),
        SizedBox(
          height: SizesCst.ssd,
        ),
        Card(
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(SizesCst.rsc)),
          color: widget.type["color"].withOpacity(.3),
          child: Padding(
            padding: EdgeInsets.all(SizesCst.sse),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  widget.type["icon_path"],
                  size: 40,
                  color: widget.type["color"],
                ),
                SizedBox(
                  width: SizesCst.sse,
                ),
                Expanded(
                  child: Text(
                    widget.descreption,
                    style: TextStyle(
                      fontSize: SizesCst.ftsh,
                      fontWeight: FontsCst.wfg,
                      color: widget.type["color"],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class AmpereAlertTypes {
  static Map error = {
    "color": ColorsCst.clrar,
    "icon_path": Icons.warning_amber_rounded
  };
  static Map notification = {
    "color": ColorsCst.clras,
    "icon_path": Icons.error_outline_rounded,
  };
  static Map success = {
    "color": ColorsCst.clraz,
    "icon_path": Icons.check_circle_outline_rounded,
  };
  static Map fail = {
    "color": ColorsCst.clrax,
    "icon_path": Icons.error_outline_rounded,
  };
  static Map connectionError = {
    "color": ColorsCst.clrax,
    "icon_path": Icons.wifi_rounded,
  };
}
