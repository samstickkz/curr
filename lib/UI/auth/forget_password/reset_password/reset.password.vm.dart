import 'package:curr/UI/base.vm.dart';
import 'package:curr/routes/routes.dart';
import 'package:curr/utils/dartz.x.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/models/response_model.dart';

class ResetPasswordViewModel extends BaseViewModel{

  var emailController = TextEditingController();
  var token = TextEditingController();
  var password = TextEditingController();
  var confirmPassword = TextEditingController();

  init(String? emails){
    emailController = TextEditingController(text: emails);
    notifyListeners();
  }

  reset() async {
    if(formKey.currentState!.validate()){
      startLoader();
      try{
        Either<ResModel, String> res =  await repository.resetPassword(
            email: emailController.text.trim(),
            password: password.text.trim(),
            token: token.text.trim()
        );
        if (res.isRight()) {
          String response = res.asRight();
          navigationService.navigateToAndRemoveUntil(loginRoute);
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