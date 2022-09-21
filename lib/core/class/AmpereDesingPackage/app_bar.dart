import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';

class AmpereAppBar extends StatelessWidget {
  AmpereAppBar(
      {Key? key, required this.title, this.suffix, this.suffixIconPath})
      : super(key: key);
  final String title;
  final String? suffix;
  final String? suffixIconPath;

  final Color color = Get.theme.colorScheme.primary;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: SizesCst.ftsf,
            fontWeight: FontsCst.wfa,
          ),
        ),
        if (suffix != null)
          Container(
            height: 35,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: color,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Row(
              children: [
                if (suffixIconPath != null)
                  SvgPicture.asset(
                    suffixIconPath!,
                    color: Get.theme.colorScheme.primary,
                  ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  suffix!,
                  style: TextStyle(
                    color: color,
                    fontSize: SizesCst.ftsb,
                  ),
                ),
              ],
            ),
          )
      ],
    );
  }
}
