import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/parser.dart';
import 'package:get/get.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/scallable.dart';
import 'package:hitaxi/core/constants/animation.dart';
import 'package:hitaxi/core/constants/color.dart';
import 'package:hitaxi/core/constants/font.dart';
import 'package:hitaxi/core/constants/size.dart';

typedef _validatorShape = Map<String, String>? Function();

class AmpereTextField extends StatefulWidget {
  AmpereTextField({
    Key? key,
    this.prefixIconPath,
    this.prefexIconSize = 20,
    this.hint = '',
    this.controller,
    this.passLockIconPath = null,
    this.errorTilePrefixIconPath,
    this.enabled = true,
    this.validator,
    this.alertIcon,
    this.passLickIconSize = 20,
    this.disabledColor,
    this.enabledColor,
  })  : _preIconFound = prefixIconPath != null,
        _sufIconFound = passLockIconPath != null,
        super(key: key);

  final String? prefixIconPath;
  final double? prefexIconSize;
  final String hint;
  final TextEditingController? controller;
  final double? passLickIconSize;
  final String? passLockIconPath;
  final String? errorTilePrefixIconPath;
  final bool enabled;
  final _validatorShape? validator;
  final String? alertIcon;
  final bool _preIconFound;
  final bool _sufIconFound;
  final Color? enabledColor;
  final Color? disabledColor;

  @override
  State<AmpereTextField> createState() => _AmpereTextFieldState();
}

