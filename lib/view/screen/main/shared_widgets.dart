import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hitaxi/controller/main/abstract_controller.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/ampere.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/avatar_image_viewer.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/clickable.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/dialog_page_route.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/item_tile_clickable.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/items_menu.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/radio.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/squar_button.dart';
import 'package:hitaxi/core/constants/animation.dart';
import 'package:hitaxi/core/constants/color.dart';
import 'package:hitaxi/core/constants/constants.dart';
import 'package:hitaxi/core/constants/size.dart';
import 'package:hitaxi/core/shared/bottom_sheet.dart';
import 'package:hitaxi/core/shared/dialog_screen.dart';
import 'package:hitaxi/core/utils/assets_explorer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../core/class/AmpereDesingPackage/app_bar.dart';

class TopGlassCard extends StatelessWidget {
  const TopGlassCard({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        // blendMode: BlendMode.dst,
        filter: ImageFilter.blur(
          sigmaX: 13,
          sigmaY: 13,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Get.theme.backgroundColor.withOpacity(.5),
            border: Border.all(
              color: Get.theme.colorScheme.surface.withOpacity(.1),
              width: SizesCst.bsa,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          child: child,
        ),
      ),
    );
  }
}

class TopSearchPostCard extends StatefulWidget {
  TopSearchPostCard({
    Key? key,
    required this.inputeController1,
    required this.inputeController2,
    required this.onSubmit,
  }) : super(key: key);
  final TextEditingController inputeController1;
  final TextEditingController inputeController2;
  final VoidCallback onSubmit;

  @override
  State<TopSearchPostCard> createState() => _TopSearchPostCardState();
}

class _TopSearchPostCardState extends State<TopSearchPostCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Row(
              children: [
                _getPrefexPlacesInputesWidget(35),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      AmpereTextField(
                        controller: widget.inputeController1,
                        hint: "from place",
                        enabledColor: Get.isDarkMode
                            ? Get.theme.colorScheme.primary
                            : null,
                      ),
                      SizedBox(
                        height: SizesCst.ssd,
                      ),
                      AmpereTextField(
                        controller: widget.inputeController2,
                        hint: "to place",
                        enabledColor: Get.isDarkMode
                            ? Get.theme.colorScheme.primary
                            : null,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: SizesCst.ssd,
        ),
        AmpereButton(
          label: "SEARCH",
          height: 65,
          color: ColorsCst.clrd,
          textColor: ColorsCst.clrfl,
          onTap: widget.onSubmit,
          suffixIconPath: AssetsExplorer.icon(
            'search-outline.svg',
          ),
        )
      ],
    );
  }

  Widget _getPrefexPlacesInputesWidget(double spacerHeight) => FittedBox(
        fit: BoxFit.cover,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                _sq(ColorsCst.clri),
                SizedBox(
                  height: spacerHeight,
                ),
                _sq(ColorsCst.clro),
              ],
            ),
            SizedBox(
              height: spacerHeight + 30,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  6,
                  (index) => SizedBox(
                    width: SizesCst.bsa,
                    height: 7,
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
          ],
        ),
      );

  Widget _sq(Color color) => SizedBox.square(
        dimension: 35,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color,
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: SizedBox.square(
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
          ),
        ),
      );
}

class ExpandButton extends StatefulWidget {
  const ExpandButton({
    Key? key,
    required this.onTap,
    this.iconColor = Colors.white,
    this.initialState = false,
  }) : super(key: key);
  final Function onTap;
  final Color iconColor;
  final bool initialState;

  @override
  State<ExpandButton> createState() => _ExpandButtonState();
}

