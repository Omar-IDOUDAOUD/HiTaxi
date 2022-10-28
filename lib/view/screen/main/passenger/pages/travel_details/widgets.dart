import 'dart:math';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hitaxi/controller/main/passenger_controller.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/clickable.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/squar_button.dart';
import 'package:hitaxi/core/constants/constants.dart';
import 'package:hitaxi/core/shared/bottom_sheet.dart';
import 'package:hitaxi/core/shared/dialog_screen.dart';
import 'package:hitaxi/core/utils/assets_explorer.dart';
import 'package:hitaxi/view/screen/main/shared_widgets.dart';

class TopBar extends StatefulWidget {
  const TopBar({
    Key? key,
    required this.showTopBarElements,
  }) : super(key: key);

  final bool showTopBarElements;

  @override
  State<TopBar> createState() => _TopBarState();
}

class _AppLogoModel {
  const _AppLogoModel({required this.pictureUrl, required this.shadowColor});
  final String pictureUrl;
  final Color shadowColor;
}

class _AppLogo extends StatelessWidget {
  const _AppLogo({Key? key, required this.model}) : super(key: key);
  final _AppLogoModel model;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 50,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: model.shadowColor.withOpacity(.2),
              offset: Offset(0, 3),
              blurRadius: 15,
            ),
          ],
          image: DecorationImage(
            image: AssetImage(
              model.pictureUrl,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class _TopBarState extends State<TopBar> with SingleTickerProviderStateMixin {
  late AnimationController _anCtrl;
  late Animation<Offset> _an;

  List<_AppLogoModel> get _externeAppsLogosModels => [
        _AppLogoModel(
          pictureUrl: AssetsExplorer.image('app-icon.png'),
          shadowColor: Colors.amber,
        )
      ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _anCtrl = AnimationController(
      vsync: this,
      duration: AnimationsCst.adrb,
    );
    _an = Tween(begin: Offset(Get.size.width / 3, 0), end: Offset(0, 0))
        .animate(CurvedAnimation(
      parent: _anCtrl,
      curve: Curves.linearToEaseOut,
    ))
      ..addListener(() {
        setState(() {});
      });
    // _anCtrl.forward();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.showTopBarElements)
      _anCtrl.forward();
    else
      _anCtrl.reverse();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Transform.translate(
              offset: -_an.value,
              child: MaterialButton(
                minWidth: 65,
                height: 65,
                shape: CircleBorder(),
                onPressed: () {
                  Get.find<PassengerController>()
                      .startTravelDetailsRouteAnimation(openingState: true);
                  Get.back();
                },
                child: SvgPicture.asset(
                  AssetsExplorer.icon('back-icon.svg'),
                  height: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Transform.translate(
            offset: Offset(0, -_an.value.dx),
            child: Text(
              'Dr. Alvyino Fraid',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: SizesCst.ftss,
                fontWeight: FontsCst.wfb,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Transform.translate(
              offset: _an.value,
              child: MaterialButton(
                onPressed: () => BottomSheetScreen(
                  LimitedBox(
                    maxHeight: Get.size.height * .7,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CountactOptionFram(
                            title: 'External apps',
                            body: Row(
                              children: [
                                _AppLogo(
                                  model: _externeAppsLogosModels.first,
                                ),
                                SizedBox(width: 10),
                                _AppLogo(
                                  model: _externeAppsLogosModels.first,
                                ),
                                SizedBox(width: 10),
                                _AppLogo(
                                  model: _externeAppsLogosModels.first,
                                ),
                              ],
                            ),
                            // withCopy: false,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CountactOptionFram(
                            title: 'Phone number',
                            body: Row(
                              children: [
                                Tooltip(
                                  message: 'Copied!',
                                  preferBelow: false,
                                  textStyle: TextStyle(
                                    fontWeight: FontsCst.wfc,
                                  ),
                                  child: Text(
                                    "+212554487796",
                                    style: TextStyle(
                                      color: Get.theme.colorScheme.primary,
                                      fontSize: SizesCst.ftsj,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                _callButtonn(),
                              ],
                            ),
                            withCopy: true,
                            onCopy: () {},
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CountactOptionFram(
                            title: 'Email',
                            body: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Tooltip(
                                    message: 'Copied!',
                                    preferBelow: false,
                                    textStyle: TextStyle(
                                      fontWeight: FontsCst.wfc,
                                    ),
                                    child: Text(
                                      "emailexample@email.ex",
                                      style: TextStyle(
                                        color: Get.theme.colorScheme.primary,
                                        fontSize: SizesCst.ftsj,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: _emailButtone(),
                                ),
                              ],
                            ),
                            withCopy: true,
                            onCopy: () {},
                          ),
                          SizedBox(
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                  ),
                  topBar: BottomSheetTopBar(
                    title: "Countact options",
                    withTopResizeBars: true,
                    hasConfirm: false,
                    hasDiscard: false,
                  ),
                  animationDuration: 200.milliseconds,
                ),
                minWidth: 65,
                height: 65,
                shape: CircleBorder(),
                child: SvgPicture.asset(
                  AssetsExplorer.icon('message-circle-outline.svg'),
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _callButtonn() => AmpereClickable(
        builder: (focus) {
          return SizedBox.square(
            dimension: 37,
            child: AnimatedContainer(
              duration: focus ? 10.milliseconds : 100.milliseconds,
              curve: AnimationsCst.acra,
              decoration: BoxDecoration(
                color: focus
                    ? ColorsCst.clrs.withOpacity(.4)
                    : ColorsCst.clrs.withOpacity(.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(
                AssetsExplorer.icon('phone-outline.svg'),
                fit: BoxFit.scaleDown,
                color: ColorsCst.clrs,
              ),
            ),
          );
        },
      );

  Widget _emailButtone() => AmpereClickable(
        builder: (focus) {
          return SizedBox(
            height: 37,
            child: AnimatedContainer(
              duration: focus ? 10.milliseconds : 100.milliseconds,
              curve: AnimationsCst.acra,
              decoration: BoxDecoration(
                color: focus
                    ? ColorsCst.clrs.withOpacity(.4)
                    : ColorsCst.clrs.withOpacity(.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      AssetsExplorer.icon('email-outline.svg'),
                      fit: BoxFit.scaleDown,
                      color: ColorsCst.clrs,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Open Email',
                      style: TextStyle(
                        fontSize: SizesCst.ftsg,
                        fontWeight: FontsCst.wfb,
                        color: ColorsCst.clrs,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
}

class CentredCircles extends StatelessWidget {
  const CentredCircles({Key? key, required this.color}) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 8.5,
      backgroundColor: color.withOpacity(.5),
      child: CircleAvatar(
        radius: 3.5,
        backgroundColor: color,
      ),
    );
  }
}

class CountactOptionFram extends StatelessWidget {
  const CountactOptionFram(
      {Key? key,
      this.withCopy = false,
      required this.body,
      this.onCopy,
      required this.title})
      : super(key: key);
  final bool withCopy;
  final Function()? onCopy;
  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 15, 30, 20),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.10),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontsCst.wfc,
                  color: Get.theme.colorScheme.primary,
                  fontSize: SizesCst.ftsh,
                ),
              ),
              Spacer(),
              if (withCopy)
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: onCopy,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AssetsExplorer.icon('email-outline.svg'),
                        height: 15,
                        color: ColorsCst.clrm,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'copy',
                        style: TextStyle(
                          color: ColorsCst.clrm,
                          fontSize: SizesCst.ftsh,
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
          SizedBox(
            height: 7.5,
          ),
          Divider(
            color: Get.theme.colorScheme.secondary,
            // height: 0.5,
            thickness: .8,
            height: .1,
          ),
          SizedBox(
            height: 15,
          ),
          body,
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class OpenDriverAccountButton extends StatefulWidget {
  const OpenDriverAccountButton({Key? key}) : super(key: key);

  @override
  State<OpenDriverAccountButton> createState() =>
      _OpenDriverAccountButtonState();
}

class _OpenDriverAccountButtonState extends State<OpenDriverAccountButton> {
  bool _isFocus = false;
  @override
  Widget build(BuildContext context) {
    final textColor = _isFocus
        ? Get.theme.colorScheme.surface.withOpacity(.2)
        : Get.theme.colorScheme.surface.withOpacity(.5);
    return GestureDetector(
      onTap: () {
        DialogScreen(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Dr. Fraid Alyino',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: SizesCst.ftsj,
                        fontWeight: FontsCst.wfc,
                        color: Get.theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
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
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                        width: 150,
                        child: Stack(
                          // fit: StackFit.loose,
                          children: [
                            ...List.generate(
                              4 + 1,
                              (index) => Positioned(
                                top: 0,
                                left: index * 10,
                                child: Container(
                                  height: 20,
                                  padding: EdgeInsets.all(2),
                                  constraints: BoxConstraints(minWidth: 20),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25 / 2),
                                    // border:
                                    //     Border.all(color: Colors.white, width: 3),
                                  ),
                                  child: index == 4
                                      ? Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            child: Text(
                                              '20+',
                                              style: TextStyle(
                                                color: ColorsCst.clrab,
                                                fontSize: SizesCst.ftsk,
                                                fontWeight: FontsCst.wfb,
                                              ),
                                            ),
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(25 / 2),
                                          child: Image.asset(
                                            AssetsExplorer.image(
                                                'app-icon.png'),
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '24 conveyance getted',
                        style: TextStyle(
                          color: Get.theme.colorScheme.primary,
                          fontSize: SizesCst.ftsk,
                          fontWeight: FontsCst.wfb,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      RateRow(rate: 3),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '2.5',
                              style: TextStyle(
                                color: Get.theme.colorScheme.primary,
                                fontSize: SizesCst.ftsc,
                                fontWeight: FontsCst.wfb,
                              ),
                            ),
                            TextSpan(
                              text: ' stars',
                              style: TextStyle(
                                color: Get.theme.colorScheme.primary,
                                fontSize: SizesCst.ftsk,
                                fontWeight: FontsCst.wfb,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        5,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(
                              5 - index,
                              (index2) => SvgPicture.asset(
                                AssetsExplorer.icon('star.svg'),
                                height: 14,
                                color: Get.theme.colorScheme.secondary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        children: List.generate(
                          5,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3.8),
                            child: Container(
                              height: 10,
                              decoration: BoxDecoration(
                                color: Get.theme.colorScheme.secondary
                                    .withOpacity(.5),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: (20.5).ceil(),
                                    child: Container(
                                      height: 10,
                                      decoration: BoxDecoration(
                                        color: ColorsCst.clrab,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                  Spacer(
                                    flex: (80.5).ceil(),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          5,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.3),
                            child: Text(
                              '${2 * index + 2}0%',
                              style: TextStyle(
                                color: Get.theme.colorScheme.secondary,
                                fontSize: SizesCst.ftsd,
                                fontWeight: FontsCst.wfb,
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              // SizedBox(
              //   height: 15,
              // ),
            ],
          ),
          hasConfirm: false,
        );
      },
      onTapUp: (dts) => setState(() => _isFocus = false),
      onTapDown: (dts) => setState(() => _isFocus = true),
      onTapCancel: () => setState(() => _isFocus = false),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Get.theme.colorScheme.surface.withOpacity(.05),
        ),
        child: Column(
          children: [
            AnimatedDefaultTextStyle(
              duration: _isFocus ? Duration.zero : AnimationsCst.adrc,
              child: Text('Open Fraid Account'),
              style: TextStyle(
                height: 1.2,
                color: textColor,
                fontWeight: FontsCst.wfg,
                fontSize: SizesCst.ftsc,
              ),
            ),
            AnimatedDefaultTextStyle(
              duration: _isFocus ? Duration.zero : AnimationsCst.adrc,
              child: Text('to show more info about it'),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: SizesCst.ftsd,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrolleyImages extends StatefulWidget {
  const TrolleyImages({Key? key, required this.imagesUrls}) : super(key: key);

  final List<String> imagesUrls;

  @override
  State<TrolleyImages> createState() => _TrolleyImagesState();
}

class _TrolleyImagesState extends State<TrolleyImages> {
  PageController? _viewerController;
  int initedPage = 0;

  void _initViwerController(int initPage) {
    initedPage = initPage;
    _viewerController = PageController(
      initialPage: initPage,
    );
  }

  Future<void> _disposeViwerController() async {
    return await _viewerController!.animateToPage(initedPage,
        duration: AnimationsCst.adrc, curve: AnimationsCst.acra);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.imagesUrls.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (ctx, i) {
        return TrolleyImage(
          onTap: () {
            _initViwerController(i);
            Get.to(
              Scaffold(
                backgroundColor: ColorsCst.clrad,
                body: Stack(
                  children: [
                    Positioned.fill(
                      bottom: 0,
                      top: 0,
                      child: PageView.builder(
                        controller: _viewerController,
                        itemCount: widget.imagesUrls.length,
                        itemBuilder: (ctx, i) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            AssetsExplorer.image('app-icon.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                        physics: BouncingScrollPhysics(),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      left: 0,
                      top: 0,
                      child: ColoredBox(
                        color: Colors.black54.withOpacity(.1),
                        child: SizedBox(
                          height: 70,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () => _disposeViwerController()
                                      .then((value) => Get.back()),
                                  child: SvgPicture.asset(
                                    AssetsExplorer.icon('back-icon.svg'),
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              transition: Transition.cupertino,
              duration: 300.milliseconds,
            );
          },
          imageLink: AssetsExplorer.image('app-icon.png'),
        );
      },
      separatorBuilder: (ctx, v) => SizedBox(width: 5),
    );
  }
}

class TrolleyImage extends StatefulWidget {
  const TrolleyImage({Key? key, required this.imageLink, this.onTap})
      : super(key: key);
  final String imageLink;
  final Function()? onTap;

  @override
  State<TrolleyImage> createState() => _TrolleyImageState();
}

class _TrolleyImageState extends State<TrolleyImage> {
  bool _isFocus = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (dts) => setState(() => _isFocus = false),
      onTapDown: (dts) => setState(() => _isFocus = true),
      onTapCancel: () => setState(() => _isFocus = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        key: widget.key,
        duration: AnimationsCst.adrc,
        scale: _isFocus ? .9 : 1,
        child: Container(
          height: 50,
          width: 50,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: SizedBox.square(
              dimension: 20,
              child: ColoredBox(
                color: Colors.blue,
              ),
            ),
          ),
          foregroundDecoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                widget.imageLink,
                //          'https://images.unsplash.com/photo-1662100829301-01f1d216a1ad?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'
              ),
            ),
          ),
        ),
      ),
    );
  }
}