class _AmpereTextFieldState extends State<AmpereTextField>
    with TickerProviderStateMixin {
  late bool _canShowPass;
  bool _readyToHideErrorSpace = false;
  late AnimationController _errorMessageAnCtrl;
  late Animation<double> _errorMessageAn;

  String? _errorTileTitle;
  String? _errorTileSubject;
  bool _errorOcurred = false;

  @override
  void initState() {
    print("initing");
    // TODO: implement initState
    this._errorMessageAnCtrl =
        AnimationController(vsync: this, duration: AnimationsCst.adra);
    this._errorMessageAn = Tween(begin: 0.0, end: 40.0).animate(
        new CurvedAnimation(
            parent: this._errorMessageAnCtrl, curve: AnimationsCst.acra))
      ..addListener(() {
        setState(() {});
      });
    _canShowPass = widget.passLockIconPath != null;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _errorMessageAnCtrl.dispose();
  }

  void _callValidator() {
    if (widget.validator != null) {
      Map<String, String>? errorContent = widget.validator!();
      if (errorContent != null) {
        setState(() {
          _errorOcurred = true;
          _errorTileSubject = errorContent['subject'];
          _errorTileTitle = errorContent['title'];
        });
      } else {
        setState(() {
          _errorOcurred = false;
          _errorTileSubject = null;
          _errorTileTitle = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_errorOcurred && !_errorMessageAnCtrl.isAnimating)
      _errorMessageAnCtrl.forward();
    else if (_readyToHideErrorSpace && !_errorMessageAnCtrl.isAnimating)
      _errorMessageAnCtrl.reverse();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextField(
          cursorHeight: 25,
          cursorColor: null,
          enabled: widget.enabled,
          controller: widget.controller,
          onChanged: (String val) {
            _callValidator();
          },
          obscureText: _canShowPass,
          style: TextStyle(
            height: 1.3,
            fontSize: SizesCst.ftsv,
            fontWeight: FontsCst.wfa,
            color: Get.theme.colorScheme.primary,
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(
              color: widget.enabled
                  ? widget.enabledColor ?? Get.theme.colorScheme.secondary
                  : widget.disabledColor ??
                      Get.theme.colorScheme.secondary.withOpacity(.5),
            ),
            suffixIconConstraints: BoxConstraints.expand(
                height: SizesCst.ssk,
                width: widget._sufIconFound ? SizesCst.ssz : 25),
            prefixIconConstraints: BoxConstraints.expand(
                height: SizesCst.ssk,
                width: widget._preIconFound ? SizesCst.ssz : 23),
            prefixIcon: widget.prefixIconPath != null
                ? Padding(
                    padding: EdgeInsets.only(
                        left: 7,
                        top: widget.prefexIconSize!,
                        bottom: widget.prefexIconSize!),
                    child: SvgPicture.asset(
                      widget.prefixIconPath!,
                      color: widget.enabled
                          ? widget.enabledColor ??
                              Get.theme.colorScheme.secondary
                          : widget.disabledColor ??
                              Get.theme.colorScheme.secondary.withOpacity(.5),
                    ),
                  )
                : SizedBox.shrink(),
            prefixIconColor: Get.theme.colorScheme.secondary,
            focusColor: Get.theme.colorScheme.primary,
            suffixIcon: widget._sufIconFound
                ? Padding(
                    padding: EdgeInsets.only(
                        right: 7,
                        top: widget.passLickIconSize!,
                        bottom: widget.passLickIconSize!),
                    child: GestureDetector(
                      onTap: () => setState(
                        () {
                          _canShowPass = !_canShowPass;
                        },
                      ),
                      child: SvgPicture.asset(
                        widget.passLockIconPath!,
                        color: widget.enabled
                            ? widget.enabledColor ??
                                Get.theme.colorScheme.secondary
                            : widget.disabledColor ??
                                Get.theme.colorScheme.secondary.withOpacity(.5),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            contentPadding: EdgeInsets.zero,
            enabledBorder: OutlineInputBorder(
              gapPadding: 0,
              borderRadius: BorderRadius.circular(SizesCst.rsc),
              borderSide: BorderSide(
                color: widget.enabledColor ?? Get.theme.colorScheme.secondary,
                width: SizesCst.bsa,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              gapPadding: 0,
              borderRadius: BorderRadius.circular(SizesCst.rsc),
              borderSide: BorderSide(
                color: ColorsCst.clrz,
                width: SizesCst.bsb,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              gapPadding: 0,
              borderRadius: BorderRadius.circular(SizesCst.rsc),
              borderSide: BorderSide(
                color: widget.disabledColor ??
                    Get.theme.colorScheme.secondary.withOpacity(.5),
                width: SizesCst.bsa,
              ),
            ),
          ),
        ),
        LimitedBox(
          maxHeight: _errorMessageAn.value,
          child: Stack(alignment: Alignment.centerLeft, children: [
            Positioned(
              top: 5,
              left: 10,
              right: 10,
              child: AnimatedOpacity(
                opacity: _errorMessageAn.isCompleted && _errorOcurred ? 1 : 0,
                duration: AnimationsCst.adra,
                curve: AnimationsCst.acra,
                onEnd: () {
                  setState(() {
                    if (!_errorOcurred) _readyToHideErrorSpace = true;
                  });
                },
                child: AnimatedScale(
                  alignment: Alignment.center,
                  scale: _errorMessageAn.isCompleted && _errorOcurred ? 1 : .8,
                  duration: AnimationsCst.adra,
                  curve: AnimationsCst.acra,
                  child: GestureDetector(
                    onTap: () {
                      /// show error details alert;
                    },
                    child: Scallable(
                      minScaleValue: .95,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          widget.alertIcon != null
                              ? SvgPicture.asset(
                                  widget.alertIcon!,
                                  color: ColorsCst.clra,
                                  height: 17,
                                )
                              : Icon(Icons.warning_amber_rounded,
                                  size: 20, color: ColorsCst.clra),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            // width: Get.size.width * .6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _errorTileTitle ?? "",
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontsCst.wfc,
                                    fontSize: SizesCst.ftsh,
                                    color: ColorsCst.clra,
                                  ),
                                  maxLines: 1,
                                ),
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  _errorTileSubject ?? "",
                                  style: TextStyle(
                                    fontSize: SizesCst.ftsh,
                                    color: ColorsCst.clra,
                                  ),
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        )
      ],
    );
  }
}
