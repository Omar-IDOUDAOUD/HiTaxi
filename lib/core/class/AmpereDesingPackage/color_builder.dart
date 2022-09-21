// import 'package:flutter/material.dart';

// class AmpereColorBuilder extends StatefulWidget {
//   Function _f = () {};

//   AmpereColorBuilder({
//     Key? key,
//     this.unfocusColor = Colors.transparent,
//     required this.focusColor,
//     required this.builder,
//     this.onTap,
//     this.onLongPressStart,
//     this.onLongPressEnd,
//   }) : super(key: key) {
//     onTap ??= () {};
//     onLongPressStart ??= _f;
//     onLongPressEnd ??= _f;
//   }
//   final Color unfocusColor;
//   final Color focusColor;
//   final Widget Function(Color currentColor, bool isFocus) builder;
//   Function? onTap;
//   Function? onLongPressStart;
//   Function? onLongPressEnd;
//   @override
//   State<AmpereColorBuilder> createState() => _AmpereColorBuilderState();
// }

// class _AmpereColorBuilderState extends State<AmpereColorBuilder> {
//   bool _isFocused = false;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         widget.onTap!();
//       },
//       onTapDown: (dets) {
//         setState(() {
//           _isFocused = true;
//           print("case 1"); 
//         });
//       },
//       onTapUp: (dets) {
//         setState(() {
//           _isFocused = false;
//           print("case 2"); 
//         });
//       },
//       onTapCancel: () { 
//         setState(() {
//           _isFocused = false;
//           print("case 3"); 
//         });
//       },
//       onLongPress: () { 
//         setState(() {
//           _isFocused = true;
//           print("case 4"); 
//         });
//         widget.onLongPressStart!();
//       },
//       onLongPressUp: () { 
//         setState(() {
//           _isFocused = false;
//           print("case 5"); 
//         });
//         widget.onLongPressEnd!();
//       },
//       child: widget.builder(
//           _isFocused ? widget.focusColor : widget.unfocusColor, _isFocused),
//     );
//   }
// }
