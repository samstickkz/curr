import 'dart:convert';
import 'package:curr/core/repository/repository.dart';
import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import '../../../locator.dart';
import '../../models/loggedi_in_user.dart';
import '../../models/user.dart';
import 'storage-service.dart';


class UserService {
  late Locale myLocale;
  User userCredentials = User();
  StorageService storageService = locator<StorageService>();
  bool? _token;
  bool hideDetails = false;
  String userType = "";

  //get the user object
  getLocalUser({User? user}) async {
    User? checkUser = user??userCredentials;
    if (checkUser.email != null) {
      userCredentials = checkUser;
    } else {
      String? userVal = await storageService.readItem(key: currentUser);
      if(userVal == null || userVal == "null"){
        await locator<Repository>().getUser();
      }else{
        userCredentials = User.fromJson(jsonDecode(userVal));
      }
    }
  }

  storeUser(User? response) async {
    print("store user");
    if(response==null){
      storageService.deleteItem(key: currentUser);
    }
    await getLocalUser(user: response);
    storageService.storeItem(
        key: currentUser,
        value: jsonEncode(response));
  }

  //check if a user has a token
  bool get hasToken => _token ?? false;

  //check if user is loggedIn and verified
  bool get isLoggedIn => hasToken;

  //check if user credentials was cleared meaning user logged out completely
  // bool get hasCredentials => userCredentials.email != null;

  //Save List of Notifications
  // NotificationsResponse notificationsResponse = NotificationsResponse();

  //clear all user credentials
  resetAllCredentials() {
    storageService.deleteItem(key: currentUser);
    storageService.deleteItem(key: accessToken);
    userCredentials = User();
    _token = null;
  }
}
