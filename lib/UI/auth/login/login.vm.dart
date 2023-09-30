import 'package:curr/core/models/user.dart';
import 'package:curr/utils/dartz.x.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../core/models/login_response.dart';
import '../../../core/models/response_model.dart';
import '../../../routes/routes.dart';
import '../../../utils/snack_message.dart';
import '../../base.vm.dart';

class LoginViewModel extends BaseViewModel{

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  loginCheck()async{
    if(formKey.currentState?.validate()?? false){
      await login();
    }
  }

  // fixes made

  resetPassword(){
    navigationService.navigateTo(resetPasswordRoute);
  }

  register(){
    navigationService.navigateTo(registerRoute);
  }

  Future<User?> getUser()async{
    startLoader();
    try{
      var response = await repository.getUser();
      await initializer.init();
      navigationService.navigateTo(bottomNavigationRoute);
      stopLoader();
      notifyListeners();
      return response;
    }catch(err){
      stopLoader();
      notifyListeners();
      return null;
    }
  }


  login() async {

    try {
      startLoader();
      Either<ResModel, LoginResponse> res = await repository.login(
          email: emailController.text.trim(),
          password: passwordController.text.trim()
      );
      if (res.isRight()) {
        LoginResponse response = res.asRight();
        storageService.storeItem(key: accessToken, value: response.token);
        storageService.storeItem(key: refreshToken, value: response.refreshToken);
        storageService.storeItem(key: expiryDate, value: response.refreshTokenExpiryTime);
        print(await storageService.readItem(key: accessToken));
        await getUser();
        stopLoader();
        notifyListeners();
        return null;
      } else {
        ResModel response = res.asLeft();
        notifyListeners();
        stopLoader();
        return null;
      }
      notifyListeners();
    } catch (e) {
      notifyListeners();
      stopLoader();
      showCustomToast(e.toString());
      return null;
    }
  }

}