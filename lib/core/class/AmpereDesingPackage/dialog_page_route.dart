import 'package:flutter/material.dart';

class AmpereDialogPageRoute<T> extends PageRoute<T> {
  AmpereDialogPageRoute({
    required WidgetBuilder builder,
    barrierDismissible = false,
    Duration? transitionDuration,
    RouteSettings? settings,
    Color? barrierColor,
    bool fullScreenDialog = false,
  })  : _builder = builder,
        _barrierDismissible = barrierDismissible,
        _transitionDuration = transitionDuration ?? Duration(milliseconds: 600),
        _barrierColor = barrierColor ?? Colors.black54,
        super(settings: settings, fullscreenDialog: fullScreenDialog);

  final WidgetBuilder _builder;
  final bool _barrierDismissible;
  final Duration _transitionDuration;
  final Color _barrierColor;

  @override
  // TODO: implement opaque
  bool get opaque => false;

  @override
  // TODO: implement fullscreenDialog
  bool get fullscreenDialog => super.fullscreenDialog;

  @override
  // TODO: implement barrierDismissible
  bool get barrierDismissible => _barrierDismissible;

  @override
  // TODO: implement barrierColor
  Color? get barrierColor => _barrierColor;

  @override
  // TODO: implement barrierLabel
  String? get barrierLabel => "pop dialog";

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return _builder(context);
  }

  @override
  // TODO: implement maintainState
  bool get maintainState => true;

  @override
  // TODO: implement transitionDuration
  Duration get transitionDuration => _transitionDuration;
}
