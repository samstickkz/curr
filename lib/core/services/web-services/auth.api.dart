import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../constants/constants.dart';
import '../../../constants/reuseables.dart';
import '../../../locator.dart';
import '../../../routes/routes.dart';
import '../../models/loggedi_in_user.dart';
import '../../models/login_response.dart';
import '../../models/response_model.dart';
import '../local_services/storage-service.dart';
import '../local_services/user.service.dart';
import 'base-api.dart';
import 'nertwork_config.dart';

class AuthenticationApiService {
  StorageService storageService = locator<StorageService>();
  UserService userService = locator<UserService>();

  Future<Either<ResModel, LoginResponse>> login({
    required String email,
    required String password
  }) async {
    try {
      var response = await connect().post("Auth/login", data: {
        "email": email,
        "password": password,
      });

      ResModel resModel = resModelFromJson(response.data);
      if(resModel.successful==true){
        return Right(LoginResponse.fromJson(jsonDecode(response.data)));
      }else{
        return Left(ResModel.fromJson(jsonDecode(response.data)));
      }
    } catch (e) {
      return Left(ResModel(message: e.toString()));
    }
  }

  Future<Either<ResModel, ResModel>> register({
    required String email,
    required String password,
    required String activationUrl,
    required bool acceptPolicy,
  }) async {
    try {
      print(NetworkConfig.BASE_URL);
      var response = await connect().post("Auth/signup", data: {
        "email": email,
        "password": password,
        "acceptpolicy": acceptPolicy,
        "activationUrl": activationUrl,
      });

      ResModel resModel = resModelFromJson(response.data);
      if(resModel.successful==true){
        return Right(ResModel.fromJson(jsonDecode(response.data)));
      }else{
        return Left(ResModel.fromJson(jsonDecode(response.data)));
      }
    } catch (e) {
      return Left(ResModel(message: e.toString()));
    }
  }

  storeToken(String? token, {bool saveUser = true}) async {
    //store token
    storageService.storeItem(key: accessToken, value: token);
    String tokens = await storageService.readItem(key: accessToken);
    print("Access Token : $tokens");
  }

  Map<String, dynamic> filterNullValues(Map<String, dynamic> data) {
    Map<String, dynamic> filteredData = {};

    data.forEach((key, value) {
      if (value != null) {
        filteredData[key] = value;
      }
    });

    return filteredData;
  }



}
