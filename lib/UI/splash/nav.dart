import 'dart:async';

import 'package:curr/core/cache/sharedpreferences.dart';
import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../../core/services/local_services/initializer.dart';
import '../../locator.dart';
import '../../routes/routes.dart';

class Navigations extends StatefulWidget {
  const Navigations({Key? key}) : super(key: key);

  @override
  State<Navigations> createState() => _NavigationsState();
}

class _NavigationsState extends State<Navigations> {

  @override
  void initState() {
     init();
    super.initState();
  }

  init() async {
    bool isLoggedin = locator<Initializer>().isLoggedIn;

    Timer(const Duration(seconds: 0), () async {
      bool is2faSet = await locator<SharedPreference>().get2fa();
      print("Is 2fa set $is2faSet");
      isLoggedin? (is2faSet? navigationService.navigateToAndRemoveUntil(useBioRoute): navigationService.navigateToAndRemoveUntil(bottomNavigationRoute)):
      navigationService.navigateToAndRemoveUntil(onBoardingScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
