import 'package:flutter/animation.dart';

 abstract class AnimationsCst {
  AnimationsCst._(); 
  /// durations
  static const Duration adra = Duration(milliseconds: 400); //400
  static const Duration adrb = Duration(milliseconds: 200); //200
  static const Duration adrc = Duration(milliseconds: 100); //200

  /// Curves
  static const Curve acra = Curves.linearToEaseOut;
  static const Curve acrb = Cubic(0.175, 0.885, 0.32, 1.30);
  static const Curve acrc = Cubic(0.175, 0.885, 0.32, 1.10);
}