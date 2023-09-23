import 'package:flutter/material.dart';

import '../../../../constants/reuseables.dart';
import '../../../../core/models/model.dart';
import '../../../base.vm.dart';

class ProfileHomeViewModel extends BaseViewModel{

  addContext(BuildContext contexts)async {
    context = contexts;
    notifyListeners();
  }

  late BuildContext context;

  List<ProfileButtonModel> account = [
  ProfileButtonModel(title: "Logout", svgImage: AppImages.logoutIcon,),
  ProfileButtonModel(title: "Deactivate Account", svgImage: AppImages.delete, isLogout: true),
  ];

  List<ProfileButtonModel> general = [
    ProfileButtonModel(title: "Verification", svgImage: AppImages.verificationIcon),
  ];

  List<ProfileButtonModel> preferences = [
    ProfileButtonModel(title: "Activate Push Notification", svgImage: AppImages.pushNotification),
  ];

  List<ProfileButtonModel> others = [
    ProfileButtonModel(title: "Contact Support", svgImage: AppImages.supportIcon),
    ProfileButtonModel(title: "Referral Program", svgImage: AppImages.referralIcon),
  ];





}
