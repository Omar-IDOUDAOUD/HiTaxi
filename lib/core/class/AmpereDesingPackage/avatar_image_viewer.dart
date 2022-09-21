import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/dialog_page_route.dart';
import 'package:hitaxi/core/utils/assets_explorer.dart';

import '../../constants/animation.dart';

const String _TAGHERO = 'HEROANIMATION-TAG';

class AmpereAvatarImageViewer extends StatefulWidget {
  AmpereAvatarImageViewer(
      {Key? key,
      required this.avatarImagePath,
      required this.avatarNoImagePath})
      : super(key: key);
  final String? avatarImagePath;
  final String avatarNoImagePath;

  @override
  State<AmpereAvatarImageViewer> createState() =>
      _AmpereAvatarImageViewerState();
}

class _AmpereAvatarImageViewerState extends State<AmpereAvatarImageViewer> {
  bool _canScaleImage = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('on testpass');
        if (_canScaleImage)
          Navigator.push(
            context,
            AmpereDialogPageRoute(
              transitionDuration: Duration(milliseconds: 600),
              builder: ((context) => _ImageViewer(
                    imagePath: widget.avatarImagePath!,
                  )),
            ),
          );
      },
      child: Hero(
        tag: _TAGHERO,
        child: FittedBox(
          child: CircleAvatar(
            onForegroundImageError: (ob, st) {
              _canScaleImage = false;
            },
            radius: Get.size.width,
            backgroundImage: (widget.avatarImagePath!.isURL
                ? NetworkImage(widget.avatarNoImagePath)
                : AssetImage(widget.avatarNoImagePath)) as ImageProvider,
            backgroundColor: Colors.grey.withOpacity(.2),
            foregroundImage: (widget.avatarImagePath!.isURL
                    ? NetworkImage(widget.avatarImagePath ?? 'NO_IMAGE')
                    : AssetImage(widget.avatarImagePath ?? 'NO_IMAGE'))
                as ImageProvider,
            foregroundColor: Colors.grey.withOpacity(.2),
          ),
        ),
      ),
    );
  }
}

class _ImageViewer extends StatefulWidget {
  _ImageViewer({Key? key, required this.imagePath}) : super(key: key);

  final String imagePath;
  @override
  State<_ImageViewer> createState() => __ImageViewerState();
}

class __ImageViewerState extends State<_ImageViewer>
    with SingleTickerProviderStateMixin {
  bool _canExit = false;

  late AnimationController _anCtrl;
  late Animation<double> _an;
  ValueNotifier _notifier = ValueNotifier(ObjectKey);
  final _reserveDuration = Duration(milliseconds: 600) ~/ 2;
  final Duration _animationDuration = Duration(milliseconds: 600);

  @override
  void initState() {
    _anCtrl = AnimationController(
      vsync: this,
      duration: _animationDuration,
      reverseDuration: _reserveDuration,
    );
    _an = Tween(begin: Get.size.width * 2, end: 0.0)
        .animate(CurvedAnimation(parent: _anCtrl, curve: AnimationsCst.acra))
      ..addListener(() {
        _notifier.notifyListeners();
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) _canExit = true;
      });
    _anCtrl.forward();
  }

  void _exit() async {
    if (_canExit) {
      await _anCtrl.reverse();
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _exit();
      },
      child: InteractiveViewer(
        onInteractionStart: (dts) {
          _canExit = false;
        },
        onInteractionEnd: (dts) {
          _canExit = true;
        },
        onInteractionUpdate: (dts) {
          if (dts.scale < .6) {
            _exit();
          }
        },
        maxScale: 100,
        child: ColoredBox(
          color: Colors.transparent,
          child: Hero(
            tag: _TAGHERO,
            child: FittedBox(
              child: ValueListenableBuilder(
                  valueListenable: _notifier,
                  builder: (context, v, c) {
                    return Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(_an.value),
                        color: Get.theme.backgroundColor,
                      ),
                      child: widget.imagePath.isURL
                          ? Image.network(
                              widget.imagePath,
                              fit: BoxFit.contain,
                              alignment: Alignment.center,
                            )
                          : Image.asset(
                              widget.imagePath,
                              fit: BoxFit.contain,
                              alignment: Alignment.center,
                            ),
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
