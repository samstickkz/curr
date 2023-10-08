import 'package:curr/UI/base.vm.dart';
import 'package:curr/utils/dartz.x.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../../core/models/response_model.dart';
import '../../../../../core/models/user.dart';
import '../../../../../utils/snack_message.dart';

class ChangePasswordViewModel extends BaseViewModel{
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  void validate(String? val){
    formKey.currentState!.validate();
    notifyListeners();
  }

  Future<User?> getUser()async{
    startLoader();
    try{
      var response = await repository.getUser();
      await initializer.init();
      stopLoader();
      notifyListeners();
      return response;
    }catch(err){
      stopLoader();
      notifyListeners();
      return null;
    }
  }

  submit() async {
    if(formKey.currentState!.validate()){
      startLoader();
      try{
        Either<ResModel, String> res = await repository.changePassword(
            password: oldPasswordController.text.trim(),
            newPassword: newPasswordController.text.trim(),
            confirmNewPassword: confirmNewPasswordController.text.trim(),
        );
        if (res.isRight()) {
          String response = res.asRight();
          await getUser();
          showCustomToast("Password Updated successful", success: true);
          stopLoader();
          notifyListeners();
          return null;
        } else {
          ResModel response = res.asLeft();
          notifyListeners();
          stopLoader();
          return null;
        }
      }catch(err){
        notifyListeners();
        stopLoader();
        // showCustomToast(err.toString());
        return null;
      }
    }
  }

}