import 'dart:async';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/dialog_page_route.dart';
import 'package:hitaxi/core/constants/constants.dart';
import 'package:hitaxi/core/utils/assets_explorer.dart';
import 'package:hitaxi/view/screen/main/passenger/pages/travel_details/widgets.dart';
import 'package:hitaxi/view/screen/main/shared_widgets.dart';

class TravelDetails extends StatefulWidget {
  const TravelDetails({Key? key}) : super(key: key);

  @override
  State<TravelDetails> createState() => _TravelDetailsState();
}

class _TravelDetailsState extends State<TravelDetails> {
  late ScrollController _scrollController;
  double _extendBottomSpaceHeight = 0;
  double _radius = 35;
  final _topBarSpace = 90.0;
  bool _showTopBarElements = true;

  @override
  void initState() {
    // TODO: implement initState
    _scrollController = ScrollController(initialScrollOffset: -200)
      ..addListener(
        () {
          final offset = _scrollController.offset;
          if (offset >= 0) setState(() => _extendBottomSpaceHeight = offset);
          if (offset <= _topBarSpace && offset >= 0)
            setState(() => _radius = 35 - (35 / _topBarSpace * offset));
          if (offset >= 10)
            setState(() => _showTopBarElements = false);
          else if (!_showTopBarElements)
            setState(() => _showTopBarElements = true);
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingButton(
        onCountactRequestEvent: () {},
        onTravelRequestEvent: () {},
        onOpenOptions: () {},
        isOpen: false,
      ),
      backgroundColor: ColorsCst.clrab,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -20,
              right: -20,
              child: CircleAvatar(
                backgroundColor: Colors.black54.withOpacity(.1),
                radius: 25,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SizedBox(
                height: _extendBottomSpaceHeight,
                child: ColoredBox(
                  color: Get.theme.backgroundColor,
                ),
              ),
            ),
            Positioned.fill(
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: _topBarSpace,
                    ),
                    Container(
                      constraints: BoxConstraints(
                        minHeight: Get.size.height - _topBarSpace + 1,
                      ),
                      width: Get.size.width,
                      decoration: BoxDecoration(
                        color: Get.theme.backgroundColor,
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(_radius)),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, -20),
                            color: Colors.black54.withOpacity(.1),
                            blurRadius: 30,
                          ),
                        ],
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [_Content()],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              height: _topBarSpace,
              left: 0,
              right: 0,
              child: ColoredBox(
                color: Colors.transparent,
                child: TopBar(showTopBarElements: _showTopBarElements),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FloatingButton extends StatefulWidget {
  FloatingButton({
    Key? key,
    required this.onTravelRequestEvent,
    required this.onCountactRequestEvent,
    required this.onOpenOptions,
    this.isOpen = false,
  }) : super(key: key);
  final Function onTravelRequestEvent;
  final Function onCountactRequestEvent;
  final Function onOpenOptions;
  bool isOpen;

  @override
  State<FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  bool _sendRequestButtonState = false;
  double _sendRequestButtonOpacity = 0.0;
  bool _countactButtonState = false;

  bool x = false;

  final Duration _animationDur = AnimationsCst.adrc;
  final Duration _opacityAnDur = AnimationsCst.adrc ~/ 2;

  void _openButtons() {
    if (!_sendRequestButtonState) return _closeButtons();
    setState(() async {
      _sendRequestButtonState = true;
      await Future.delayed(_opacityAnDur);
      _sendRequestButtonOpacity = 1.0;
      await Future.delayed(_animationDur - _opacityAnDur);
      _countactButtonState = true;
    });
  }

  void _closeButtons() {}
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        // send req button
        AnimatedPositioned(
          duration: _animationDur,
          curve: AnimationsCst.acra,
          width: _sendRequestButtonState ? Get.size.width - 33 : 0,
          height: _sendRequestButtonState ? 70 : 50,
          right: _sendRequestButtonState ? 0 : 20,
          bottom: _sendRequestButtonState ? 0 : 5,
          child: MaterialButton(
            onPressed: () {},
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(_sendRequestButtonState ? 20 : 50)),
            color: ColorsCst.clrab,
            child: AnimatedOpacity(
              duration: _opacityAnDur,
              opacity: _sendRequestButtonOpacity,
              child: Text("SEND RESUEST"),
            ),
          ),
        ),
        // short Button
        AnimatedPositioned(
          duration: AnimationsCst.adrb,
          curve: AnimationsCst.acra,
          height: x ? 60 : 10,
          bottom: x ? 0 : 25,
          right: 0,
          child: InkWell(
            onTap: () {
              setState(() {
                _openButtons();
              });
            },
            hoverColor: Colors.red,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: ColorsCst.clrab,
              child: SvgPicture.asset(
                AssetsExplorer.icon('paper-plane-up-outline.svg'),
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _Content extends StatefulWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  State<_Content> createState() => __ContentState();
}

class __ContentState extends State<_Content> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.fromLTRB(SizesCst.ssq, SizesCst.ssq, SizesCst.ssq, 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 85,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: ColorsCst.clrz,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: ClipOval(
                          child: Image.asset(
                            AssetsExplorer.image('driver-person-profile.png'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dr. Alvyino Fraid',
                        style: TextStyle(
                          fontSize: SizesCst.ftsv,
                          fontWeight: FontsCst.wfb,
                          color: Get.theme.colorScheme.primary,
                        ),
                      ),
                      Text(
                        '25 Conveyance getted',
                        style: TextStyle(
                          fontSize: SizesCst.ftsd,
                          fontWeight: FontsCst.wfb,
                          color: Get.theme.colorScheme.secondary,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RateRow(rate: 3),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              OpenDriverAccountButton(),
            ],
          ),
        ),
        Divider(
          color: Colors.grey[200],
          height: 1,
          endIndent: 100,
          indent: 100,
        ),
        // SizedBox(
        //   height: 50,
        // ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
              SizesCst.ssz, 20, SizesCst.ssz, SizesCst.ssz),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Descreption',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Get.theme.colorScheme.primary,
                  fontSize: SizesCst.ftsj,
                  fontWeight: FontsCst.wfb,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Hello there, I am fraid, taxi driver from two years ago, and i always post conveyances in this app'
                'if you would like an travel just call me',
                style: TextStyle(
                  color: Get.theme.colorScheme.secondary,
                  fontSize: SizesCst.ftsg,
                  // fontWeight: FontsCst.wfb,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'All spicefics',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Get.theme.colorScheme.primary,
                  fontSize: SizesCst.ftsj,
                  fontWeight: FontsCst.wfb,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Posted at 12:35, jan 2022',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Get.theme.colorScheme.primary,
                  fontSize: SizesCst.ftsj,
                ),
              ),
              Text(
                'Departure time at 15:45, 14 jan 2022',
                textAlign: TextAlign.start,
                style: TextStyle(
                  height: 1.5,
                  color: Get.theme.colorScheme.primary,
                  fontSize: SizesCst.ftsj,
                ),
              ),
              Text(
                'Max places: 6',
                textAlign: TextAlign.start,
                style: TextStyle(
                  height: 1.5,
                  color: Get.theme.colorScheme.primary,
                  fontSize: SizesCst.ftsj,
                ),
              ),
              Text(
                '2 places left out of 6',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Get.theme.colorScheme.secondary,
                  fontSize: SizesCst.ftsd,
                  fontWeight: FontsCst.wfb,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Trolley type: ',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      height: 1.5,
                      color: Get.theme.colorScheme.primary,
                      fontSize: SizesCst.ftsj,
                    ),
                  ),
                  // trolley icon
                  Text(
                    'Bike',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      height: 1.5,
                      color: Get.theme.colorScheme.primary,
                      fontSize: SizesCst.ftsj,
                    ),
                  ),
                ],
              ),
              Text(
                'Bike mark: Golf',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Get.theme.colorScheme.secondary,
                  fontSize: SizesCst.ftsd,
                  fontWeight: FontsCst.wfb,
                ),
              ),
              Text(
                'Bike picture',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Get.theme.colorScheme.secondary,
                  fontSize: SizesCst.ftsd,
                  fontWeight: FontsCst.wfb,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 50,
                child: TrolleyImages(
                  imagesUrls: ['', ''],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
