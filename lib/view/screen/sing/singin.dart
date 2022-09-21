import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitaxi/controller/authentication/singin_controller.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/button.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/sing_top_bar.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/text_field.dart';
import 'package:hitaxi/core/constants/color.dart';
import 'package:hitaxi/core/constants/route.dart';
import 'package:hitaxi/core/constants/size.dart';
import 'package:hitaxi/core/utils/assets_explorer.dart';

class SingIn extends StatefulWidget {
  const SingIn({Key? key}) : super(key: key);

  @override
  State<SingIn> createState() => SingInState();
}

class SingInState extends State<SingIn> {
  final SingInController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: SizesCst.ssa,
            left: SizesCst.ssa,
            right: SizesCst.ssa,
          ),
          child: Stack(
            children: [
              Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(
                      top: SizesCst.ssa,
                      bottom: SizesCst.ssr,
                    ),
                    children: [
                      AmpereSingTopBar(
                        title: "Log in",
                        titleIconPath:
                            AssetsExplorer.icon('log-in-outline.svg'),
                        additionText: "You don'd have an account? ",
                        additionTextLinkIconPath:
                            AssetsExplorer.icon('arrow-right.svg'),
                        additionTextLink: 'create account',
                        barColor: ColorsCst.clrhl,
                        additionTextLinkTap: () {
                          _controller.goSingUp();
                        },
                        isRegester: false,
                      ),
                      SizedBox(
                        height: SizesCst.ssa,
                      ),
                      Body(),
                    ],
                  )),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: AmpereButton(
                  label: 'SING IN',
                  suffixIconPath:
                      AssetsExplorer.icon('arrowhead-right-outline.svg'),
                  onTap: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  bool _errorOcurred = true;
  SingInController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizesCst.pmsa),
      child: Column(
        children: [
          AmpereTextField(
            controller: _controller.emailController,
            hint: 'Email',
            prefixIconPath: AssetsExplorer.icon('email-outline.svg'),
          ),
          SizedBox(
            height: 10,
          ),
          AmpereTextField(
            controller: _controller.passController,
            hint: 'Password',
            prefixIconPath: AssetsExplorer.icon('lock-outline.svg'),
            passLockIconPath: AssetsExplorer.icon('eye-outline.svg'),
          ),
        ],
      ),
    );
  }
}
