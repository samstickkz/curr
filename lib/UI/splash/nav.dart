import 'dart:async';

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

    Timer(const Duration(seconds: 0), () {
      isLoggedin?navigationService.navigateToAndRemoveUntil(bottomNavigationRoute):
      navigationService.navigateToAndRemoveUntil(onBoardingScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
