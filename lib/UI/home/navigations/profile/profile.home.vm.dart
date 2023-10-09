import 'package:curr/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

import '../../../../constants/reuseables.dart';
import '../../../../core/models/model.dart';
import '../../../base.vm.dart';

class ProfileHomeViewModel extends BaseViewModel{

  addContext(BuildContext contexts)async {
    context = contexts;
    await localAuthentication.isDeviceSupported().then(
          (bool isSupported){
            supportState = isSupported;
            notifyListeners();
          },
    );
    if(!supportState){
      preference.save2fa(supportState);
    }
    twoFaVal = await preference.get2fa();
    notifyListeners();
  }

  late final LocalAuthentication localAuthentication = LocalAuthentication();
  bool supportState=false;

  late BuildContext context;

  navigateToEditProfile(){
    navigationService.navigateTo(editProfile);
  }

  bool twoFaVal = false;

  changeBio(bool? val) async {
    preference.save2fa(val??false);
    twoFaVal = await preference.get2fa();
    notifyListeners();
  }

  navigateToChangePassword(){
    navigationService.navigateTo(changePasswordRoute);
  }

  List<ProfileButtonModel> account = [
  ProfileButtonModel(title: "Logout", svgImage: AppImages.logoutIcon,),
  ProfileButtonModel(title: "Deactivate Account", svgImage: AppImages.delete, isLogout: true),
  ];

  List<ProfileButtonModel> general = [
    ProfileButtonModel(title: "Verification", svgImage: AppImages.verificationIcon),
  ];

  List<ProfileButtonModel> preferencez = [
    ProfileButtonModel(title: "Activate Push Notification", svgImage: AppImages.pushNotification),
  ];

  List<ProfileButtonModel> others = [
    ProfileButtonModel(title: "Contact Support", svgImage: AppImages.supportIcon),
    ProfileButtonModel(title: "Referral Program", svgImage: AppImages.referralIcon),
  ];





}
