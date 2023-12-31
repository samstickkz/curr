import 'dart:io';

import 'package:curr/constants/constants.dart';
import 'package:curr/utils/dartz.x.dart';
import 'package:dartz/dartz.dart';

import '../../locator.dart';
import '../models/login_response.dart';
import '../models/response_model.dart';
import '../models/user.dart';
import '../services/local_services/app-cache.dart';
import '../services/local_services/initializer.dart';
import '../services/local_services/storage-service.dart';
import '../services/local_services/user.service.dart';
import '../services/web-services/auth.api.dart';

class Repository {
  UserService userService = locator<UserService>();
  AppCache appCache = locator<AppCache>();
  Initializer initializer = locator<Initializer>();
  AuthenticationApiService authApi = locator<AuthenticationApiService>();
  StorageService storageService = locator<StorageService>();


  Future<Either<ResModel, String>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String userName,
    required String phoneNumber,
    required String confirmPassword,
  }) async {
    return await authApi.register(email: email, password: password, firstName: firstName, lastName: lastName, userName: userName, phoneNumber: phoneNumber, confirmPassword: confirmPassword);
  }

  Future<Either<ResModel, String>> forgetPassword({required String email}) async {
    return await authApi.forgetPassword(email: email);
  }

  Future<Either<ResModel, String>> changePassword({
    required String password,
    required String newPassword,
    required String confirmNewPassword
  }) async {
    return await authApi.changePassword(password: password, newPassword: newPassword, confirmNewPassword: confirmNewPassword);
  }

  Future<Either<ResModel, String>> updateProfile({
    required String email,
    required String username,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    File? image,
    bool? deletePrevious,
  }) async {
    return await authApi.updateProfile(email: email, username: username, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, image: image, deletePrevious: deletePrevious);
  }

  Future<Either<ResModel, String>> resetPassword({
    required String email,
    required String password,
    required String token
  }) async {
    return await authApi.resetPassword(email: email, password: password, token: token);
  }

  Future<Either<ResModel, LoginResponse>> login({required String email, required String password
  }) async {
    Either<ResModel, LoginResponse> response = await authApi.login(email: email, password: password);
    print(response);
    if(response.isRight()){
      LoginResponse res = response.asRight();
      if(res.token!=null){
        await saveTokens(res);
      }
      print(await storageService.readItem(key: accessToken));
    }
    return response;
  }

  saveTokens(LoginResponse res)async{
    print("Here");
    storageService.storeItem(key: accessToken, value: res.token);
    storageService.storeItem(key: refreshToken, value: res.refreshToken);
    storageService.storeItem(key: expiryDate, value: res.refreshTokenExpiryTime);
  }

  Future<User?> getUser()async{
    var response = await authApi.getUser();
    if(response!=null){
      await userService.storeUser(response);
    }
    return response;
  }

}