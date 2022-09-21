import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/scallable.dart';
import 'package:hitaxi/core/constants/animation.dart';
import 'package:hitaxi/core/constants/color.dart';
import 'package:hitaxi/core/constants/font.dart';
import 'package:hitaxi/core/constants/size.dart';

class LayersSwitcher extends StatefulWidget {
  LayersSwitcher(
      {Key? key,
      required this.layer1IconPath,
      required this.layer1Label,
      required this.layer1Id,
      required this.layer2IconPath,
      required this.layer2Label,
      required this.layer2Id,
      this.initialActiveLayerId,
      this.onSwitch}) {
    if (initialActiveLayerId == null) initialActiveLayerId = this.layer1Id;
  }
  final String layer1IconPath;
  final String layer1Label;
  final String layer1Id;
  final String layer2IconPath;
  final String layer2Label;
  final String layer2Id;
  String? initialActiveLayerId;
  final Function(String activedLayerId)? onSwitch;

  @override
  State<LayersSwitcher> createState() => _LayersSwitcherState();
}

class _LayersSwitcherState extends State<LayersSwitcher> {
  late String _focussedLayerId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focussedLayerId = widget.initialActiveLayerId!;
  }

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxHeight: SizesCst.ssh,
      child: Row(
        children: [
          Expanded(
            child: _OneLayer(
              iconPath: widget.layer1IconPath,
              label: widget.layer1Label,
              isActived: _focussedLayerId == widget.layer1Id,
              onTap: () {
                if (widget.onSwitch != null) widget.onSwitch!(widget.layer1Id);
                setState(() {
                  _focussedLayerId = widget.layer1Id;
                });
              },
              alignment: Alignment.centerRight,
            ),
          ),
          SizedBox(
            width: SizesCst.ssd,
          ),
          Expanded(
            child: _OneLayer(
              iconPath: widget.layer2IconPath,
              label: widget.layer2Label,
              isActived: _focussedLayerId == widget.layer2Id,
              onTap: () {
                if (widget.onSwitch != null) widget.onSwitch!(widget.layer2Id);
                setState(() {
                  _focussedLayerId = widget.layer2Id;
                });
              },
              alignment: Alignment.centerLeft,
            ),
          ),
        ],
      ),
    );
  }
}

class _OneLayer extends StatefulWidget {
  const _OneLayer({
    Key? key,
    required this.isActived,
    required this.label,
    required this.iconPath,
    required this.onTap,
    required this.alignment,
  }) : super(key: key);
  final bool isActived;
  final String label;
  final String iconPath;
  final VoidCallback onTap;
  final Alignment alignment;

  @override
  State<_OneLayer> createState() => _OneLayerState();
}

class _OneLayerState extends State<_OneLayer>
    with SingleTickerProviderStateMixin {
  late AnimationController _colorAnCtrl;
  late Animation<Color?> _colorAn;
  bool _isFocussed = false;

  @override
  void initState() {
    _colorAnCtrl =
        AnimationController(vsync: this, duration: AnimationsCst.adrb);
    _colorAn =
        ColorTween(begin: Get.theme.colorScheme.secondary, end: ColorsCst.clrz)
            .animate(_colorAnCtrl)
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _colorAnCtrl.dispose();
  }

  void _startColorAnimation() {
    if (widget.isActived)
      _colorAnCtrl.forward();
    else
      _colorAnCtrl.reverse();
  }

  @override
  Widget build(BuildContext context) {
    if (!_colorAnCtrl.isAnimating) _startColorAnimation();
    return Scallable(
      onTap: () {
        _startColorAnimation();
        widget.onTap();
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(SizesCst.rsc),
        child: Stack(
          children: [
            AnimatedPositioned(
              curve: AnimationsCst.acra,
              duration: AnimationsCst.adra,
              top: 0,
              bottom: 0,
              left: widget.alignment == Alignment.centerLeft
                  ? 0
                  : !widget.isActived
                      ? Get.size.width * .8
                      : 0,
              right: widget.alignment == Alignment.centerRight
                  ? 0
                  : !widget.isActived
                      ? Get.size.width * .8
                      : 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SizesCst.rsa),
                  color: ColorsCst.clrz.withOpacity(.4),
                ),
              ),
            ),
            AnimatedContainer(
              duration: AnimationsCst.adrb,
              curve: AnimationsCst.acra,
              decoration: BoxDecoration(
                border: Border.all(
                  color: _colorAn.value!,
                  width: widget.isActived ? SizesCst.bsb : SizesCst.bsa,
                ),
                borderRadius: BorderRadius.circular(SizesCst.rsc),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      widget.iconPath,
                      color: _colorAn.value,
                    ),
                    Text(
                      widget.label,
                      style: TextStyle(
                        fontSize: SizesCst.ftsv,
                        // fontWeight: FontsCst.wfg,
                        color: _colorAn.value,
                      ),
                    ),
                    // SizedBox(
                    //   height: 8,
                    // )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*

*/
