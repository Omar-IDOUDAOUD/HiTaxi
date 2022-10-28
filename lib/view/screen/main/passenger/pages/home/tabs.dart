import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hitaxi/controller/main/passenger_controller.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/app_bar.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/dated_listview.dart';
import 'package:hitaxi/core/constants/constants.dart';
import 'package:hitaxi/core/utils/assets_explorer.dart';
import 'package:hitaxi/view/screen/main/passenger/pages/travel_details/page.dart';
import 'widgets.dart';

class Tab1 extends StatelessWidget {
  Tab1({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);
  final PassengerController _controller;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(
        top: 160,
        bottom: 50,
        left: SizesCst.ssa + 10,
        right: SizesCst.ssa + 10,
      ),
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext, int) => ConveyanceCard(
        onTap: () {
          _controller.startTravelDetailsRouteAnimation(openingState: false).then(
                (value) => Get.toNamed(
                  RoutesCst.mainPassengerTravelDetails,
                  arguments: ['arguments here (travel details model)'],
                ),
              );
        },
      ),
      itemCount: 5,
      separatorBuilder: (BuildContext, int) => SizedBox(
        height: 30,
        child: Center(
          child: Divider(
            color: Get.theme.colorScheme.secondary.withOpacity(.3),
            thickness: 1,
            height: 1,
            indent: 60,
            endIndent: 60,
          ),
        ),
      ),
    );
  }
}

class Tab2 extends StatelessWidget {
  const Tab2({
    Key? key,
    required controller,
  })  : _controller = controller,
        super(key: key);
  final PassengerController _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: SizesCst.ssq, left: SizesCst.ssa, right: SizesCst.ssq),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: AmpereAppBar(
              title: "HISTORY",
              suffix: '2',
              suffixIconPath: AssetsExplorer.icon('history-icon.svg'),
            ),
          ),
          SizedBox(
            height: SizesCst.ssa,
          ),
          Expanded(
            child: Stack(
              children: [
                AmpereDatedListView(
                  units: [
                    AmpereDatedListUnitData(
                      datetime: "yesterday, 15:30",
                      child: HistoryCard(),
                      childHeight: 200,
                    ),
                    AmpereDatedListUnitData(
                      // datetime: "test1",
                      child: HistoryCard(),
                      childHeight: 200,
                    ),
                    AmpereDatedListUnitData(
                      datetime: "friday, 15 August",
                      child: HistoryCard(),
                      childHeight: 200,
                    ),
                    AmpereDatedListUnitData(
                      datetime: "munday, 12 August",
                      child: HistoryCard(),
                      childHeight: 200,
                    ),
                    AmpereDatedListUnitData(
                      // datetime: "test1",
                      child: HistoryCard(),
                      childHeight: 200,
                    ),
                    AmpereDatedListUnitData(
                      datetime: "last",
                      child: HistoryCard(),
                      childHeight: 200,
                    ),
                    AmpereDatedListUnitData(
                      // datetime: "last",
                      child: SizedBox(),
                      childHeight: 55,
                    ),
                  ],
                ),
                Positioned(
                  bottom: 100,
                  right: 0,
                  child: MaterialButton(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    color: ColorsCst.clrfl,
                    elevation: 5,
                    disabledElevation: 0,
                    height: 45,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.5),
                    ),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SvgPicture.asset(
                          AssetsExplorer.icon('close-outline.svg'),
                          color: Colors.white,
                          height: 15,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "Delete all",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
