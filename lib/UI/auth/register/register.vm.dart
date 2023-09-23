import 'package:curr/constants/constants.dart';
import 'package:curr/routes/routes.dart';
import 'package:curr/utils/dartz.x.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../core/models/response_model.dart';
import '../../../utils/snack_message.dart';
import '../../base.vm.dart';

class RegisterViewModel extends BaseViewModel {
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool success = false;
  bool isActive = false;

  void changeStatus(bool? val){
    isActive = val!;
    notifyListeners();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }
  
  register()async{
    FocusManager.instance.primaryFocus?.unfocus();
    if (formKey.currentState!.validate()){
      startLoader();
      try{
        Either<ResModel, ResModel> res =  await repository.register(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
            activationUrl: "${baseUrl}Auth/confirm-email",
            acceptPolicy: isActive
        );
        if (res.isRight()) {
          ResModel response = res.asRight();
          navigationService.goBack();
          showCustomToast(response.message??"", success: true);
          stopLoader();
          notifyListeners();
        } else {
          ResModel response = res.asLeft();
          showCustomToast(response.message??"");
          notifyListeners();
          stopLoader();
        }
      }catch(err){
        showCustomToast("$err");
        stopLoader();
        notifyListeners();
      }
    }
  }

}