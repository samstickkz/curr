import 'package:curr/core/repository/repository.dart';
import 'package:curr/core/repository/repository.dart';
import 'package:flutter/material.dart';

import '../constants/reuseables.dart';
import '../core/services/local_services/app-cache.dart';
import '../core/services/local_services/initializer.dart';
import '../core/services/local_services/navigation_services.dart';
import '../core/services/local_services/storage-service.dart';
import '../core/services/local_services/user.service.dart';
import '../core/services/web-services/auth.api.dart';
import '../locator.dart';
import '../routes/routes.dart';
import '../utils/snack_message.dart';
import '../widgets/action_dialog.dart';

class BaseViewModel extends ChangeNotifier {
  ViewState _viewState = ViewState.idle;
  NavigationService navigationService = locator<NavigationService>();
  UserService userService = locator<UserService>();
  Repository repository = locator<Repository>();
  AppCache appCache = locator<AppCache>();
  Initializer initializer = locator<Initializer>();
  AuthenticationApiService authApi = locator<AuthenticationApiService>();
  StorageService storageService = locator<StorageService>();

  logout()async{
    storageService.deleteAllItems();
    userService.storeUser(null);
    await initializer.init();
    notifyListeners();
    // login with getx
    navigationService.navigateToAndRemoveUntil(loginRoute);
  }

  popLogout(BuildContext context){
    showBottomSheet(
        context: context,
        builder: (BuildContext context) => ActionBottomSheet(
          onTap:logout,
          title: "Logout",
        ));
  }

  final formKey = GlobalKey<FormState>();

  ViewState get viewState => _viewState;

  set viewState(ViewState newState) {
    _viewState = newState;
    notifyListeners();
  }

  bool isLoading = false;

  void startLoader() {
    if (!isLoading) {
      isLoading = true;
      viewState = ViewState.busy;
      notifyListeners();
    }
  }

  void stopLoader() {
    if (isLoading) {
      isLoading = false;
      viewState = ViewState.idle;
      notifyListeners();
    }
  }

  popDialog(BuildContext context, VoidCallback onTap, String title)async{
    showBottomSheet(
        context: context,
        builder: (BuildContext context) => ActionBottomSheet(
          onTap: onTap,
          title: title,
        ));
  }

  String addDigits(String input) {
    StringBuffer result = StringBuffer();
    for (int i = 0; i < input.length; i++) {
      result.write(input[i] + '08642');
    }
    return result.toString();
  }

  String removeDigits(String modifiedInput) {
    StringBuffer result = StringBuffer();
    for (int i = 0; i < modifiedInput.length; i += 6) {
      result.write(modifiedInput[i]);
    }
    return result.toString();
  }

}