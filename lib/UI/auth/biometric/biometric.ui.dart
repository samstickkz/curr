import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:curr/utils/widget_extensions.dart';
import 'package:curr/widgets/apptexts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/constants.dart';
import '../../../constants/reuseables.dart';
import '../../../utils/snack_message.dart';
import '../../base.ui.dart';
import 'biometric.vm.dart';

class UseBiometricScreen extends StatelessWidget {
  const UseBiometricScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    bool isIOS = context.platform.isIOS;
    bool isAndroid = (context.platform.isAndroid);

    return BaseView<UseBiometricViewModel>(
      builder: (_, model, child)=> Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100, width: 100,
                  alignment: Alignment.bottomCenter,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(AppString.profilePic)
                      )
                  ),
                ),
                20.0.sbH,
                AppText("Welcome ${userService.userCredentials.firstName}  ${userService.userCredentials.lastName}"),
                50.0.sbH,
                AltSigninButton(
                    icon: isIOS
                        ? AppImages.faceID
                        : AppImages.fingerprint,
                    label: isIOS ? "Face ID" : "Fingerprint",
                    onTap: () async {
                      if (isIOS) {
                        await model.authenticate();
                      } else {
                        String version =
                        await model.getAndroidVersion();
                        num? number = num.tryParse(version);
                        if (number != null) {
                          if (number is int) {
                            if (number <= 9) {
                              showCustomToast(
                                  "Android Version is $number and  less than 9 which doesn't support this function",
                                  success: false);
                            } else {
                              await model.authenticate();
                            }
                          } else if (number is double) {
                            if (number <= 9) {
                              showCustomToast(
                                  "Android Version is $number and  less than 9 which doesn't support this function",
                                  success: false);
                            } else  {
                              await model.authenticate();
                            }
                          }
                        } else {
                          List<String> versionComponents =
                          version.split(".");
                          double versionNumber = double.parse(
                              "${versionComponents[0]}.${versionComponents[1]}${versionComponents[2]}");
                          if (versionNumber <= 9) {
                            showCustomToast(
                                "Android Version is $versionNumber and  less than 9 which doesn't support this function",
                                success: false);
                          } else {
                            await model.authenticate();
                          }
                        }
                      }


                    }),
              ],
            )

          ],
        ),
      ),
    );
  }
}


class AltSigninButton extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;
  const AltSigninButton({Key? key, required this.icon, required this.label, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 100, width: 100,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16)
            ),
            child: SvgPicture.asset(icon),
          ),
          10.0.sbH,
          AppText(label, isBold: true,)
        ],
      ),
    );
  }
}
