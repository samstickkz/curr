import 'package:curr/utils/dartz.x.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

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


  Future<void> login() async {

    try {
      startLoader();
      Either<ResModel, ResModel> res = await repository.login(
          email: emailController.text.trim(),
          password: passwordController.text.trim()
      );
      if (res.isRight()) {
        ResModel response = res.asRight();
        stopLoader();
        showCustomToast(response.message??"", success: true);
        navigationService.navigateTo(bottomNavigationRoute);
        stopLoader();
        notifyListeners();
      } else {
        ResModel response = res.asLeft();
        showCustomToast(response.message??"");
        notifyListeners();
        stopLoader();
      }

      notifyListeners();
    } catch (e) {
      notifyListeners();
      stopLoader();
      showCustomToast(e.toString());
    }
  }

}