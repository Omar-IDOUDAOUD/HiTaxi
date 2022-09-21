import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hitaxi/core/constants/font.dart';
import 'package:hitaxi/core/constants/size.dart';

class AmpereMiniWarningTile extends StatelessWidget {
  const AmpereMiniWarningTile(
      {Key? key, required this.subject, required this.warningIconPath})
      : super(key: key);
  final String subject;
  final String warningIconPath;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          warningIconPath,
          color: Get.theme.colorScheme.secondary,
          height: 20,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            subject,
            maxLines: 2,
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
              height: 1,
              fontSize: SizesCst.ftsc,
              fontWeight: FontsCst.wfa,
              color: Get.theme.colorScheme.secondary,
            ),
          ),
        )
      ],
    );
  }
}
