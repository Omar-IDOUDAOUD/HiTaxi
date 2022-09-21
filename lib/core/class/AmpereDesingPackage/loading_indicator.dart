import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hitaxi/core/constants/animation.dart';

class AmpereLoadingIndicator extends StatefulWidget {
  const AmpereLoadingIndicator({Key? key}) : super(key: key);

  @override
  State<AmpereLoadingIndicator> createState() => _AmpereLoadingIndicatorState();
}

class _AmpereLoadingIndicatorState extends State<AmpereLoadingIndicator>
    with TickerProviderStateMixin {
  late AnimationController _transformAnCtrl;
  late Animation<double> _transformAn;

  late AnimationController _rotationYAnCtrl;
  late Animation<double> _rotationYAn;

  @override
  void initState() {
    _transformAnCtrl = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1100),
        reverseDuration: Duration.zero);
    _transformAn = Tween(begin: .0, end: 75.0).animate(
      _transformAnCtrl,
    )..addListener(() {
        setState(() {});
      });

    _rotationYAnCtrl =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _rotationYAn = Tween(begin: pi / 2, end: .0).animate(_rotationYAnCtrl)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          print("case 1 ");
          Future.delayed(Duration(milliseconds: 400))
            ..then((value) {
              _rotationYAnCtrl.reverse();
            });
        } else if (status == AnimationStatus.dismissed) {
          _transformAnCtrl.reverse();
          _transformAnCtrl.forward();
          _rotationYAnCtrl.forward();
        }
      });

    _rotationYAnCtrl.forward();
    _transformAnCtrl.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    this._transformAnCtrl.dispose(); 
    this._rotationYAnCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 33,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform(
            alignment: FractionalOffset.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..translate(_transformAn.value)
              ..rotateY(_rotationYAn.value)
              ..rotateZ(_transformAn.value / 6 / pi),
            child: Cartwheel(),
          ),
          Container(
            height: 3,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(1.5),
            ),
          )
        ],
      ),
    );
  }
}

class Cartwheel extends StatelessWidget {
  const Cartwheel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
        color: Colors.transparent,
      ),
      padding: EdgeInsets.all(2),
      child: Stack(
        children: [
          Align(
              alignment: Alignment.topCenter,
              child: Transform.rotate(
                angle: pi,
                child: _cartWheelPart,
              )),
          Align(
            alignment: Alignment.centerRight,
            child: Transform.rotate(angle: pi + pi / 2, child: _cartWheelPart),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Transform.rotate(angle: pi + pi, child: _cartWheelPart),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Transform.rotate(angle: pi / 2, child: _cartWheelPart),
          ),
        ],
      ),
    );
  }

  get _cartWheelPart => ClipPath(
        child: Container(
          color: Colors.white,
          height: 9,
          width: 4.5,
        ),
        clipper: CartwheelPart(),
      );
}

class CartwheelPart extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var path = Path();
    double c = size.width * 0.3;
    path.moveTo(size.width - c, 0);
    path.lineTo(0, size.height * 0.5);
    path.lineTo(size.width - c, size.height);
    path.lineTo(size.width, size.height - c);
    path.lineTo(c * 1.5, size.height * 0.5);
    path.lineTo(size.width, c);
    path.lineTo(size.width - c, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
