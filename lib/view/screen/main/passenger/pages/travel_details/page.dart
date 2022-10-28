import 'dart:async';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hitaxi/controller/main/passenger_controller.dart';
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
    _scrollController = ScrollController()
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
        scrollController: _scrollController,
      ),
      backgroundColor: ColorsCst.clrab,
      body: Stack(
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
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(_radius)),
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
    );
  }
}

class FloatingButton extends StatefulWidget {
  FloatingButton({
    Key? key,
    required this.onTravelRequestEvent,
    required this.onCountactRequestEvent,
    required this.scrollController,
  }) : super(key: key);
  final Function onTravelRequestEvent;
  final Function onCountactRequestEvent;
  final ScrollController scrollController;

  @override
  State<FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  bool _sendRequestButtonState = false;

  final Duration _anDur = 300.milliseconds;
  @override
  void initState() {
    widget.scrollController.addListener(() {
      if (this._sendRequestButtonState)
        setState(() {
          _sendRequestButtonState = false;
        });
    });
  }

  Future<void> _openButtons() async {
    setState(() {
      _sendRequestButtonState = true;
    });
  }

  void _closeButtons() {
    setState(() {
      _sendRequestButtonState = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        AnimatedPositioned(
          duration: _anDur,
          curve: AnimationsCst.acra,
          width: _sendRequestButtonState ? Get.size.width - 33 : 0,
          height: _sendRequestButtonState ? 70 : 50,
          right: _sendRequestButtonState ? 0 : 20,
          bottom: _sendRequestButtonState ? 00 : 0,
          child: MaterialButton(
            onPressed: () {
              _closeButtons();
            },
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(_sendRequestButtonState ? 20 : 50)),
            color: Colors.transparent,
            focusElevation: 0,
            hoverElevation: 0,
            highlightElevation: 0,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Text(
                    "COUNTACT",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorsCst.clrab,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  SvgPicture.asset(
                    AssetsExplorer.icon('message-circle-outline.svg'),
                    height: 20,
                    color: ColorsCst.clrab,
                  ),
                ],
              ),
            ),
          ),
        ),
        AnimatedPositioned(
          duration: _anDur,
          curve: AnimationsCst.acra,
          width: _sendRequestButtonState ? Get.size.width - 33 : 60,
          height: _sendRequestButtonState ? 70 : 60,
          right: _sendRequestButtonState ? 0 : 0,
          bottom: _sendRequestButtonState ? 80 : 0,
          child: MaterialButton(
            padding: EdgeInsets.symmetric(horizontal: Get.size.width / 4),
            onPressed: () {
              _closeButtons();
            },
            elevation: 0,
            focusElevation: 0,
            hoverElevation: 0,
            highlightElevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(_sendRequestButtonState ? 20 : 50)),
            color: ColorsCst.clrab,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                "SEND RESUEST",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        // short Button

        AnimatedPositioned(
          duration: _anDur,
          curve: AnimationsCst.acra,
          height: _sendRequestButtonState ? 45 : 60,
          bottom: _sendRequestButtonState ? 92.5 : 0,
          right: _sendRequestButtonState ? Get.size.width / 8.5 : 0,
          child: InkWell(
            onTap: () {
              _openButtons();
            },
            hoverColor: Colors.red,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: _sendRequestButtonState
                  ? ColorsCst.clrab.withGreen(230)
                  : ColorsCst.clrab,
              child: SvgPicture.asset(
                AssetsExplorer.icon('paper-plane-up-outline.svg'),
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//////////////////

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

        // SizedBox(
        //   height: 50,
        // ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
              SizesCst.ssz, 5, SizesCst.ssz, SizesCst.ssz),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                color: Colors.grey[200],
                height: 1,
                endIndent: 50,
                indent: 50,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  CentredCircles(
                    color: Colors.orange,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.chevron_right_rounded,
                            color: Colors.grey,
                            size: 15,
                          ),
                          Text(
                            'Price',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: SizesCst.ftsd,
                              fontWeight: FontsCst.wfb,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '22.53 \$',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Get.theme.colorScheme.primary,
                            fontSize: SizesCst.ftsg,
                            fontWeight: FontsCst.wfb,
                            decoration: TextDecoration.underline),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  CentredCircles(
                    color: Colors.redAccent,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.grey,
                            size: 10,
                          ),
                          Text(
                            'From',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: SizesCst.ftsd,
                              fontWeight: FontsCst.wfb,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Azrou, Ait Melloul',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Get.theme.colorScheme.primary,
                          fontSize: SizesCst.ftsg,
                          fontWeight: FontsCst.wfb,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  CentredCircles(
                    color: Colors.greenAccent,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.grey,
                            size: 10,
                          ),
                          Text(
                            'To',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: SizesCst.ftsd,
                              fontWeight: FontsCst.wfb,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Azrou, Ait Melloul',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Get.theme.colorScheme.primary,
                          fontSize: SizesCst.ftsg,
                          fontWeight: FontsCst.wfb,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Divider(
                color: Colors.grey[200],
                height: 1,
                endIndent: 50,
                indent: 50,
              ),
              SizedBox(
                height: 15,
              ),
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
