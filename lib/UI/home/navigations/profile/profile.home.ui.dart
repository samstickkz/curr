import 'package:curr/utils/widget_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../constants/reuseables.dart';
import '../../../../widgets/appCard.dart';
import '../../../../widgets/apptexts.dart';
import '../../../base.ui.dart';
import 'profile.home.vm.dart';

class ProfileHomeScreen extends StatelessWidget {
  const ProfileHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileHomeViewModel>(
      onModelReady: (m)async {
        await m.addContext(context);
        print(m.supportState);
      },
      builder: (_, model, child)=> Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
          centerTitle: true,
          leading: null,
        ),
        body: Padding(
          padding: 16.0.padH,
          child: ListView(
            children: [
              AppCard(
                radius: 25,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        ClipRRect(
                          // child: Image.network("", height: 80, width: 80, fit: BoxFit.cover,),
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ],
                    ),
                    10.0.sbW,
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText("Hi, ${model.userService.userCredentials.firstName} ${model.userService.userCredentials.lastName}", isBold: true, size: 20,),
                                AppText("${model.userService.userCredentials.email}",  size: 15, color: Colors.white.withOpacity(0.5),),
                                10.0.sbH,
                                Row(
                                  children: [
                                    AppCard(
                                      backgroundColor: Colors.greenAccent.withOpacity(0.2),
                                      radius: 30,
                                      expandable: true,
                                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                      child: const AppText("KYC Verified", color: Colors.lightGreenAccent,),
                                    ),
                                    const Expanded(child: SizedBox())
                                  ],
                                )
                              ],
                            ),
                          ),
                          10.0.sbW,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: model.navigateToEditProfile,
                                child: SvgPicture.asset(AppImages.pen, height: 24, width: 24,)
                              ),
                            ],
                          )
                        ],
                      )
                    ),
                  ],
                ),
              ),
              20.0.sbH,
              AppText("General".toUpperCase(), size: 14,),
              10.0.sbH,
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: model.general.length,
                itemBuilder: (_,i)=> ProfileCard(svgImage: model.general[i].svgImage??"", title: model.general[i].title??"", onTap: model.general[i].onTap,)
              ),
              20.0.sbH,
              AppText("Security".toUpperCase(), size: 14,),
              10.0.sbH,
              ProfileCard(svgImage: AppImages.passwordIcon, title: "Change Password", onTap: model.navigateToChangePassword,),
              ProfileCard(svgImage: AppImages.resetPassword, title: "Reset PIN", onTap: (){},),
              model.supportState?ProfileCard(
                svgImage: AppImages.fingerprint, title: "Biometrics",
                child: Transform.scale(
                  scale: 0.7,
                  child: CupertinoSwitch(
                    value: model.twoFaVal, onChanged: model.changeBio,
                    activeColor: context.theme.primaryColor,
                  ),
                )
              ):0.0.sbH,
              20.0.sbH,
              AppText("Preferences".toUpperCase(), size: 14,),
              10.0.sbH,
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: model.preferencez.length,
                  itemBuilder: (_,i)=> ProfileCard(
                    svgImage: model.preferencez[i].svgImage??"",
                    title: model.preferencez[i].title??"",
                    child: Transform.scale(
                      scale: 0.7,
                      child: CupertinoSwitch(
                        value: false,
                        onChanged: (v){},
                        activeColor: context.theme.primaryColor,
                      ),
                    ),
                  )
              ),
              20.0.sbH,
              AppText("Others".toUpperCase(), size: 14,),
              10.0.sbH,
              ProfileCard(svgImage: model.others[0].svgImage??"", title: model.others[0].title??"", onTap:(){},),
              // ListView.builder(
              //     shrinkWrap: true,
              //     physics: const NeverScrollableScrollPhysics(),
              //     itemCount: model.others.length,
              //     itemBuilder: (_,i)=> ProfileCard(svgImage: model.others[i].svgImage??"", title: model.others[i].title??"", onTap: model.others[i].onTap,)
              // ),
              ProfileCard(svgImage: model.account[0].svgImage??"", title: model.account[0].title??"", onTap:()=> model.popLogout(context),),
              ProfileCard(svgImage: model.account[1].svgImage??"", title: model.account[1].title??"", isLogout: true , onTap: (){},),
              100.0.sbH
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String svgImage;
  final String title;
  final Widget? child;
  final VoidCallback? onTap;
  final bool? isLogout;
  const ProfileCard({
    super.key, required this.svgImage, required this.title,  this.child, this.onTap, this.isLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppCard(
          padding: 16.0.padA,
          onTap: onTap,
          child: Row(
            children: [
              SvgPicture.asset(svgImage, color: isLogout==true? Colors.red:null,),
              16.0.sbW,
              Expanded(child: AppText(title, size: 17, weight: FontWeight.w700, overflow: TextOverflow.ellipsis, color: isLogout==true? Colors.red:null,)),
              16.0.sbW,
              child ?? const Icon(Iconsax.arrow_right_34, size: 16,)
            ],
          ),
        ),
        10.0.sbH,
      ],
    );
  }
}
