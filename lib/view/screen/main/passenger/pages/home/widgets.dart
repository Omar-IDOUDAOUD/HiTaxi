import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/ampere.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/selectable_mini_card.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/squar_button.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/text_field.dart';
import 'package:hitaxi/core/constants/animation.dart';
import 'package:hitaxi/core/constants/color.dart';
import 'package:hitaxi/core/constants/font.dart';
import 'package:hitaxi/core/constants/size.dart';
import 'package:hitaxi/core/shared/dialog_screen.dart';
import 'package:hitaxi/core/shared/bottom_sheet.dart';
import 'package:hitaxi/core/utils/assets_explorer.dart';
import 'package:hitaxi/view/screen/main/shared_widgets.dart';

enum _TopSearchCardStates {
  descovering,
  searching,
}

class TopSearchCard extends StatefulWidget {
  const TopSearchCard({Key? key}) : super(key: key);

  @override
  State<TopSearchCard> createState() => _TopSearchCardState();
}

class _TopSearchCardState extends State<TopSearchCard>
    with TickerProviderStateMixin {
  late AnimationController _detialsScallAnCtrl;
  late AnimationController _searchInfoPartAnCtrl;
  late ScrollController _scrollController;
  _TopSearchCardStates _cardState = _TopSearchCardStates.searching;
  final double _cardSize0 = 120; //160
  final double _cardSize1 = 310;
  final double _cardSize2 = Get.size.height * .820;
  late double _cardAnimatedSize;
  bool _canResizToZero = false;
  bool _isDetialed = false;
  bool _readyToShowDetials = false;
  bool _readyToShowSearchInfoPart = false;
  ValueNotifier<double> _searchCardScall = ValueNotifier(1);
  double _searchCardOpacity = 1;

  /// 0 -> 140
  /// 1 -> .8

  @override
  void initState() {
    // TODO: implement initState
    _cardAnimatedSize = _cardSize1;
    _scrollController = ScrollController()
      ..addListener(() {
        if (_cardState == _TopSearchCardStates.descovering) {
          _scrollController.jumpTo(0);
        }
        final maxOffset = 70;
        final difference = _scrollController.offset - maxOffset;
        final scallPercent = 1 - (difference / maxOffset);
        final opacityPercent = 1 - (difference / maxOffset) * 2;
        double scallFactor = scallPercent;
        double opacityFactor = opacityPercent;
        if (scallFactor > 1.0) scallFactor = 1;
        if (scallFactor < .5) scallFactor = .5;
        if (opacityFactor > 1.0) opacityFactor = 1;
        if (opacityFactor < .0) opacityFactor = 0;
        _searchCardScall.value = scallFactor;
        _searchCardOpacity = opacityFactor;
      });
    _detialsScallAnCtrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
      lowerBound: 0,
      upperBound: 1,
    );
    _searchInfoPartAnCtrl = AnimationController(
      vsync: this,
      duration: AnimationsCst.adrb,
      lowerBound: 10,
      upperBound: 100,
    );
    //
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _detialsScallAnCtrl.dispose();
  }

  void _showDetails() {
    setState(() {
      _isDetialed = true;
      _cardAnimatedSize = _cardSize2;
    });
  }

  void _showInfoPart() {
    _cardState = _TopSearchCardStates.descovering;
    _searchInfoPartAnCtrl.forward().then((value) {
      _scrollController.animateTo(0,
          curve: AnimationsCst.acra, duration: AnimationsCst.adra);
      setState(() {
        _readyToShowSearchInfoPart = true;
      });
      print("test 2 passe");
    });
  }

  void _hideInfoPart() {
    _cardState = _TopSearchCardStates.searching;
    _readyToShowSearchInfoPart = false;
    Future.delayed(AnimationsCst.adra).then(
      (value) {
        _searchInfoPartAnCtrl.reverse();
      },
    );
  }

  void _cardDragStart(Offset dets) {
    setState(() {
      print("dy : ${dets.dy}");
      if (!(_cardAnimatedSize < 70)) _cardAnimatedSize += dets.dy;
    });
  }

  void _cardDragEnd() {
    if (_isDetialed) {
      if (_cardAnimatedSize <= Get.size.height * 0.530)
        setState(() {
          if (_canResizToZero) {
            _cardAnimatedSize = _cardSize0;
            _showInfoPart();
            print("case 1 ");
          } else {
            _cardAnimatedSize = _cardSize2;
            _hideInfoPart();
            print("case 2 ");
          }
        });
      else
        setState(() {
          _cardAnimatedSize = _cardSize2;
          _hideInfoPart();
          print("case 3 ");
        });
    } else {
      if (_cardAnimatedSize <= 250)
        setState(() {
          if (_canResizToZero) {
            _cardAnimatedSize = _cardSize0;
            _showInfoPart();
          } else {
            _cardAnimatedSize = _cardSize1;
            _hideInfoPart();
          }
        });
      else
        setState(() {
          _cardAnimatedSize = _cardSize1;
          _hideInfoPart();
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mainFieldsColor =
        Get.isDarkMode ? Get.theme.colorScheme.primary : null;
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 400),
      curve: AnimationsCst.acra,
      tween: Tween<double>(
        begin: _cardAnimatedSize,
        end: _cardAnimatedSize,
      ),
      builder: (BuildContext context, double value, Widget? child) {
        print("value: $value");
        return SizedBox(
          height: value,
          child: TopGlassCard(
            child: Stack(
              children: [
                SingleChildScrollView(
                  controller: _scrollController,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(SizesCst.ssa),
                  child: Column(
                    children: [
                      AnimatedBuilder(
                        animation: CurvedAnimation(
                            curve: AnimationsCst.acra,
                            parent: _searchInfoPartAnCtrl),
                        builder: (BuildContext context, Widget? child) {
                          return SizedBox(
                            height: _searchInfoPartAnCtrl.value,
                            child: AnimatedOpacity(
                              opacity: _readyToShowSearchInfoPart ? 1 : 0,
                              child: child,
                              duration: AnimationsCst.adrb,
                            ),
                          );
                        },
                        child: _VariableWidget0(),
                      ),
                      ValueListenableBuilder(
                        valueListenable: _searchCardScall,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: TopSearchPostCard(
                            inputeController1: TextEditingController(),
                            inputeController2: TextEditingController(),
                            onSubmit: () {
                              setState(() {
                                _canResizToZero = true;
                              });
                            },
                          ),
                        ),
                        builder: (
                          BuildContext context,
                          double value,
                          Widget? child,
                        ) =>
                            Transform.scale(
                          alignment: Alignment.bottomCenter,
                          scale: value,
                          child: Opacity(
                            opacity: _searchCardOpacity,
                            child: child,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizesCst.sse,
                      ),
                      !_readyToShowDetials
                          ? AnimatedScale(
                              onEnd: () {
                                setState(() {
                                  _readyToShowDetials = true;
                                  _detialsScallAnCtrl.forward();
                                });
                              },
                              scale: _isDetialed ? .8 : 1,
                              duration: AnimationsCst.adra,
                              curve: AnimationsCst.acra,
                              child: AnimatedOpacity(
                                opacity: _isDetialed ? 0 : 1,
                                duration: AnimationsCst.adra,
                                curve: AnimationsCst.acra,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: _VariableWidget1(
                                    onReqeustChange: () => _showDetails(),
                                  ),
                                ),
                              ),
                            )
                          : AnimatedBuilder(
                              animation: _detialsScallAnCtrl,
                              builder: (BuildContext context, Widget? child) =>
                                  Opacity(
                                      opacity: _detialsScallAnCtrl.value,
                                      child: child),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: _VariableWidget2(),
                              ),
                            ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onVerticalDragStart: (dets) {
                      // print(dets);
                    },
                    onVerticalDragUpdate: (dets) => _cardDragStart(dets.delta),
                    onVerticalDragEnd: (dets) => _cardDragEnd(),
                    child: SizedBox(
                      height: 25,
                      // width: Get.size.width * .9,
                      child: ColoredBox(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class _VariableWidget0 extends StatelessWidget {
  const _VariableWidget0({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "Barchalona alou  sdsd",
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  height: 1,
                  fontSize: SizesCst.ftsv,
                  fontWeight: FontsCst.wfa,
                  color: Get.theme.colorScheme.primary,
                ),
              ),
            ),
            Expanded(
              child: Text(
                "Baghdad",
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  height: 1,
                  fontSize: SizesCst.ftsv,
                  fontWeight: FontsCst.wfa,
                  color: Get.theme.colorScheme.primary,
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Spacer(
              flex: 2,
            ),
            SizedBox.square(
              dimension: 8,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                      width: 1.5, color: Get.theme.colorScheme.primary),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  10,
                  (index) => SizedBox(
                    width: 7,
                    height: 1.5,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Get.theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox.square(
              dimension: 8,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    width: SizesCst.bsa,
                    color: Get.theme.colorScheme.primary,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Spacer(
              flex: 2,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "2 Covyances available",
                    style: TextStyle(
                      height: 1,
                      fontSize: SizesCst.ftsv,
                      fontWeight: FontsCst.wfa,
                      color: Get.theme.colorScheme.primary,
                    ),
                  ),
                  Text(
                    "Group by name",
                    style: TextStyle(
                      height: 1,
                      fontSize: SizesCst.ftsh,
                      fontWeight: FontsCst.wfa,
                      color: Get.theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            AmpereSquareButton(
              iconPath: AssetsExplorer.icon("options-2-outline.svg"),
              onTap: () {
                DialogScreen(
                  //
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Group resultes by',
                                  style: TextStyle(
                                    color: Get.theme.colorScheme.primary,
                                    fontSize: SizesCst.ftsv,
                                    fontWeight: FontsCst.wfg,
                                  ),
                                ),
                                Text(
                                  'Name',
                                  style: TextStyle(
                                    color: Get.theme.colorScheme.secondary,
                                    fontSize: SizesCst.ftsh,
                                    fontWeight: FontsCst.wfg,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: SvgPicture.asset(
                              AssetsExplorer.icon('swap-outline.svg'),
                              color: Get.theme.colorScheme.primary,
                              height: 27,
                            ),
                          )
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: MenuShowerButton(
                            menuItems: [
                              'Place name',
                              'Rate',
                              'Posted date',
                              'Departue time',
                              'Maximum passengers',
                            ],
                            initialSelectedIndex: 1,
                            onSelectNewItem: (int newItemIndex) {
                              print('new item: $newItemIndex');
                            },
                          )),
                    ],
                  ),
                  confirmLabel: 'Ok',
                  hasDiscard: true,
                  discardLabel: 'Cancel',
                  recommendedOption: DialogRecommendedOption.confirm,
                  onDiscard: () {
                    DialogScreen.stop();
                  },
                  onConfirm: () {
                    DialogScreen.stop();
                  },
                );
              },
              color: ColorsCst.clrs,
              sizeFactor: .9,
            )
          ],
        )
      ],
    );
  }
}

class _VariableWidget1 extends StatelessWidget {
  const _VariableWidget1({Key? key, required this.onReqeustChange})
      : super(key: key);
  final Function onReqeustChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            "Show travel properties",
            style: TextStyle(
              height: 1,
              fontSize: SizesCst.ftsc,
              fontWeight: FontsCst.wfg,
              color: Get.theme.colorScheme.primary,
            ),
          ),
        ),
        SizedBox(
          height: SizesCst.sse,
        ),
        ExpandButton(
          onTap: onReqeustChange,
          iconColor: Get.theme.colorScheme.surface.withOpacity(.5),
        ),
      ],
    );
  }
}

class _VariableWidget2 extends StatefulWidget {
  _VariableWidget2({Key? key}) : super(key: key);

  @override
  State<_VariableWidget2> createState() => _VariableWidget2State();
}

class _VariableWidget2State extends State<_VariableWidget2> {
  final ValueNotifier<int> _selectedTrelloyNotifier = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SizesCst.ssd),
          child: Text(
            "Price",
            style: TextStyle(
              fontSize: SizesCst.ftsv,
              fontWeight: FontsCst.wfg,
              color: Get.theme.colorScheme.primary,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        AmpereTextField(
          prefixIconPath: AssetsExplorer.icon("arrow-up-outline.svg"),
          hint: 'maximum price',
          enabledColor: Get.isDarkMode ? Get.theme.colorScheme.primary : null,
        ),
        SizedBox(
          height: 5,
        ),
        AmpereTextField(
          prefixIconPath: AssetsExplorer.icon("arrow-down-outline.svg"),
          hint: 'minimum price',
          enabledColor: Get.isDarkMode ? Get.theme.colorScheme.primary : null,
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SizesCst.ssd),
          child: Text(
            "Departue time",
            style: TextStyle(
              fontSize: SizesCst.ftsv,
              fontWeight: FontsCst.wfg,
              color: Get.theme.colorScheme.primary,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        // AmpereDateTimeSelector(
        //   initialDateTime: DateTime.now(),
        //   onChangeDateTime: (DateTime datetime) {
        //     print("new datetime is $datetime");
        //   },
        // ),
        DateTimeSelector(
          initialDateTime: DateTime.now(),
          onChangeDateTime: (DateTime datetime) {
            print("new datetime is $datetime");
          },
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SizesCst.ssd),
          child: Text(
            "Maximmum passengers",
            style: TextStyle(
              fontSize: SizesCst.ftsv,
              fontWeight: FontsCst.wfg,
              color: Get.theme.colorScheme.primary,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        CountSelector(
          countUpIconPath: AssetsExplorer.icon("arrow-ios-upward-outline.svg"),
          countDownIconPath:
              AssetsExplorer.icon("arrow-ios-downward-outline.svg"),
          onChangeCount: (int count) {
            print('count: $count');
          },
          minimumValue: 1,
          suffixTermOne: "Passenger",
          suffixTermTwo: "Passengers",
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SizesCst.ssd),
          child: Text(
            "Free places left",
            style: TextStyle(
              fontSize: SizesCst.ftsv,
              fontWeight: FontsCst.wfg,
              color: Get.theme.colorScheme.primary,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        CountSelector(
          countUpIconPath: AssetsExplorer.icon("arrow-ios-upward-outline.svg"),
          countDownIconPath:
              AssetsExplorer.icon("arrow-ios-downward-outline.svg"),
          onChangeCount: (int count) {
            print('count: $count');
          },
          minimumValue: 1,
          suffixTermOne: "free places",
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SizesCst.ssd),
          child: Text(
            "Cart",
            style: TextStyle(
              fontSize: SizesCst.ftsv,
              fontWeight: FontsCst.wfg,
              color: Get.theme.colorScheme.primary,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        BottomSheetShowerButton(
          iconPath: AssetsExplorer.icon("arrowhead-up-outline.svg"),
          label: "Show available cart",
          onTap: () {
            BottomSheetScreen(
              ValueListenableBuilder(
                valueListenable: _selectedTrelloyNotifier,
                builder: (ctx, v, c) {
                  List<String> items = [
                    'Car',
                    'Bus',
                    'Trick',
                    'Boat',
                    'Bike',
                    'Airplane',
                  ];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Wrap(
                      children: List.generate(
                        items.length,
                        (index) {
                          return AmpereSelectableCard<int>(
                            label: items.elementAt(index),
                            prefexIconPath:
                                AssetsExplorer.icon('history-icon.svg'),
                            id: index,
                            sharedValue: _selectedTrelloyNotifier.value,
                            onSelected: (i) {
                              print('clicked success');
                              _selectedTrelloyNotifier.value = index;
                            },
                          );
                        },
                      ),
                      runSpacing: 10,
                      spacing: 10,
                    ),
                  );
                },
              ),
              topBar: BottomSheetTopBar(
                title: 'Choose a trelloy',
                onConfirm: () {
                  BottomSheetScreen.hide();
                },
                onDiscard: () {
                  BottomSheetScreen.hide();
                },
                recommandedOption: SheetTopBarRecommandedExitOptions.confirm,
              ),
            );
          },
        )
      ],
    );
  }
}

class HistoryCard extends StatelessWidget {
  const HistoryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorsCst.clrab,
                width: SizesCst.bsc,
              ),
              borderRadius: BorderRadius.circular(SizesCst.rsa),
              color: Get.theme.colorScheme.surface.withOpacity(.05),
            ),
          ),
          Positioned(
            top: -12.5,
            width: 180,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _getCicle(),
                _getCicle(),
                _getCicle(),
                _getCicle(),
              ],
            ),
          ),
          Positioned.fill(
            top: 27,
            left: SizesCst.bsc,
            right: SizesCst.bsc,
            bottom: SizesCst.bsc,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 25,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "dr Alfraid alvyino",
                            style: TextStyle(
                              color: Get.theme.colorScheme.primary,
                              fontWeight: FontsCst.wfb,
                              fontSize: SizesCst.ftsv,
                            ),
                          ),
                          Text(
                            "1 Place reserved",
                            style: TextStyle(
                              height: 1,
                              color: Get.theme.colorScheme.secondary,
                              // fontWeight: FontsCst.wfg,
                              fontSize: SizesCst.ftsd,
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: ColorsCst.clrab,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "Waiting for response",
                                  style: TextStyle(
                                    color: Colors.white,
                                    // fontWeight: FontsCst.wfg,
                                    fontSize: SizesCst.ftsd,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '14:22,',
                            style: TextStyle(
                              color: Get.theme.colorScheme.primary,
                              fontSize: SizesCst.ftsv,
                            ),
                          ),
                          Text(
                            'tomorrow,',
                            style: TextStyle(
                              color: Get.theme.colorScheme.primary,
                              fontSize: SizesCst.ftsd,
                            ),
                          ),
                          Text(
                            '15 August',
                            style: TextStyle(
                              color: Get.theme.colorScheme.primary,
                              fontSize: SizesCst.ftsd,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    10,
                    (index) => Container(
                      height: SizesCst.bsa,
                      width: 20,
                      color: Get.theme.colorScheme.primary,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Row(
                    children: [
                      Spacer(),
                      Expanded(
                        child: Center(
                          child: Text(
                            "Azrou, Ait melloul",
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: ColorsCst.clrat,
                              fontSize: SizesCst.ftsc,
                              fontWeight: FontsCst.wfb,
                            ),
                          ),
                        ),
                        flex: 5,
                      ),
                      Expanded(
                        child: SizedBox.expand(
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 4,
                                backgroundColor: ColorsCst.clrat,
                              ),
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: List.generate(
                                    4,
                                    (index) => Container(
                                      height: SizesCst.bsa,
                                      width: 8,
                                      color: ColorsCst.clrat,
                                    ),
                                  ),
                                ),
                              ),
                              SvgPicture.asset(
                                AssetsExplorer.icon('polygon-right.svg'),
                                color: ColorsCst.clrat,
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        flex: 4,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            "Fadissa",
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: ColorsCst.clrat,
                              fontSize: SizesCst.ftsc,
                              fontWeight: FontsCst.wfb,
                            ),
                          ),
                        ),
                        flex: 5,
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    style: TextStyle(
                      color: Get.theme.colorScheme.primary,
                      fontSize: SizesCst.ftsd,
                    ),
                    children: [
                      TextSpan(
                        text: "Price: ",
                      ),
                      TextSpan(
                        text: "15,00 UTC",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AssetsExplorer.icon('alert-triangle-outline.svg'),
                        height: 10,
                        color: Get.theme.colorScheme.primary,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: Text(
                          "You can pay after acceptation the driver",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Get.theme.colorScheme.primary,
                            fontSize: SizesCst.ftsd,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                )
              ],
            ),
          ),
          //
        ],
      ),
    );
  }

  Widget _getCicle() => DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorsCst.clrab,
            width: SizesCst.bsc,
          ),
          color: Get.theme.backgroundColor,
          shape: BoxShape.circle,
        ),
        child: SizedBox(
          height: 25,
          width: 25,
        ),
      );
}

