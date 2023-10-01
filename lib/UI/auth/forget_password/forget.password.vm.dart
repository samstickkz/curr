import 'package:curr/UI/base.vm.dart';
import 'package:curr/utils/dartz.x.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../core/models/response_model.dart';
import '../../../routes/routes.dart';

class ForgetPasswordViewModel extends BaseViewModel{

  final emailController = TextEditingController();

  forgetPassWord() async {
    if(formKey.currentState!.validate()){
      startLoader();
      try{
        Either<ResModel, String> res =  await repository.forgetPassword(
            email: emailController.text.trim(),
        );
        if (res.isRight()) {
          String response = res.asRight();
          appCache.email = emailController.text.trim();
          navigationService.navigateTo(resetPasswordRoute);
          stopLoader();
          notifyListeners();
        } else {
          ResModel response = res.asLeft();
          notifyListeners();
          stopLoader();
        }
      }catch(err){
        stopLoader();
        notifyListeners();
      }
    }
  }

}