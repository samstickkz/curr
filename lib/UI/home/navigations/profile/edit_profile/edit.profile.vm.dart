import 'dart:io';

import 'package:curr/UI/base.vm.dart';
import 'package:curr/utils/dartz.x.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_camera/whatsapp_camera.dart';

import '../../../../../core/models/response_model.dart';
import '../../../../../core/models/user.dart';
import '../../../../../utils/snack_message.dart';

class EditProfileViewModel extends BaseViewModel{

  final files = ValueNotifier(<File>[]);

  init(){
    usernameController = TextEditingController(text: userService.userCredentials.userName==null?null: "${userService.userCredentials.userName}@");
    firstNameController = TextEditingController(text: userService.userCredentials.firstName);
    lastNameController = TextEditingController(text: userService.userCredentials.lastName);
    emailController = TextEditingController(text: userService.userCredentials.email);
    phoneNumberController = TextEditingController(text: userService.userCredentials.phoneNumber);
    files.addListener(notifyListeners);
  }

  EditProfileViewModel(){
    init();
  }

  removeItem(){
    files.value = <File>[];
    notifyListeners();
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  getImage(BuildContext context)async{
    List<File>? res = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WhatsappCamera(multiple: false,),
      ),
    );
    if (res != null) files.value = res;
    notifyListeners();
    print(files.value.length);
  }

  Future<User?> getUser()async{
    startLoader();
    try{
      var response = await repository.getUser();
      await initializer.init();
      init();
      stopLoader();
      notifyListeners();
      return response;
    }catch(err){
      stopLoader();
      notifyListeners();
      return null;
    }
  }

  updateProfile() async {
    startLoader();
    try{
      Either<ResModel, String> res = await repository.updateProfile(
          email: emailController.text.trim(),
          username: usernameController.text.trim(),
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          image: files.value.first,
          phoneNumber: phoneNumberController.text.trim(),
      );
      if (res.isRight()) {
        String response = res.asRight();
        await getUser();
        showCustomToast("Profile Update successful", success: true);
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
      showCustomToast(err.toString());
      return null;
    }
  }
}