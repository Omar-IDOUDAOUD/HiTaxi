import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hitaxi/core/constants/constants.dart';
import 'package:hitaxi/core/utils/assets_explorer.dart';

import 'dialog_page_route.dart';

class AmpereItemsMenu extends StatefulWidget {
  AmpereItemsMenu({
    Key? key,
    this.initialOffset,
    required this.scaleStartAnimationPoint,
    this.widthSizeFactor = 1,
    required this.items,
    this.onSelectNewItem,
    this.initialSelectedIndex = 0,
  }) : super(key: key) {
    initialOffset ??= Offset(Get.size.width - SizesCst.ssa, SizesCst.ssa);
  }
  Offset? initialOffset;
  final AlignmentGeometry scaleStartAnimationPoint;
  final double widthSizeFactor;
  final List<String> items;
  final int initialSelectedIndex;
  Function(int itemIndex)? onSelectNewItem;

  @override
  State<AmpereItemsMenu> createState() => _AmpereItemsMenuState();
}

class _AmpereItemsMenuState extends State<AmpereItemsMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _anCtrl;
  late Animation<double> _an;
  late int _selectedItem;
  @override
  void initState() {
    // TODO: implement initState
    _selectedItem = widget.initialSelectedIndex;
    _anCtrl = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 1,
      duration: AnimationsCst.adra,
    )..addListener(() {
        setState(() {});
      });
    _an = CurvedAnimation(
      parent: _anCtrl,
      curve: AnimationsCst.acrc,
    );
    _anCtrl.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: GestureDetector(
          onTap: () {
            widget.onSelectNewItem!(_selectedItem);
            Get.back();
            _anCtrl.reverse();
          },
        )),
        Positioned(
          right: Get.size.width - widget.initialOffset!.dx,
          top: widget.initialOffset!.dy,
          child: Transform.scale(
            scale: _an.value,
            alignment: widget.scaleStartAnimationPoint,
            child: Opacity(
              opacity: _an.value > 1.0
                  ? 1
                  : _an.value < 0.0
                      ? 0
                      : _an.value,
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: Get.size.height - widget.initialOffset!.dy - 20,
                  maxWidth: Get.size.width * .7 * widget.widthSizeFactor,
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(15),
                  color: Get.theme.backgroundColor,
                  elevation: 20,
                  clipBehavior: Clip.antiAlias,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: widget.items.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => _MenuItem(
                      grouValue: _selectedItem,
                      id: index,
                      label: widget.items.elementAt(index),
                      onSelected: (id) {
                        setState(() {
                          _selectedItem = index;
                        });
                      },
                      onBackReq: () {
                        widget.onSelectNewItem!(index);
                        Get.back();
                        _anCtrl.reverse();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MenuItem extends StatefulWidget {
  _MenuItem({
    Key? key,
    required this.grouValue,
    required this.id,
    this.onSelected,
    required this.label,
    required this.onBackReq,
  }) : super(key: key) {
    onSelected ??= (v) {};
  }
  final Object grouValue;
  final Object id;
  Function(dynamic id)? onSelected;
  final String label;
  final VoidCallback onBackReq;
  @override
  State<_MenuItem> createState() => __MenuItemState();
}

class __MenuItemState extends State<_MenuItem> {
  final _anDuration = AnimationsCst.adrb;
  final _selectedColor = Colors.blue;
  bool _isFocused = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (dts) => setState(() {
        _isFocused = true;
      }),
      onTapUp: (dts) => setState(() {
        _isFocused = false;
        // Future.delayed(_anDuration).then((value) =>);
        widget.onBackReq();
      }),
      onTapCancel: () => setState(() {
        _isFocused = false;
      }),
      onTap: () => widget.onSelected!(widget.id),
      child: AnimatedContainer(
        duration: _isFocused ? Duration(milliseconds: 20) : _anDuration,
        padding: EdgeInsets.all(15),
        color: widget.grouValue == widget.id
            ? _selectedColor.withOpacity(.1)
            : Colors.transparent,
        foregroundDecoration: BoxDecoration(
          color: _isFocused
              ? Colors.grey[300]!.withOpacity(.3)
              : Colors.transparent,
        ),
        child: Row(
          children: [
            Expanded(
              child: AnimatedDefaultTextStyle(
                duration: _anDuration,
                child: Text(
                  widget.label,
                ),
                style: TextStyle(
                  color: widget.grouValue == widget.id
                      ? _selectedColor
                      : Get.theme.colorScheme.primary,
                  fontSize: SizesCst.ftsc,
                  fontWeight: FontsCst.wfg,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            AnimatedOpacity(
              opacity: widget.grouValue == widget.id ? 1 : 0,
              duration: _anDuration,
              child: SvgPicture.asset(
                AssetsExplorer.icon('checkmark-outline.svg'),
                color: _selectedColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
