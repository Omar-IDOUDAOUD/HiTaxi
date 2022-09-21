import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hitaxi/controller/main/abstract_controller.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/navigation_bar.dart';
import 'package:hitaxi/core/constants/animation.dart';
import 'package:hitaxi/core/constants/constants.dart';
import 'package:hitaxi/core/utils/assets_explorer.dart';
import 'package:hitaxi/core/utils/main_page_provider.dart';
import 'package:hitaxi/view/screen/main/passenger/pages/home/tabs.dart';
import 'package:hitaxi/view/screen/main/shared_widgets.dart';

const String NAVIGATIONBAR_ID = 'NAVIGATIONBAR-TAG';
const String SEARCHCARD_ID = 'SEARCHCARD-TAG';

class PassengerController extends GetxController
    with AbstractUserTypeController {
  /// descover components:
  TextEditingController fromPlaceControlller = TextEditingController();
  TextEditingController toPlaceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();
  TextEditingController minPriceController = TextEditingController();
  late PageController pageController;
  DateTime? departureTime;
  int? maxPassengers;
  int? freePlacesLeft;
  String? trolley;
  bool canShowSearchCard = true;
  bool canShowNavigationBar = true;
  bool _canChangePage = false;
  late int activedId;
  MainPageComponentsModel get pageComponents => MainPageComponentsModel(
        ids: <int>[0, 1, 2],
        tabs: [
          Tab1(controller: this),
          Tab2(controller: this),
          SettingsTab(controller: this),
        ],
        navLabels: [
          NavigationBarLabel(
              title: "descover",
              iconPath: AssetsExplorer.icon("compass-outline.svg"),
              id: 0,
              tooltipMessage: 'descover'),
          NavigationBarLabel(
              title: "inbox",
              iconPath: AssetsExplorer.icon("inbox-outline.svg"),
              id: 1,
              tooltipMessage: "inbox"),
          NavigationBarLabel(
            title: "settings",
            iconPath: AssetsExplorer.icon("settings-icon.svg"),
            id: 2,
            tooltipMessage: "settings",
          ),
        ],
      );

  @override
  void onInit() {
    super.onInit();
    final void Function() pageListener = () {
      if (!_canChangePage) pageController.jumpToPage(activedId);
    };
    activedId = pageComponents.ids.first;
    pageController = PageController(initialPage: activedId)
      ..addListener(pageListener);
  }

  onTabUpdate(int id) async {
    _canChangePage = true;
    activedId = id;
    await pageController.animateToPage(id,
        duration: AnimationsCst.adra, curve: AnimationsCst.acra);
    if (id == 0)
      canShowSearchCard = true;
    else
      canShowSearchCard = false;
    update([SEARCHCARD_ID]);

    _canChangePage = false;
  }

  Future<void> startTravelDetailsRouteAnimation({bool show = true}) async {
    if (show) {
      await Future.delayed(Duration(milliseconds: 500));
      canShowSearchCard = show;
      canShowNavigationBar = show;
      update([NAVIGATIONBAR_ID, SEARCHCARD_ID]);
      return;
    } else {
      canShowSearchCard = show;
      canShowNavigationBar = show;
      update([NAVIGATIONBAR_ID, SEARCHCARD_ID]);
      return await Future.delayed(Duration(milliseconds: 200));
    }
  }
}
