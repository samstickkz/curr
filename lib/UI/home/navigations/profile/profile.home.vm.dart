import 'package:flutter/material.dart';

import '../../../../constants/reuseables.dart';
import '../../../../core/models/model.dart';
import '../../../base.vm.dart';

class ProfileHomeViewModel extends BaseViewModel{

  init(){
    account = [
      ProfileButtonModel(title: "Logout", svgImage: AppImages.logoutIcon, onTap:popLogout(context)),
      ProfileButtonModel(title: "Deactivate Account", svgImage: AppImages.delete, isLogout: true),
    ];
  }

  addContext(BuildContext contexts)async {
    context = contexts;
    await init();
    notifyListeners();
  }

  late BuildContext context;

  List<ProfileButtonModel> general = [
    ProfileButtonModel(title: "Payment Details", svgImage: AppImages.paymentIcon),
    ProfileButtonModel(title: "Verification", svgImage: AppImages.verificationIcon),
  ];

  List<ProfileButtonModel> preferences = [
    ProfileButtonModel(title: "Activate Push Notification", svgImage: AppImages.pushNotification),
    ProfileButtonModel(title: "Change Theme", svgImage: AppImages.theme),
    ProfileButtonModel(title: "Language", svgImage: AppImages.language),
  ];

  List<ProfileButtonModel> others = [
    ProfileButtonModel(title: "Contact Support", svgImage: AppImages.supportIcon),
    ProfileButtonModel(title: "Referral Program", svgImage: AppImages.referralIcon),
  ];

  List<ProfileButtonModel> account = [];




}