class ConveyanceCard extends StatefulWidget {
  ConveyanceCard({Key? key, this.onTap}) : super(key: key);

  final VoidCallback? onTap;

  @override
  State<ConveyanceCard> createState() => ConveyanceStateCard();
}

class ConveyanceStateCard extends State<ConveyanceCard> {
  final double _cardSize1 = 80;
  final double _cardSize2 = 205;
  bool _isExpanded = true;
  bool _isDraging = false;
  List<Color>? _colorsList;
  List<Color> _getCardColors() {
    var randomIndex = Random().nextInt(ColorsCst.cardColors.length);
    print(randomIndex);
    while (!randomIndex.isEven) {
      randomIndex = Random().nextInt(ColorsCst.cardColors.length);
      print('test 1 passed');
    }
    _colorsList = <Color>[
      ColorsCst.cardColors.elementAt(randomIndex + 1),
      ColorsCst.cardColors.elementAt(randomIndex),
    ];
    return _colorsList!;
  }

  void startDragingState() => setState(() => _isDraging = true);
  void stopDragingState() => setState(() => _isDraging = false);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _isDraging ? .8 : 1,
        duration: AnimationsCst.adrc,
        curve: Curves.easeInOutBack,
        child: AnimatedContainer(
          height: _isExpanded ? _cardSize2 : _cardSize1,
          duration: AnimationsCst.adra,
          curve: Curves.easeOutQuart,
          padding: EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: (_colorsList ?? _getCardColors()).last,
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox.square(
                          dimension: _cardSize1,
                          child: AnimatedContainer(
                            duration: AnimationsCst.adra,
                            curve: AnimationsCst.acra,
                            margin: EdgeInsets.all(_isExpanded ? 13 : 3),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(_isExpanded ? 10 : 18),
                              color: Get.theme.backgroundColor,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: ClipOval(
                                child: Image.asset(
                                  AssetsExplorer.image(
                                      'driver-person-profile.png'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        AnimatedSize(
                          duration: AnimationsCst.adra,
                          curve: AnimationsCst.acra,
                          child: SizedBox(
                            width: _isExpanded ? 0 : 5,
                          ),
                        ),
                        Expanded(
                          // width: Get.size.width * 0.3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "dr, sdjosdijf",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: SizesCst.ftsv,
                                  fontWeight: FontsCst.wfb,
                                  color: _colorsList!.first,
                                ),
                              ),
                              Text(
                                "golf driver",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: SizesCst.ftsd,
                                  fontWeight: FontsCst.wfa,
                                  color: ColorsCst.clrfl,
                                ),
                              ),
                              Text(
                                "5 plaes left out of 8",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: SizesCst.ftsd,
                                  fontWeight: FontsCst.wfa,
                                  color: ColorsCst.clrfl,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ExpandButton(
                          initialState: _isExpanded,
                          onTap: () {
                            setState(() {
                              _isExpanded = !_isExpanded;
                              // if (_isExpanded)
                              // _startAnimExpandDetsIndex++;
                              // else
                              // _startAnimExpandDetsIndex--;
                            });
                          },
                          iconColor: Colors.white,
                        ),
                      ],
                    ),
                    AnimatedOpacity(
                      opacity: 1,
                      duration: AnimationsCst.adrc,
                      curve: AnimationsCst.acra,
                      // onEnd: () {
                      //   setState(() {
                      //     _handleAnimIndexValue(1);
                      //   });
                      // },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: _destialsCell('from',
                            'paper-plane-up-outline.svg', "baghdad", false),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _destialsCell('to', "paper-plane-down-outline.svg",
                          "yonnan", false),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _destialsCell('at', "calendar-outline.svg",
                          "Today", false, 'clock-outline.svg', '15:30'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _destialsCell(
                          'price', "coins-icon.svg", "15,00 UTC", true),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getMainChild() {
    return AnimatedScale(
      scale: _isDraging ? .8 : 1,
      duration: AnimationsCst.adrc,
      curve: Curves.easeInOutBack,
      child: AnimatedContainer(
        height: _isExpanded ? _cardSize2 : _cardSize1,
        duration: AnimationsCst.adra,
        curve: Curves.easeOutQuart,
        padding: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: (_colorsList ?? _getCardColors()).last,
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox.square(
                        dimension: _cardSize1,
                        child: AnimatedContainer(
                          duration: AnimationsCst.adra,
                          curve: AnimationsCst.acra,
                          margin: EdgeInsets.all(_isExpanded ? 13 : 3),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(_isExpanded ? 10 : 18),
                            color: Get.theme.backgroundColor,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: ColoredBox(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      AnimatedSize(
                        duration: AnimationsCst.adra,
                        curve: AnimationsCst.acra,
                        child: SizedBox(
                          width: _isExpanded ? 0 : 5,
                        ),
                      ),
                      Expanded(
                        // width: Get.size.width * 0.3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "dr, sdjosdijf",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: SizesCst.ftsv,
                                fontWeight: FontsCst.wfb,
                                color: _colorsList!.first,
                              ),
                            ),
                            Text(
                              "golf driver",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: SizesCst.ftsd,
                                fontWeight: FontsCst.wfa,
                                color: ColorsCst.clrfl,
                              ),
                            ),
                            Text(
                              "5 plaes left out of 8",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: SizesCst.ftsd,
                                fontWeight: FontsCst.wfa,
                                color: ColorsCst.clrfl,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ExpandButton(
                        initialState: _isExpanded,
                        onTap: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                            // if (_isExpanded)
                            // _startAnimExpandDetsIndex++;
                            // else
                            // _startAnimExpandDetsIndex--;
                          });
                        },
                        iconColor: Colors.white,
                      ),
                    ],
                  ),
                  AnimatedOpacity(
                    opacity: 1,
                    duration: AnimationsCst.adrc,
                    curve: AnimationsCst.acra,
                    // onEnd: () {
                    //   setState(() {
                    //     _handleAnimIndexValue(1);
                    //   });
                    // },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _destialsCell('from', 'paper-plane-up-outline.svg',
                          "baghdad", false),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: _destialsCell(
                        'to', "paper-plane-down-outline.svg", "yonnan", false),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: _destialsCell('at', "calendar-outline.svg", "Today",
                        false, 'clock-outline.svg', '15:30'),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: _destialsCell(
                        'price', "coins-icon.svg", "15,00 UTC", true),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _destialsCell(String titel, String content1IonPath, String content1Label,
    bool priceExeption,
    [String? content2IonPath, String? content2Label]) {
  final priceExColor1 = ColorsCst.clrl;
  final priceExColor2 = ColorsCst.clrlb;
  final Color color = ColorsCst.clrfl;
  final double iconHeight = 13;
  final textStyle = TextStyle(
    fontSize: SizesCst.ftsh,
    fontWeight: FontsCst.wfa,
    color: color,
  );
  return Row(
    children: [
      SvgPicture.asset(
        AssetsExplorer.icon(
          "polygon-right.svg",
        ),
        color: color,
      ),
      SizedBox(
        width: 5,
      ),
      SizedBox(
        width: 45,
        child: Text(titel, style: textStyle),
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
        decoration: BoxDecoration(
          color: priceExeption ? priceExColor1 : Colors.black.withOpacity(.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              AssetsExplorer.icon(
                content1IonPath,
              ),
              height: iconHeight,
              color: priceExeption ? null : color,
            ),
            SizedBox(
              width: 5,
            ),
            Text(content1Label,
                style: textStyle.copyWith(
                    color: priceExeption ? priceExColor2 : textStyle.color)),
            if (content2Label != null) ...[
              SizedBox(
                width: 5,
              ),
              SvgPicture.asset(
                AssetsExplorer.icon(
                  content2IonPath!,
                ),
                height: iconHeight,
                color: color,
              ),
              SizedBox(
                width: 5,
              ),
              Text(content2Label, style: textStyle)
            ]
          ],
        ),
      )
    ],
  );
}
