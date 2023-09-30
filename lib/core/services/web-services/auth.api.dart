import 'dart:convert';

import 'package:curr/core/models/user.dart';
import 'package:curr/utils/snack_message.dart';
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
      var response = await connect().post("tokens", data: {
        "email": email,
        "password": password,
      });
      print("Here");
      return Right(LoginResponse.fromJson(jsonDecode(response.data)));
    } on DioError catch (e) {
      print("Now Here");
      return Left(resModelFromJson(e.response?.data));
    } catch (e) {
      print("Definately Here");
      return Left(ResModel(messages: [e.toString()]));
    }
  }

  Future<User?> getUser()async{
    try{
      var response = await connect().get("personal/profile");
      User user = User.fromJson(jsonDecode(response.data));
      return user;
    } on DioError catch(err){
      print(err);
      return null;
    } catch(err){
      print(err);
      return null;
    }
  }

  Future<Either<ResModel, String>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String userName,
    required String phoneNumber,
    required String confirmPassword,
  }) async {
    try {
      Response response = await connect().post("users/self-register", data: {
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
        "userName": userName,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
      });

      if(response.statusCode==200){
        return Right("Successful");
      }else{
        showCustomToast(response.data["messages"][0]);
        return Left(resModelFromJson(response.data));
      }
    } catch (e) {
      return Left(ResModel(messages: [e.toString()]));
    }
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