class _ExpandButtonState extends State<ExpandButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _anCtrl;
  late Animation<double> _an;
  late bool _isExpanded;
  @override
  void initState() {
    // TODO: implement initState
    _isExpanded = widget.initialState;
    _anCtrl = AnimationController(vsync: this, duration: AnimationsCst.adrb);
  }

  void _setRotation() {
    if (_isExpanded)
      _anCtrl.reverse();
    else
      _anCtrl.forward();
    _isExpanded = !_isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _setRotation();
        widget.onTap();
      },
      child: CircleAvatar(
        backgroundColor: Colors.black54.withOpacity(.1),
        radius: 15,
        child: Center(
          child: TweenAnimationBuilder<double>(
            tween: _isExpanded
                ? Tween(begin: 0, end: pi)
                : Tween(begin: pi, end: 0),
            duration: AnimationsCst.adrb,
            builder: (ctx, n, c) {
              return Transform.rotate(
                angle: n,
                child: c,
              );
            },
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: widget.iconColor,
            ),
          ),
        ),
      ),
    );
  }
}

const double _DEF_TILE_CONTENT_H = 50;

class SettingsTab extends StatelessWidget {
  SettingsTab({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);
  final AbstractUserTypeController _controller;

  final ValueNotifier<String> _themeSelectedRadioId =
      ValueNotifier('SYSTEM-ID');

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: SizesCst.ssz),
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: SizesCst.ssq,
            left: SizesCst.sso,
            right: SizesCst.ssq,
          ),
          child: AmpereAppBar(
            title: 'SETTINGS',
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Column(
          children: [
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  SizedBox(
                    width: SizesCst.sso,
                  ),
                  AmpereAvatarImageViewer(
                    avatarImagePath:
                        AssetsExplorer.image('passenger-avatar-3.png'),
                    avatarNoImagePath:
                        AssetsExplorer.image('passenger-avatar-4.png'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Omar IDOUDAOUD',
                        style: TextStyle(
                          fontSize: SizesCst.ftsv,
                          color: Get.theme.colorScheme.primary,
                        ),
                      ),
                      Text(
                        'pcomar.lenovo@gmail.com',
                        style: TextStyle(
                          color: Get.theme.colorScheme.secondary,
                          fontSize: SizesCst.ftsh,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Builder(builder: (context) {
              void onTap() => BottomSheetScreen(
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: [
                          //
                          _getPictureSourceRow(
                              'camera-outline.svg', 'from camera...', () {}),
                          _getPictureSourceRow(
                              'image-outline.svg', 'from gallery...', () {}),
                        ],
                      ),
                    ),
                    topBar: BottomSheetTopBar(
                        title: 'Picture source',
                        hasDiscard: false,
                        confirmeIconPath:
                            AssetsExplorer.icon('close-outline.svg'),
                        recommandedOption: null,
                        onConfirm: () {
                          BottomSheetScreen.hide();
                        },
                        onDiscard: () {
                          BottomSheetScreen.hide();
                        }),
                  );
              return AmpereItemRowClickable(
                onTap: onTap,
                child: Container(
                  // height: _DEF_TILE_CONTENT_H,
                  constraints: BoxConstraints(
                    minHeight: _DEF_TILE_CONTENT_H,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: SizesCst.sso + 15,
                      right: SizesCst.sso,
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AssetsExplorer.icon('image-outline.svg'),
                          color: Get.theme.colorScheme.secondary,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            'Change your avatar',
                            style: TextStyle(
                              fontSize: SizesCst.ftsv,
                              color: Get.theme.colorScheme.primary,
                            ),
                          ),
                        ),
                        AmpereSquareButton(
                          iconPath:
                              AssetsExplorer.icon('color-picker-outline.svg'),
                          onTap: onTap,
                          color: Colors.blue,
                          sizeFactor: .9,
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
            _TileEditableContent(
              onSubmitted: () {
                print('on submitted success');
              },
              defHint: 'insert a name',
              editControllers: [
                TextEditingController(text: 'Omar IDOUDAOUD'),
              ],
              iconPath: AssetsExplorer.icon('person-outline.svg'),
              tileContent: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Edit Name',
                    style: TextStyle(
                      fontSize: SizesCst.ftsv,
                      color: Get.theme.colorScheme.primary,
                    ),
                  ),
                  Text(
                    'Omar IDOUDAOUD',
                    style: TextStyle(
                      color: Get.theme.colorScheme.secondary,
                      fontSize: SizesCst.ftsh,
                    ),
                  )
                ],
              ),
            ),
            _TileEditableContent(
              onSubmitted: () {
                print('on submitted success');
              },
              defHint: 'email',
              editControllers: [
                TextEditingController(text: 'pcomar.lenovo@gmail.com'),
              ],
              iconPath: AssetsExplorer.icon('email-outline.svg'),
              tileContent: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Edit Email',
                    style: TextStyle(
                      fontSize: SizesCst.ftsv,
                      color: Get.theme.colorScheme.primary,
                    ),
                  ),
                  Text(
                    'pcomar.lenovo@gmail.com',
                    style: TextStyle(
                      color: Get.theme.colorScheme.secondary,
                      fontSize: SizesCst.ftsh,
                    ),
                  )
                ],
              ),
            ),
            Builder(builder: (context) {
              void onTap() => BottomSheetScreen(
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: [
                          //
                          _getThemeModeRow('question-mark-outline.svg',
                              'default system theme', 'SYSTEM-ID'),
                          _getThemeModeRow(
                              'sun-outline.svg', 'light theme', 'LIGHT-ID'),
                          _getThemeModeRow(
                              'moon-outline.svg', 'dark theme', 'DARK-ID'),
                        ],
                      ),
                    ),
                    topBar: BottomSheetTopBar(
                        title: 'Change theme',
                        recommandedOption:
                            SheetTopBarRecommandedExitOptions.confirm,
                        onConfirm: () {
                          BottomSheetScreen.hide();
                        },
                        onDiscard: () {
                          BottomSheetScreen.hide();
                        }),
                  );
              return AmpereItemRowClickable(
                onTap: onTap,
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: _DEF_TILE_CONTENT_H,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: SizesCst.sso + 15,
                      right: SizesCst.sso,
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AssetsExplorer.icon('color-palette-outline.svg'),
                          color: Get.theme.colorScheme.secondary,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Change Theme',
                                style: TextStyle(
                                  fontSize: SizesCst.ftsv,
                                  color: Get.theme.colorScheme.primary,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'dark',
                                    style: TextStyle(
                                      color: Get.theme.colorScheme.secondary,
                                      fontSize: SizesCst.ftsh,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  SvgPicture.asset(
                                    AssetsExplorer.icon('moon-outline.svg'),
                                    color: Get.theme.colorScheme.secondary,
                                    height: 10,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        AmpereSquareButton(
                          iconPath:
                              AssetsExplorer.icon('color-picker-outline.svg'),
                          onTap: onTap,
                          color: Colors.blue,
                          sizeFactor: .9,
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
            _TileEditableContent(
              onSubmitted: () {
                print('on submitted success');
              },
              defHint: 'add a link',
              editControllers: [
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
              ],
              iconPath: AssetsExplorer.icon('message-circle-outline.svg'),
              tileContent: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Communication materials',
                    style: TextStyle(
                      fontSize: SizesCst.ftsv,
                      color: Get.theme.colorScheme.primary,
                    ),
                  ),
                  Text(
                    'one link found',
                    style: TextStyle(
                      color: Get.theme.colorScheme.secondary,
                      fontSize: SizesCst.ftsh,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 70,
            ),
          ],
        )
      ],
    );
  }

  _getPictureSourceRow(iconPath, text, onTap) => //
      AmpereClickable(
        onTap: onTap,
        builder: (focus) => AnimatedContainer(
          duration: AnimationsCst.adrc,
          decoration: BoxDecoration(
            color: focus ? Colors.grey.withOpacity(.2) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            children: [
              SvgPicture.asset(
                AssetsExplorer.icon(
                  iconPath,
                ),
                height: 20,
                color: Get.theme.colorScheme.primary,
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    color: Get.theme.colorScheme.primary,
                    fontSize: SizesCst.ftsv,
                  ),
                ),
              ),
              SvgPicture.asset(
                AssetsExplorer.icon(
                  'external-link-outline.svg',
                ),
                height: 20,
                color: Get.theme.colorScheme.secondary,
              )
            ],
          ),
        ),
      );

  _getThemeModeRow(iconPath, text, rowId) => AmpereClickable(
        onTap: () {
          _themeSelectedRadioId.value = rowId;
        },
        builder: (focus) => AnimatedContainer(
          duration: AnimationsCst.adrc,
          decoration: BoxDecoration(
            color: focus ? Colors.grey.withOpacity(.2) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: Row(
            children: [
              SvgPicture.asset(
                AssetsExplorer.icon(
                  iconPath,
                ),
                height: 20,
                color: Get.theme.colorScheme.primary,
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    color: Get.theme.colorScheme.primary,
                    fontSize: SizesCst.ftsv,
                  ),
                ),
              ),
              IgnorePointer(
                child: ValueListenableBuilder(
                  valueListenable: _themeSelectedRadioId,
                  builder: (context, c, v) {
                    return SvgPicture.asset(
                      AssetsExplorer.icon('checkmark-outline.svg'),
                      height: 22.5,
                      color: rowId == _themeSelectedRadioId.value
                          ? Get.theme.colorScheme.primary
                          : Colors.transparent,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      );
}

class _TileEditableContent extends StatefulWidget {
  const _TileEditableContent({
    Key? key,
    required this.iconPath,
    required this.tileContent,
    required this.editControllers,
    this.onSubmitted,
    this.editfieldsHints,
    this.defHint = '',
  }) : super(key: key);
  final String iconPath;
  final Column tileContent;
  final List<TextEditingController> editControllers;
  final Function()? onSubmitted;
  final List<String>? editfieldsHints;
  final String defHint;
  @override
  State<_TileEditableContent> createState() => _TileEditableContentState();
}

class _TileEditableContentState extends State<_TileEditableContent> {
  bool _isOpened = false;
  bool _canShowFields = false;

  late List<ValueNotifier<bool>> _editFieldsVisibilityNotifiers;
  bool _canCallAnimationFun = true;
  final Duration _fadeAnDuration = AnimationsCst.adra;

  @override
  void initState() {
    // TODO: implement initState
    _editFieldsVisibilityNotifiers = List.generate(
      widget.editControllers.length,
      (index) => ValueNotifier(false),
    );
  }

  void _setEditFieldsAnimation() async {
    if (!_canCallAnimationFun) return;
    _canCallAnimationFun = false;

    Future.delayed(_fadeAnDuration +
            Duration(milliseconds: 100) * widget.editControllers.length)
        .then((value) => _canCallAnimationFun = true);
    if (!_isOpened) {
      setState(() {
        _isOpened = true;
      });
      print('test passed');
      await Future.delayed(_fadeAnDuration - Duration(milliseconds: 100));
      int n = 0;
      while (_editFieldsVisibilityNotifiers.length - 1 >= n) {
        await Future.delayed(Duration(milliseconds: 100));
        _editFieldsVisibilityNotifiers[n].value = true;
        n++;
      }
    } else {
      print('test 3 passed');
      int n = _editFieldsVisibilityNotifiers.length - 1;
      while (0 <= n) {
        await Future.delayed(Duration(milliseconds: 100));
        _editFieldsVisibilityNotifiers[n].value = false;
        n--;
      }
      await Future.delayed(_fadeAnDuration - Duration(milliseconds: 100));

      setState(() {
        _isOpened = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AmpereItemRowClickable(
          onTap: () {
            _setEditFieldsAnimation();
          },
          child: Container(
            constraints: BoxConstraints(
              minHeight: _DEF_TILE_CONTENT_H,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: SizesCst.sso + 15,
                right: SizesCst.sso,
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    widget.iconPath,
                    color: Get.theme.colorScheme.secondary,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: widget.tileContent,
                  ),
                  ValueListenableBuilder(
                    valueListenable: _editFieldsVisibilityNotifiers.first,
                    builder: (ctx, bool v, c) => AnimatedOpacity(
                      opacity: v ? 1 : 0,
                      duration: AnimationsCst.adrc,
                      child: AnimatedScale(
                        scale: v ? 1 : 0,
                        duration: AnimationsCst.adrc,
                        child: c,
                      ),
                    ),
                    child: AmpereSquareButton(
                      iconPath: AssetsExplorer.icon('checkmark-outline.svg'),
                      onTap: () {
                        widget.onSubmitted;
                        _setEditFieldsAnimation();
                      },
                      color: Colors.green,
                      sizeFactor: .9,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: SizesCst.ssg,
            right: SizesCst.sso,
          ),
          child: AnimatedCrossFade(
            firstChild: SizedBox.shrink(),
            secondChild: ListView.separated(
              separatorBuilder: (ctx, i) => SizedBox(
                height: 10,
              ),
              shrinkWrap: true,
              itemBuilder: (ctx, i) => ValueListenableBuilder<bool>(
                valueListenable: _editFieldsVisibilityNotifiers[i],
                builder: (ctx, v, c) => AnimatedOpacity(
                  opacity: v ? 1 : 0,
                  duration: AnimationsCst.adrc,
                  curve: AnimationsCst.acra,
                  child: AnimatedScale(
                    scale: v ? 1 : .9,
                    duration: AnimationsCst.adrc,
                    child: c,
                  ),
                ),
                child: AmpereTextField(
                  controller: widget.editControllers[i],
                  hint: widget.editfieldsHints != null
                      ? widget.editfieldsHints![i]
                      : widget.defHint,
                ),
              ),
              itemCount: widget.editControllers.length,
            ),
            crossFadeState: _isOpened
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: _fadeAnDuration,
            sizeCurve: AnimationsCst.acra,
            firstCurve: AnimationsCst.acra,
            secondCurve: AnimationsCst.acra,
          ),
        )
      ],
    );
  }
}

class BottomSheetShowerButton extends StatefulWidget {
  BottomSheetShowerButton(
      {Key? key, required this.label, required this.iconPath, this.onTap})
      : super(key: key) {
    onTap ??= () {};
  }

  final String label;
  final String iconPath;
  Function()? onTap;

  @override
  State<BottomSheetShowerButton> createState() =>
      BottomSheetShowerButtonState();
}

class BottomSheetShowerButtonState extends State<BottomSheetShowerButton> {
  @override
  Widget build(BuildContext context) {
    return AmpereClickable(
        onTap: widget.onTap,
        builder: (focus) {
          return AnimatedContainer(
            duration: focus ? 50.milliseconds : 200.milliseconds,
            height: 60,
            foregroundDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizesCst.rsc),
              color:
                  focus ? Get.theme.colorScheme.surface.withOpacity(.2) : null,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizesCst.rsc),
              border: Border.all(
                color: Get.isDarkMode
                    ? Get.theme.colorScheme.primary
                    : Get.theme.colorScheme.secondary,
                width: SizesCst.bsa,
              ),
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.label,
                    style: TextStyle(
                      fontSize: SizesCst.ftsv,
                      fontWeight: FontsCst.wfa,
                      color: Get.isDarkMode
                          ? Get.theme.colorScheme.primary
                          : Get.theme.colorScheme.secondary,
                    ),
                  ),
                  SizedBox(width: 10),
                  SvgPicture.asset(
                    widget.iconPath,
                    color: Get.isDarkMode
                        ? Get.theme.colorScheme.primary
                        : Get.theme.colorScheme.secondary,
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class MenuShowerButton extends StatefulWidget {
  MenuShowerButton({
    Key? key,
    this.label,
    required this.menuItems,
    this.onSelectNewItem,
    this.initialSelectedIndex = 0,
  }) : super(key: key) {
    onSelectNewItem ??= (i) {};
  }
  final String? label;
  final List<String> menuItems;
  Function(int itemIndex)? onSelectNewItem;
  final int initialSelectedIndex;
  @override
  State<MenuShowerButton> createState() => _MenuShowerButtonState();
}

class _MenuShowerButtonState extends State<MenuShowerButton> {
  final _key = GlobalKey();
  late Offset _position;
  late Size _size;

  void _renderPositionAndSize() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    final RenderBox box = _key.currentContext!.findRenderObject()! as RenderBox;
    _position = box.localToGlobal(Offset.zero);
    _size = box.size;
    // });
  }

  bool _isFocus = false;
  late String label;
  late int _selectedItem;
  @override
  void initState() {
    // TODO: implement initState
    _selectedItem = widget.initialSelectedIndex;
    label =
        widget.label ?? widget.menuItems.elementAt(widget.initialSelectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (dts) {
        setState(() {
          _isFocus = false;
        });
      },
      onTapDown: (dts) {
        setState(() {
          _isFocus = true;
        });
      },
      onTapCancel: () {
        setState(() {
          _isFocus = false;
        });
      },
      onTap: () {
        _renderPositionAndSize();
        Navigator.push(
          context,
          AmpereDialogPageRoute(
            barrierDismissible: true,
            transitionDuration: Duration(milliseconds: 600),
            builder: ((context) {
              final offset = Offset(_position.dx + _size.width, _position.dy);

              return AmpereItemsMenu(
                scaleStartAnimationPoint: Alignment.topRight,
                initialOffset: offset,
                items: widget.menuItems,
                onSelectNewItem: (i) {
                  widget.onSelectNewItem!(i);
                  _selectedItem = i;
                  setState(() {
                    if (widget.label == null)
                      label = widget.menuItems.elementAt(i);
                  });
                },
                initialSelectedIndex: _selectedItem,
              );
            }),
          ),
        );
      },
      child: AnimatedContainer(
        key: _key,
        duration: Duration(milliseconds: 70),
        padding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          color: _isFocus
              ? Colors.grey[400]!.withOpacity(.5)
              : Colors.grey[400]!.withOpacity(.2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: Get.theme.colorScheme.primary,
                  fontSize: SizesCst.ftsc,
                ),
              ),
            ),
            SvgPicture.asset(
              AssetsExplorer.icon('arrow-ios-downward-outline.svg'),
              height: 20,
              color: Get.theme.colorScheme.primary,
            )
          ],
        ),
      ),
    );
  }
}

class DateTimeSelector extends StatefulWidget {
  const DateTimeSelector(
      {Key? key, required this.initialDateTime, required this.onChangeDateTime})
      : super(key: key);
  final DateTime initialDateTime;
  final Function(DateTime dateTime) onChangeDateTime;

  @override
  State<DateTimeSelector> createState() => DateTimeSelectorState();
}

class DateTimeSelectorState extends State<DateTimeSelector>
    with TickerProviderStateMixin {
  late DateTime _dateTime;

  @override
  void initState() {
    // TODO: implement initState
    _dateTime = widget.initialDateTime;
  }

  @override
  Widget build(BuildContext context) {
    return AmpereClickable(onTap: () {
      DialogScreen(
        _getContent(),
        transitionDuration: Duration(milliseconds: 300),
        hasConfirm: true,
        hasDiscard: true,
        confirmLabel: 'Ok',
        discardLabel: 'Cancel',
        recommendedOption: DialogRecommendedOption.confirm,
        padding: SizesCst.ssa,
        alignment: Alignment.bottomCenter,
        scaleAnimationFrom: 1,
      );
    }, builder: (focus) {
      return AnimatedContainer(
        duration: focus ? 50.milliseconds : 100.milliseconds,
        height: 60,
        foregroundDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizesCst.rsc),
          color: focus ? Get.theme.colorScheme.surface.withOpacity(.2) : null,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizesCst.rsc),
          border: Border.all(
            color: Get.theme.colorScheme.secondary,
            width: SizesCst.bsa,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat("yyyy/MM/dd HH:mm").format(_dateTime),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: SizesCst.ftsv,
                  fontWeight: FontsCst.wfa,
                  color: Get.theme.colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _getContent() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            DateFormat("yyyy/MM/dd HH:mm").format(_dateTime),
            key: ValueKey<DateTime>(_dateTime),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: SizesCst.ftsb,
              fontWeight: FontsCst.wfa,
              color: Get.theme.colorScheme.primary,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          LimitedBox(
            maxHeight: 120,
            child: CupertinoDatePicker(
              onDateTimeChanged: (date) {
                setState(() {
                  _dateTime = DateTime(
                    date.year,
                    date.month,
                    date.day,
                    _dateTime.hour,
                    _dateTime.minute,
                  );
                });
              },
              mode: CupertinoDatePickerMode.date,
              use24hFormat: true,
            ),
          ),
          LimitedBox(
            maxHeight: 120,
            child: CupertinoDatePicker(
              onDateTimeChanged: (datetime) {
                setState(() {
                  _dateTime = datetime;
                });
              },
              mode: CupertinoDatePickerMode.time,
              initialDateTime: _dateTime,
              use24hFormat: true,
            ),
          ),
        ],
      );
}

class CountSelector extends StatefulWidget {
  CountSelector({
    Key? key,
    this.minimumValue = -1000000000,
    this.maximumVlaue = 1000000000,
    this.suffixTermOne = "",
    this.suffixTermTwo,
    this.initialCount,
    required this.countUpIconPath,
    required this.countDownIconPath,
    required this.onChangeCount,
  }) : super(key: key) {
    initialCount ??= minimumValue;
  }
  int? initialCount;
  final int? minimumValue;
  final int? maximumVlaue;
  final String? suffixTermOne;
  final String? suffixTermTwo;
  final String countUpIconPath;
  final String countDownIconPath;
  final Function(int count) onChangeCount;
  @override
  State<CountSelector> createState() => _CountSelectorState();
}

class _CountSelectorState extends State<CountSelector> {
  late Timer _timer;
  int _count = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _count = widget.initialCount!;
  }

  void _increase() {
    setState(() {
      if (_count < widget.maximumVlaue!) _count++;
    });
  }

  void _decrease() {
    setState(() {
      if (_count > widget.minimumValue!) _count--;
    });
  }

  void _startLongIncrease() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (time) {
      setState(() {
        _increase();
      });
    });
  }

  void _startLongDecrease() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (time) {
      setState(() {
        _decrease();
      });
    });
  }

  void _stopCounter() {
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(SizesCst.rsc),
        border: Border.all(
          color: Get.isDarkMode
              ? Get.theme.colorScheme.primary
              : Get.theme.colorScheme.secondary,
          width: SizesCst.bsa,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 11),
        child: Row(
          children: [
            AnimatedSwitcher(
              duration: Duration(milliseconds: 100),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(
                  scale: animation,
                  child: child,
                );
              },
              child: Text(
                _count.toString(),
                key: ValueKey<int>(_count),
                style: TextStyle(
                  fontSize: SizesCst.ftsv,
                  fontWeight: FontsCst.wfa,
                  color: Get.theme.colorScheme.primary,
                ),
              ),
            ),
            Text(
              " " +
                  (_count > 10
                      ? widget.suffixTermOne
                      : widget.suffixTermTwo ?? widget.suffixTermOne)!,
              style: TextStyle(
                fontSize: SizesCst.ftsv,
                fontWeight: FontsCst.wfa,
                color: Get.theme.colorScheme.primary,
              ),
            ),
            Spacer(),
            AmpereSquareButton(
              iconPath: widget.countUpIconPath,
              sizeFactor: .9,
              onTap: () {
                _increase();
                widget.onChangeCount(_count);
              },
              onLongPress: () {},
              onLongPressStart: (dts) {
                _startLongIncrease();
              },
              onLongPressEnd: (dts) {
                _stopCounter();
                widget.onChangeCount(_count);
              },
              color: ColorsCst.clrm,
            ),
            SizedBox(
              width: 2,
            ),
            AmpereSquareButton(
              iconPath: widget.countDownIconPath,
              sizeFactor: .9,
              onTap: () {
                _decrease();
                widget.onChangeCount(_count);
              },
              onLongPress: () {},
              onLongPressStart: (dts) {
                _startLongDecrease();
              },
              onLongPressEnd: (dts) {
                _stopCounter();
                widget.onChangeCount(_count);
              },
              color: ColorsCst.clrm,
            ),
          ],
        ),
      ),
    );
  }
}

class RateRow extends StatelessWidget {
  const RateRow({Key? key, required this.rate, double this.height = 15})
      : super(key: key);
  final int rate;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) => SvgPicture.asset(
          AssetsExplorer.icon('star.svg'),
          color: rate <= index
              ? Colors.grey[400]!.withOpacity(.5)
              : Colors.yellowAccent,
          height: height,
        ),
      ),
    );
  }
}
