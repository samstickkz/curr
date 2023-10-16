import 'dart:convert';
import 'dart:io';

import 'package:curr/core/models/user.dart';
import 'package:curr/utils/snack_message.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

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

      return Right(LoginResponse.fromJson(jsonDecode(response.data)));
    } on DioError catch (e) {
      return Left(resModelFromJson(e.response?.data));
    } catch (e) {
      return Left(ResModel(messages: [e.toString()]));
    }
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
    try {
      FormData formData = FormData();
      if(image!=null){
        formData.fields.add(MapEntry('id', userService.userCredentials.id??""));
        formData.fields.add(MapEntry('firstName', firstName));
        formData.fields.add(MapEntry('lastName', lastName));
        formData.fields.add(MapEntry('email', email));
        formData.fields.add(MapEntry('phoneNumber', phoneNumber));
        // formData.fields.add(MapEntry('deleteCurrentImage', (deletePrevious??false) as String));
        formData.files.add(MapEntry('file', await MultipartFile.fromFile(image.path, contentType:MediaType("image", "jpeg"))));
      }
      var response = await connect().put("personal/profile", data: image!=null?formData:{
        "id": userService.userCredentials.id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "deleteCurrentImage": false
      }
      );

      if(response.statusCode==200|| response.statusCode==201){
        print(response.data);
        showCustomToast(response.data.toString(), success: true);
        return Right(response.data.toString());
      }else{
        List error = jsonDecode(response.data)['messages'];
        String errorMessage = error.isEmpty? jsonDecode(response.data)['exception']: formatErrorMessageList(convertDynamicListToStringList(jsonDecode(response.data)['messages']));
        showCustomToast(errorMessage);
        return Left(resModelFromJson(response.data));
      }

    } on DioError catch (err) {
      List error = jsonDecode(err.response.toString())['messages'];
      String errorMessage = error.isEmpty? jsonDecode(err.response.toString())['exception']: formatErrorMessageList(convertDynamicListToStringList(error));

      showCustomToast(errorMessage);
      return Left(ResModel.fromJson(jsonDecode(jsonEncode(err.response))));
    }
  }

  Future<Either<ResModel, String>> changePassword({
    required String password,
    required String newPassword,
    required String confirmNewPassword
  }) async {
    try {
      var response = await connect().put("personal/change-password", data: {
        "password": password,
        "newPassword": newPassword,
        "confirmNewPassword": confirmNewPassword,
      });

      if(response.statusCode==200|| response.statusCode==201){
        print(response.data);
        showCustomToast(response.data.toString(), success: true);
        return Right(response.data.toString());
      }else{
        List error = jsonDecode(response.data)['messages'];
        // String errorMessage = error.isEmpty? jsonDecode(response.data)['exception']: formatErrorMessageList(convertDynamicListToStringList(jsonDecode(response.data)['messages']));
        return Left(resModelFromJson(response.data));
      }

    } on DioError catch (err) {
      return Left(ResModel.fromJson(jsonDecode(jsonEncode(err.response))));
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
      Dio dio = Dio();
      var response = await dio.post("${NetworkConfig.BASE_URL}users/self-register",
          data: {
            "email": email,
            "password": password,
            "confirmPassword": confirmPassword,
            "userName": userName,
            "firstName": firstName,
            "lastName": lastName,
            "phoneNumber": phoneNumber,
          },
          options: Options(followRedirects: true, headers: {
            "Accept": "application/json",
            "tenant": "root"
          }));

      if(response.statusCode==200|| response.statusCode==201){
        print(response.data);
        showCustomToast(response.data.toString(), success: true);
        return Right(response.data.toString());
      }else{
        List error = jsonDecode(response.data)['messages'];
        String errorMessage = error.isEmpty? jsonDecode(response.data)['exception']: formatErrorMessageList(convertDynamicListToStringList(jsonDecode(response.data)['messages']));
        showCustomToast(errorMessage);
        return Left(resModelFromJson(response.data));
      }
    } on DioError catch (err) {
      List error = jsonDecode(err.response.toString())['messages'];
      String errorMessage = error.isEmpty? jsonDecode(err.response.toString())['exception']: formatErrorMessageList(convertDynamicListToStringList(error));

      showCustomToast(errorMessage);
      return Left(ResModel.fromJson(jsonDecode(jsonEncode(err.response))));
      rethrow;
    }
  }

  Future<Either<ResModel, String>> forgetPassword({
    required String email
  }) async {
    try {
      Dio dio = Dio();
      var response = await dio.post("${NetworkConfig.BASE_URL}users/forgot-password",
          data: {
            "email": email
          },
          options: Options(followRedirects: true, headers: {
            "Accept": "application/json",
            "tenant": "root"
          }));

      if(response.statusCode==200|| response.statusCode==201){
        print(response.data);
        showCustomToast(response.data.toString(), success: true);
        return Right(response.data.toString());
      }else{
        List error = jsonDecode(response.data)['messages'];
        String errorMessage = error.isEmpty? jsonDecode(response.data)['exception']: formatErrorMessageList(convertDynamicListToStringList(jsonDecode(response.data)['messages']));
        showCustomToast(errorMessage);
        return Left(resModelFromJson(response.data));
      }
    } on DioError catch (err) {
      List error = jsonDecode(err.response.toString())['messages'];
      String errorMessage = error.isEmpty? jsonDecode(err.response.toString())['exception']: formatErrorMessageList(convertDynamicListToStringList(error));

      showCustomToast(errorMessage);
      return Left(ResModel.fromJson(jsonDecode(jsonEncode(err.response))));
    }
  }

  Future<Either<ResModel, String>> resetPassword({
    required String email,
    required String password,
    required String token
  }) async {
    try {
      Dio dio = Dio();
      var response = await dio.post("${NetworkConfig.BASE_URL}users/reset-password",
          data: {
            "email": email,
            "password": password,
            "token": token
          },
          options: Options(followRedirects: true, headers: {
            "Accept": "application/json",
            "tenant": "root"
          }));

      if(response.statusCode==200|| response.statusCode==201){
        print(response.data);
        showCustomToast("Password reset successfully", success: true);
        return Right(response.data.toString());
      }else{
        List error = jsonDecode(response.data)['messages'];
        String errorMessage = error.isEmpty? jsonDecode(response.data)['exception']: formatErrorMessageList(convertDynamicListToStringList(jsonDecode(response.data)['messages']));
        showCustomToast(errorMessage);
        return Left(resModelFromJson(response.data));
      }
    } on DioError catch (err) {
      List error = jsonDecode(err.response.toString())['messages'];
      String errorMessage = error.isEmpty? jsonDecode(err.response.toString())['exception']: formatErrorMessageList(convertDynamicListToStringList(error));

      showCustomToast(errorMessage);
      return Left(ResModel.fromJson(jsonDecode(jsonEncode(err.response))));
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
