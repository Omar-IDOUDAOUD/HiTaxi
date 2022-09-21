import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitaxi/controller/main/passenger_controller.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/navigation_bar.dart';
import 'package:hitaxi/core/constants/animation.dart';
import 'package:hitaxi/core/constants/size.dart';
import 'package:hitaxi/view/screen/main/passenger/pages/home/widgets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PassengerController _controller = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: PageView.builder(
                controller: _controller.pageController,
                itemBuilder: (BuildContext context, int index) =>
                    _controller.pageComponents.tabs.elementAt(index),
                itemCount: _controller.pageComponents.tabs.length,
                physics: BouncingScrollPhysics(),
              ),
            ),
            GetBuilder<PassengerController>(
              id: NAVIGATIONBAR_ID,
              builder: (c) {
                return AnimatedPositioned(
                  duration: Duration(milliseconds: 800),
                  curve: AnimationsCst.acra,
                  bottom: c.canShowNavigationBar ? SizesCst.ssa : -100,
                  left: SizesCst.ssa,
                  right: SizesCst.ssa,
                  child: AmpereNavigationBar(
                    labels: _controller.pageComponents.navLabels,
                    onUpdate: _controller.onTabUpdate,
                    initialActiveId: _controller.activedId,
                  ),
                );
              },
            ),
            GetBuilder<PassengerController>(
              id: SEARCHCARD_ID,
              init: _controller,
              builder: (c) {
                return AnimatedPositioned(
                  duration: Duration(milliseconds: 800),
                  curve: AnimationsCst.acra,
                  top: c.canShowSearchCard ? SizesCst.ssa : -Get.size.height,
                  right: SizesCst.ssa,
                  left: SizesCst.ssa,
                  child: TopSearchCard(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
