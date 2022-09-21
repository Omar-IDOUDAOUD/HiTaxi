import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/outline_button.dart';
import 'package:hitaxi/core/constants/animation.dart';
import 'package:hitaxi/core/constants/font.dart';
import 'package:hitaxi/core/constants/size.dart';

class AmpereAvatarSettingRow extends StatefulWidget {
  AmpereAvatarSettingRow({
    Key? key,
    required this.label,
    required this.subLinkButtonOneIconPath,
    required this.subLinkButtonTwoIconPath,
    required this.subLinkButtonOneLabel,
    required this.subLinkButtonTwoLabel,
    this.avatarImagePath,
    required this.wheneAvatarImageIsNullIconPath,
    this.withBorder = true,
  }) : super(key: key);
  final String label;
  final String subLinkButtonOneIconPath;
  final String subLinkButtonTwoIconPath;
  final String subLinkButtonOneLabel;
  final String subLinkButtonTwoLabel;
  final String? avatarImagePath;
  final String wheneAvatarImageIsNullIconPath;
  final bool withBorder;

  @override
  State<AmpereAvatarSettingRow> createState() => _AmpereAvatarSettingRowState();
}


class _AmpereAvatarSettingRowState extends State<AmpereAvatarSettingRow> {
  String? _avatarPath;
  @override
  Widget build(BuildContext context) {
    if (widget.avatarImagePath != null) _avatarPath = widget.avatarImagePath;
    return Row(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            // color: Colors.green,
            border: widget.withBorder
                ? Border.all(color: Get.theme.colorScheme.primary)
                : null,
            shape: BoxShape.circle,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                widget.wheneAvatarImageIsNullIconPath,
                color: Get.theme.colorScheme.secondary,
                height: 20,
              ),
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: AnimatedScale(
                  onEnd: () {
                    if (widget.avatarImagePath == null) _avatarPath = null;
                  },
                  duration: AnimationsCst.adra,
                  scale: widget.avatarImagePath != null ? 1 : .8,
                  curve: AnimationsCst.acra,
                  child: AnimatedOpacity(
                    duration: AnimationsCst.adra,
                    opacity: widget.avatarImagePath != null ? 1 : 0,
                    curve: AnimationsCst.acra,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(SizesCst.ssh / 2),
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: SizesCst.ssn / 2,
                        child: _avatarPath != null ? Text(_avatarPath!) : null,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: SizesCst.ssd,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.label,
              style: TextStyle(
                fontSize: SizesCst.ftsv,
                fontWeight: FontsCst.wfa,
                color: Get.theme.colorScheme.primary,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                AmpereOutlineButton(
                  iconPath: widget.subLinkButtonOneIconPath,
                  label: widget.subLinkButtonOneLabel,
                  onTap: () {},
                ),
                SizedBox(
                  width: 4,
                ),
                AmpereOutlineButton(
                  iconPath: widget.subLinkButtonTwoIconPath,
                  label: widget.subLinkButtonTwoLabel,
                  onTap: () {},
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
