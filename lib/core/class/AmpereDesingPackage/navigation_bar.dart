import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hitaxi/core/constants/animation.dart';
import 'package:hitaxi/core/constants/color.dart';
import 'package:hitaxi/core/constants/size.dart';
import 'package:hitaxi/core/utils/assets_explorer.dart';

class NavigationBarLabel {
  final int id;
  final String title;
  final String iconPath;
  final String? tooltipMessage;
  NavigationBarLabel(
      {required this.title,
      required this.iconPath,
      required this.id,
      this.tooltipMessage});
}

class AmpereNavigationBar extends StatefulWidget {
  AmpereNavigationBar({
    Key? key,
    required this.labels,
    required this.onUpdate,
    this.initialActiveId,
  }) : super(key: key);
  final List<NavigationBarLabel> labels;
  final Function(int labelId) onUpdate;
  int? initialActiveId;

  @override
  State<AmpereNavigationBar> createState() => _AmpereNavigationBarState();
}

class _AmpereNavigationBarState extends State<AmpereNavigationBar> {
  late dynamic _activeAabelId;

  @override
  void initState() {
    // TODO: implement initState
    _activeAabelId = widget.initialActiveId;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizesCst.ssg,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizesCst.rsa),
          color: ColorsCst.clrab,
          boxShadow: [
            BoxShadow(
                color: Colors.black54.withOpacity(.2),
                blurRadius: 20,
                offset: Offset(0, 5))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          widget.labels.length,
          (index) {
            var label = widget.labels[index];
            return _OneLabel(
              id: label.id,
              onClick: (labelId) {
                widget.onUpdate(labelId);
                setState(() {
                  _activeAabelId = labelId;
                });
              },
              isClicked: _activeAabelId == label.id,
              iconPath: label.iconPath,
              title: label.title,
              tooltipMessage: label.tooltipMessage,
            );
          },
        ),
      ),
    );
  }
}

class _OneLabel extends StatefulWidget {
  const _OneLabel({
    Key? key,
    required this.onClick,
    required this.isClicked,
    required this.iconPath,
    required this.title,
    required this.id,
    this.tooltipMessage,
  }) : super(key: key);

  final Function(dynamic labelId) onClick;
  final bool isClicked;
  final String iconPath;
  final String title;
  final dynamic id;
  final String? tooltipMessage;

  @override
  State<_OneLabel> createState() => __OneLabelState();
}

class __OneLabelState extends State<_OneLabel>
    with SingleTickerProviderStateMixin {
  double _animatedCircleRadius = 0;

  late AnimationController _transformAnCtrl;
  late Animation<Offset> _transformAn;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _transformAnCtrl =
        AnimationController(vsync: this, duration: AnimationsCst.adra);
    _transformAn = Tween(begin: Offset(0, 0), end: Offset(0, -100.0)).animate(
        CurvedAnimation(parent: _transformAnCtrl, curve: AnimationsCst.acra))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) async {
        if (status == AnimationStatus.forward) _animatedCircleRadius = 60;
        if (status == AnimationStatus.completed) {
          _transformAnCtrl.reverse();
          await Future.delayed(AnimationsCst.adrb);
          _animatedCircleRadius = 0;
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _transformAnCtrl.forward();
        widget.onClick(widget.id);
      },
      child: Tooltip(
        message: widget.tooltipMessage ?? '',
        child: ColoredBox(
          color: Colors.transparent,
          child: LimitedBox(
            maxWidth: 65,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Transform.translate(
                  offset: _transformAn.value,
                  child: Align(
                    alignment: Alignment(0, -.3),
                    child: AnimatedContainer(
                      duration: AnimationsCst.adra,
                      curve: AnimationsCst.acra,
                      width: _animatedCircleRadius,
                      height: _animatedCircleRadius,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54.withOpacity(.3),
                            offset: Offset(0, 4),
                            blurRadius: 16,
                          ),
                        ],
                        shape: BoxShape.circle,
                        color: ColorsCst.clrab,
                      ),
                    ),
                  ),
                ),
                //
                Transform.translate(
                  offset: _transformAn.value,
                  child: AnimatedAlign(
                    alignment:
                        widget.isClicked ? Alignment(0, -.4) : Alignment.center,
                    duration: AnimationsCst.adrb,
                    curve: AnimationsCst.acra,
                    child: SvgPicture.asset(
                      widget.iconPath,
                      color: Get.theme.backgroundColor,
                      height: 20,
                    ),
                  ),
                ),
                //
                ClipRRect(
                  child: AnimatedAlign(
                    alignment:
                        widget.isClicked ? Alignment(0, .8) : Alignment(0, 2.4),
                    duration: AnimationsCst.adrb,
                    curve: AnimationsCst.acra,
                    child: SizedBox(
                      height: 30,
                      width: 65,
                      child: Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: SizesCst.ftsh,
                          color: Get.theme.backgroundColor,
                        ),
                      ),
                    ),
                  ),
                ),
                ClipRRect(
                  child: AnimatedAlign(
                    alignment: widget.isClicked
                        ? Alignment.bottomCenter
                        : Alignment(0, 2),
                    duration: AnimationsCst.adrb,
                    curve: AnimationsCst.acra,
                    child: SvgPicture.asset(
                      AssetsExplorer.icon('polygon-top.svg'),
                      color: Get.theme.backgroundColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
