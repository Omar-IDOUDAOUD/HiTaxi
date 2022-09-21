import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/ampere.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/loading_indicator.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/radio.dart';
import 'package:hitaxi/core/shared/dialog_screen.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  ValueNotifier<String> x = ValueNotifier('r1');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        backgroundColor: Get.theme.backgroundColor,
        title: Text(
          "TEST FRAME",
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            height: null,
            bottom: 200,
            child: Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('simple text'),
                    SizedBox(
                      height: 50,
                      width: 40,
                      child: ColoredBox(color: Colors.green),
                    ),
                  ],
                ),
              ),
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
