import 'package:curr/constants/constants.dart';
import 'package:curr/routes/routes.dart';
import 'package:curr/utils/dartz.x.dart';
import 'package:curr/utils/string-extensions.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/models/response_model.dart';
import '../../../utils/snack_message.dart';
import '../../base.vm.dart';

class RegisterViewModel extends BaseViewModel {
  final firstNameController = TextEditingController();
  final userNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool success = false;
  bool isActive = false;

  void changeStatus(bool? val){
    isActive = val!;
    notifyListeners();
  }

  String? countryCode;
  String? phoneNumber;

  @override
  void dispose() {
    firstNameController.clear();
    passwordController.clear();
    emailController.clear();
    confirmPasswordController.clear();
    lastNameController.clear();
    userNameController.clear();

    super.dispose();
  }
  
  register()async{
    FocusManager.instance.primaryFocus?.unfocus();
    if (formKey.currentState!.validate()){
      startLoader();
      try{
        Either<ResModel, String> res =  await repository.register(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
            firstName: firstNameController.text.trim(),
            lastName: lastNameController.text.trim(),
            userName: userNameController.text.trim(),
            phoneNumber: trimPhone(phoneNumber),
            confirmPassword: confirmPasswordController.text.trim()
        );
        if (res.isRight()) {
          String response = res.asRight();
          navigationService.goBack();
          stopLoader();
          notifyListeners();
        } else {
          ResModel response = res.asLeft();
          notifyListeners();
          stopLoader();
        }
      }catch(err){
        print(err);
        stopLoader();
        notifyListeners();
      }
    }
  }

}