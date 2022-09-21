import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitaxi/binding/passenger_binding.dart';
import 'package:hitaxi/binding/singin_binding.dart';
import 'package:hitaxi/core/constants/route.dart';
import 'package:hitaxi/core/constants/theme.dart';
import 'package:hitaxi/view/screen/main/passenger/pages/home/page.dart'
    as PassengerHome;
import 'package:hitaxi/view/screen/main/passenger/pages/travel_details/page.dart'
    as PassengerTravelDetail;
import 'package:hitaxi/view/screen/sing/singin.dart';
import 'package:hitaxi/view/screen/sing/singup.dart';
import 'package:hitaxi/view/screen/test/test.dart';

import 'binding/singup_binding.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized()
  runApp(const HiTaxi());
}

class HiTaxi extends StatelessWidget {
  const HiTaxi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      theme: ThemesCst.light,
      darkTheme: ThemesCst.dark,
      initialRoute: RoutesCst.mainPassenger,
      getPages: [
        GetPage(
          name: RoutesCst.singin,
          page: () => SingIn(),
          binding: SingInBinging(),
          title: 'Login',
          // transition: Transition.cupertino,
        ),
        GetPage(
          name: RoutesCst.singup,
          page: () => SingUp(),
          binding: SingUpBinging(),
          // transition: Transition.cupertino
          // transition,
        ),
        GetPage(
          name: RoutesCst.mainPassenger,
          page: () => PassengerHome.Home(),
          binding: PassengerBinding(),
          // transition: Transition.cupertino,
        ),
        GetPage(
            name: RoutesCst.mainPassengerTravelDetails,
            page: () => PassengerTravelDetail.TravelDetails(),
            arguments: {'arg': 'this an arg'}
            // transition: Transition.cupertino,
            ),
        GetPage(
          name: RoutesCst.testFrame,
          page: () => TestPage(),
          // transition: Transition.cupertino,
        ),
      ],
    );
  }
}
