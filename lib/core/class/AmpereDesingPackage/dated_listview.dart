import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitaxi/core/constants/animation.dart';
import 'package:hitaxi/core/constants/size.dart';

class AmpereDatedListUnitData {
  AmpereDatedListUnitData(
      {this.datetime, required this.child, required this.childHeight});
  final String? datetime;
  final Widget child;
  final double childHeight;

  double? offset;
  ValueNotifier<Object> notifier = ValueNotifier(Object);

  _DateTimeRowVisibilityStates _timeRowVisibilityState =
      _DateTimeRowVisibilityStates.showen;
  // _DateTimeRowAnimatingStates _timeRowAnimatingState =
  //     _DateTimeRowAnimatingStates.stable;
}

enum _DateTimeRowVisibilityStates {
  hiden,
  showen,
}

// enum _DateTimeRowAnimatingStates {
//   stable,
//   animating,
// }

class AmpereDatedListView extends StatefulWidget {
  const AmpereDatedListView({Key? key, required this.units}) : super(key: key);

  final List<AmpereDatedListUnitData> units;

  @override
  State<AmpereDatedListView> createState() => _AmpereDatedListViewState();
}

class _AmpereDatedListViewState extends State<AmpereDatedListView>
    with SingleTickerProviderStateMixin {
  late ScrollController _childsController;
  late ScrollController _timelineController;
  double _buildedOffsets = 0;
  ValueNotifier<String?> _topCurrentDateTimeIndexerNotifier =
      ValueNotifier(null);

  @override
  void initState() {
    // TODO: implement initState
    _topCurrentDateTimeIndexerNotifier =
        ValueNotifier(widget.units.first.datetime);
    super.initState();
    _childsController = ScrollController()
      ..addListener(() {
        if (_timelineController.offset < 0)
          _childsController.jumpTo(_timelineController.offset);
        if (_timelineController.offset > _childsController.offset)
          _childsController.jumpTo(_timelineController.offset);
      });
    _timelineController = ScrollController()
      ..addListener(
        () {
          _childsController.jumpTo(_timelineController.offset);
          widget.units.forEach(
            (e) {
              if (e.offset != null) {
                if (e.offset! < _timelineController.offset + 100) {
                  e._timeRowVisibilityState =
                      _DateTimeRowVisibilityStates.hiden;
                  e.notifier.notifyListeners();
                  final getOldDateTimeReplacment = () => widget.units
                      .lastWhere(
                        (element) =>
                            widget.units.indexOf(e) >
                                widget.units.indexOf(element) &&
                            element != null,
                      )
                      .datetime;
                  if (e.datetime != null)
                    _topCurrentDateTimeIndexerNotifier.value =
                        e.datetime ?? getOldDateTimeReplacment();
                } else {
                  if (widget.units.first == e)
                    _topCurrentDateTimeIndexerNotifier.value = null;
                  e._timeRowVisibilityState =
                      _DateTimeRowVisibilityStates.showen;
                  e.notifier.notifyListeners();
                }
              }
            },
          );
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 3,
          top: 0,
          child: _buildDateTimeVerticalLine(),
        ),
        Padding(
          padding: EdgeInsets.only(left: 18, top: 20),
          child: ListView.builder(
            itemCount: widget.units.length,
            controller: _childsController,
            itemBuilder: (ctx, i) {
              final double topMargin = i == 0 ? 0 : 15;
              final bool foundDateTime =
                  widget.units.elementAt(i).datetime != null && i != 0;
              final Function child = () => widget.units.elementAt(i).child;
              return Column(
                children: [
                  if (foundDateTime) ...[
                    SizedBox(
                      height: 20,
                    )
                  ],
                  Padding(
                    padding: EdgeInsets.only(top: topMargin),
                    child: child(),
                  )
                ],
              );
            },
          ),
        ),
        ListView.builder(
          itemCount: widget.units.length,
          physics: BouncingScrollPhysics(),
          controller: _timelineController,
          itemBuilder: (ctx, i) {
            final double bottomFreeSize =
                widget.units.elementAt(i).childHeight + 15;
            final String? dateTime = widget.units.elementAt(i).datetime;
            final Function noDateTimeFoundW = () => i == 0
                ? SizedBox(
                    height: 20,
                  )
                : SizedBox.shrink();
            if (widget.units.elementAt(i).offset == null) {
              widget.units.elementAt(i).offset = _buildedOffsets;
              if (dateTime != null) {
                _buildedOffsets += bottomFreeSize + 20;
              } else {
                _buildedOffsets += bottomFreeSize;
              }
            }
            return ValueListenableBuilder(
              valueListenable: widget.units.elementAt(i).notifier,
              builder: (ctx, n, c) => Padding(
                child: dateTime != null
                    ? AnimatedSlide(
                        offset:
                            widget.units.elementAt(i)._timeRowVisibilityState ==
                                    _DateTimeRowVisibilityStates.showen
                                ? Offset(0, 0)
                                : Offset(0, -4.7),
                        duration: AnimationsCst.adrb,
                        // curve: AnimationsCst.acra,
                        child: _buildDateTimeIndicatorRow(
                            widget.units.elementAt(i).datetime!),
                      )
                    : noDateTimeFoundW(),
                padding: EdgeInsets.only(bottom: bottomFreeSize),
              ),
            );
          },
        ),
        Positioned(
          top: 0,
          child: ColoredBox(
            color: Get.theme.backgroundColor,
            child: ValueListenableBuilder<String?>(
              valueListenable: _topCurrentDateTimeIndexerNotifier,
              builder: (ctx, v, c) => Visibility(
                child: _buildDateTimeIndicatorRow(v ?? ""),
                replacement: SizedBox(
                  height: 20,
                  width: 100,
                ),
                visible: v != null,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildDateTimeIndicatorRow(String datetime) => SizedBox(
        height: 20,
        child: Row(children: [
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Get.theme.colorScheme.secondary,
                width: SizesCst.bsa,
              ),
              color: Get.theme.backgroundColor,
            ),
            child: SizedBox(width: 8, height: 8),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            datetime,
            style: TextStyle(
              color: Get.theme.colorScheme.secondary,
              fontSize: SizesCst.ftsg,
            ),
          )
        ]),
      );

  Widget _buildDateTimeVerticalLine() => Column(
        children: List.generate(
          Get.size.height ~/ 15,
          (index) => Card(
            margin: EdgeInsets.only(bottom: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2.3),
              side: BorderSide(color: Get.theme.colorScheme.secondary),
            ),
            color: Get.theme.colorScheme.secondary,
            child: SizedBox(width: SizesCst.bsa, height: 15),
          ),
        ),
      );
}
