import 'dart:convert';
import 'dart:io';


import 'package:dio/dio.dart';

import '../../../constants/constants.dart';
import '../../../locator.dart';
import '../../../utils/snack_message.dart';
import '../../models/response_model.dart';
import '../local_services/storage-service.dart';
import 'auth.api.dart';
import 'nertwork_config.dart';

StorageService storageService = locator<StorageService>();
AuthenticationApiService auth = locator<AuthenticationApiService>();
String? newToken;

connect() {
  BaseOptions options = BaseOptions(
      baseUrl: NetworkConfig.BASE_URL,
      connectTimeout: const Duration(milliseconds: 100000),
      receiveTimeout: const Duration(milliseconds: 100000),
      responseType: ResponseType.plain);
  Dio dio = Dio(options);
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        print(options.uri.path);
        print(options.data.toString());
        String? value = await storageService.readItem(key: accessToken);
        print(value);
        if (value != null && value.isNotEmpty) {
          options.headers['Authorization'] = "Bearer $value";
        }
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        print(response.data);
        ResModel resModel = resModelFromJson(response.data);
        if(resModel.successful==true){
          return handler.next(response);
        }else{
          try {
            handleError(response.data);
            return handler.next(response);
          } on DioError catch (e) {
            return handler.next(response);
          }
        }
      },
    ),
  );

  return dio;
}

Future<void> handleError(dynamic error) async {
  if (error is DioError) {
    switch (error.type) {
      case DioExceptionType.cancel:
        showCustomToast("Request to API server was cancelled");
        break;
      case DioExceptionType.connectionTimeout:
        showCustomToast("Connection timeout with API server");
        // break;
        return;
      case DioExceptionType.unknown:
        showCustomToast("Connection to API server failed due to internet connection");
        break;
      case DioExceptionType.receiveTimeout:
        showCustomToast("Receive timeout in connection with API server");
        break;
      case DioExceptionType.badResponse:
        var errorMessage =error.response!.data;


        if(errorMessage=='{"error":"Authentication Failed"}'){
          storageService.deleteAllItems();
          // await sharedPreference.logout();
          // await navigationService.navigateToAndRemoveUntil(AppRoutes.account);
          break;
        }
        // else if(error.response!.data=="Server error"||error.response!.data=="Internal Server error"){
        //   errorMessage ="Server error";
        // }
        else if(jsonDecode(error.response!.data.toString())["detail"]!=null){
          errorMessage =  jsonDecode(error.response!.data.toString())["detail"];
          print("Here!!!");
          // Check if the value is a string
          if (errorMessage is String) {
            showCustomToast(errorMessage);
            break;
          } else {
            print(errorMessage[0]['msg']);
            showCustomToast(errorMessage[0]['msg']);
            break;
          }
        }else{
          errorMessage = error.response.toString();
          break;
        }
      case DioErrorType.sendTimeout:
        showCustomToast("Send timeout in connection with API server");
        break;
      default:
        showCustomToast("Something went wrong");
        break;
    }
  } else {
    var json = jsonDecode(error);
    var nameJson = json['message'];
    showCustomToast(nameJson+" Test");
    return error;
  }
}
