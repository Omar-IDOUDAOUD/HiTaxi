import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitaxi/controller/authentication/singup_controller.dart';
import 'package:hitaxi/core/class/AmpereDesingPackage/ampere.dart';
import 'package:hitaxi/core/constants/animation.dart';
import 'package:hitaxi/core/constants/color.dart';
import 'package:hitaxi/core/constants/font.dart';
import 'package:hitaxi/core/constants/size.dart';
import 'package:hitaxi/core/utils/assets_explorer.dart';

class SingUp extends StatefulWidget {
  const SingUp({Key? key}) : super(key: key);

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  final SingUpController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: 0,
              child: PageView(
                controller: _controller.bodyPageController,
                children: [
                  ListView(
                    controller: _controller.bodyScrollController,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(
                      top: SizesCst.ssa,
                      bottom: 110,
                      left: SizesCst.ssa,
                      right: SizesCst.ssa,
                    ),
                    children: [
                      AmpereSingTopBar(
                        title: "Regester",
                        titleIconPath:
                            AssetsExplorer.icon('person-add-outline.svg'),
                        additionText: "Already have an account?",
                        additionTextLinkIconPath:
                            AssetsExplorer.icon('arrow-right.svg'),
                        additionTextLink: "Sing in",
                        barColor: ColorsCst.clrrl,
                        additionTextLinkTap: () {
                          _controller.goSingIn();
                        },
                      ),
                      SizedBox(
                        height: SizesCst.ssa,
                      ),
                      _Body1(),
                    ],
                  ),
                  ListView(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(
                      top: SizesCst.ssa,
                      bottom: SizesCst.ssr,
                      left: SizesCst.ssa,
                      right: SizesCst.ssa,
                    ),
                    children: [
                      AmpereSingTopBar(
                        title: "Regester",
                        titleIconPath:
                            AssetsExplorer.icon('person-add-outline.svg'),
                        additionTextLinkIconPath:
                            AssetsExplorer.icon('sync-outline.svg'),
                        additionText: "EMAIL VERIFICATION",
                        additionTextLink: "resend code",
                        barColor: ColorsCst.clrrl,
                        additionTextLinkTap: () {
                          _controller.goSingIn();
                        },
                      ),
                      SizedBox(
                        height: SizesCst.ssa,
                      ),
                      _Body2(
                        controller: _controller,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: SizesCst.ssa,
              right: SizesCst.ssa,
              left: SizesCst.ssa,
              child: AmpereButton(
                label: 'SING UP',
                suffixIconPath:
                    AssetsExplorer.icon('arrowhead-right-outline.svg'),
                onTap: () {
                  _controller.next();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Body1 extends StatelessWidget {
  SingUpController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizesCst.pmsa),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AmpereAvatarSettingRow(
            label: 'Set your avatar',
            subLinkButtonOneIconPath: AssetsExplorer.icon('image-outline.svg'),
            subLinkButtonOneLabel: 'from gallery',
            subLinkButtonTwoIconPath: AssetsExplorer.icon('camera-outline.svg'),
            subLinkButtonTwoLabel: 'take picture',
            wheneAvatarImageIsNullIconPath:
                AssetsExplorer.icon('image-outline.svg'),
            avatarImagePath: null,
          ),
          SizedBox(
            height: 10,
          ),
          AmpereTextField(
            controller: _controller.nameController,
            hint: 'Name',
            prefixIconPath: AssetsExplorer.icon("person-outline.svg"),
            validator: _controller.nameValidator,
            alertIcon: AssetsExplorer.icon('alert-triangle-outline.svg'),
          ),
          SizedBox(
            height: 10,
          ),
          AmpereTextField(
            controller: _controller.emailController,
            hint: 'Email',
            prefixIconPath: AssetsExplorer.icon('email-outline.svg'),
            validator: _controller.emailValidator,
            alertIcon: AssetsExplorer.icon('alert-triangle-outline.svg'),
          ),
          SizedBox(
            height: 10,
          ),
          AmpereTextField(
            controller: _controller.passController,
            hint: 'Password',
            prefixIconPath: AssetsExplorer.icon("lock-outline.svg"),
            passLockIconPath: AssetsExplorer.icon("eye-outline.svg"),
            validator: _controller.passValidator,
            alertIcon: AssetsExplorer.icon('alert-triangle-outline.svg'),
          ),
          SizedBox(
            height: 10,
          ),
          AmpereTextField(
            controller: _controller.phoneNumberController,
            hint: 'Phone number',
            prefixIconPath: AssetsExplorer.icon("phone-outline.svg"),
            validator: _controller.phoneNumberValidator,
            alertIcon: AssetsExplorer.icon('alert-triangle-outline.svg'),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizesCst.ssd),
            child: Text(
              "Role",
              style: TextStyle(
                fontSize: SizesCst.ftsb,
                fontWeight: FontsCst.wfg,
                color: Get.theme.colorScheme.primary,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          LayersSwitcher(
            layer1IconPath: AssetsExplorer.icon("passenger-icon.svg"),
            layer1Label: "Passenger",
            layer1Id: "PASSENGER",
            layer2IconPath: AssetsExplorer.icon("driver-icon.svg"),
            layer2Label: "Driver",
            layer2Id: "DRIVER",
            initialActiveLayerId: _controller.role,
            onSwitch: (String activedLayerId) {
              _controller.setRole(activedLayerId);
            },
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizesCst.ssd),
            child: AmpereMiniWarningTile(
              subject: "This option represents your account type!",
              warningIconPath:
                  AssetsExplorer.icon('alert-triangle-outline.svg'),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizesCst.ssd),
            child: Text(
              "Traveles Type",
              style: TextStyle(
                fontSize: SizesCst.ftsb,
                fontWeight: FontsCst.wfg,
                color: Get.theme.colorScheme.primary,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          LayersSwitcher(
            layer1IconPath: AssetsExplorer.icon('random-icon.svg'),
            layer1Label: "Random",
            layer1Id: "RANDOM",
            layer2IconPath: AssetsExplorer.icon('typical-icon.svg'),
            layer2Label: "Typical",
            layer2Id: "TYPICAL",
            initialActiveLayerId: _controller.travelesType.value,
            onSwitch: (String activedLayerId) {
              _controller.setTravelesType(activedLayerId);
            },
          ),
          SizedBox(
            height: 10,
          ),
          Obx(
            () {
              print("rebuid lm");
              return Column(
                children: [
                  AmpereTextField(
                    controller:
                        _controller.typicalTravelsTypeFromPlaceController,
                    hint: 'From place',
                    enabled: _controller.travelesType == "TYPICAL",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  AmpereTextField(
                    controller: _controller.typicalTravelsTypeToPlaceController,
                    hint: 'To place',
                    enabled: _controller.travelesType == "TYPICAL",
                  ),
                ],
              );
            },
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizesCst.ssd),
            child: Text(
              "Communication materials",
              style: TextStyle(
                fontSize: SizesCst.ftsb,
                fontWeight: FontsCst.wfg,
                color: Get.theme.colorScheme.primary,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizesCst.ssd),
            child: Text(
              "Add your social networking sites accounts for communication with other people by this app",
              style: TextStyle(
                height: 1.2,
                fontSize: SizesCst.ftsv,
                fontWeight: FontsCst.wfa,
                color: Get.theme.colorScheme.secondary,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          AmpereTextField(
            controller: _controller.whatsappAccountLinkController,
            hint: 'WhatsApp link',
            prefixIconPath: AssetsExplorer.icon('globe-2-outline.svg'),
            validator: () {
              return _controller.linkValidator(
                  "whatsapp", _controller.whatsappAccountLinkController);
            },
            alertIcon: AssetsExplorer.icon('alert-triangle-outline.svg'),
          ),
          SizedBox(
            height: 10,
          ),
          AmpereTextField(
            controller: _controller.facebookAccountLinkController,
            hint: 'Facebook link',
            prefixIconPath: AssetsExplorer.icon('globe-2-outline.svg'),
            validator: () {
              return _controller.linkValidator(
                  "facebook", _controller.facebookAccountLinkController);
            },
            alertIcon: AssetsExplorer.icon('alert-triangle-outline.svg'),
          ),
          SizedBox(
            height: 10,
          ),
          AmpereTextField(
            controller: _controller.instagramAccountLinkController,
            hint: 'Instagram link',
            prefixIconPath: AssetsExplorer.icon('globe-2-outline.svg'),
            validator: () {
              return _controller.linkValidator(
                  "instagram", _controller.instagramAccountLinkController);
            },
            alertIcon: AssetsExplorer.icon('alert-triangle-outline.svg'),
          ),
          SizedBox(
            height: 10,
          ),
          AmpereTextField(
            controller: _controller.otherLinkController,
            hint: 'Other link',
            prefixIconPath: AssetsExplorer.icon('globe-2-outline.svg'),
            validator: () {
              return _controller.linkValidator(
                  null, _controller.otherLinkController);
            },
            alertIcon: AssetsExplorer.icon('alert-triangle-outline.svg'),
          ),
        ],
      ),
    );
  }
}

class _Body2 extends StatelessWidget {
  const _Body2({Key? key, required this.controller}) : super(key: key);
  final SingUpController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizesCst.pmsa),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizesCst.ssd),
            child: Text(
              "Enter verification code to continue",
              style: TextStyle(
                fontSize: SizesCst.ftsb,
                fontWeight: FontsCst.wfa,
                color: Get.theme.colorScheme.primary,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizesCst.ssd),
            child: Text(
              "Your verification code was sent to your entered email.",
              style: TextStyle(
                height: 1.2,
                fontSize: SizesCst.ftsv,
                fontWeight: FontsCst.wfa,
                color: Get.theme.colorScheme.secondary,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: AmpereVerificationCodeField(
              onFinish: (int code) {},
              fieldController: controller.emailVerificationController,
            ),
          )
        ],
      ),
    );
  }
}
