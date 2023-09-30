import 'dart:convert';
import 'dart:io';


import 'package:curr/routes/routes.dart';
import 'package:curr/utils/snack_message.dart';
import 'package:dio/dio.dart';

import '../../../constants/constants.dart';
import '../../../locator.dart';
import '../local_services/navigation_services.dart';
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
          options.headers['Authorization'] = "Bearer " + value;
        }
        options.uri.path=="/api/tokens" || options.uri.path=="/api/users/self-register"? options.headers["tenant"] = "root":null;
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        return handler.next(response);
      },
      onError: (DioError e, handler) async {
        print("status code: ${e.message}");
        print("status message: ${e.error}");
        print(e.response?.statusCode);
        print("${e.response?.data.toString()}");
        List error = jsonDecode(e.response!.data)['messages'];
        String errorMessage = error.isEmpty? jsonDecode(e.response!.data)['exception']: formatErrorMessageList(convertDynamicListToStringList(jsonDecode(e.response!.data)['messages']));
        print("ERRORMESSAGE::: $errorMessage");
        showCustomToast(errorMessage);
        try {
          if ((e.response?.statusCode == 401 &&
              jsonDecode(e.response!.data)['messages'] != null &&
              jsonDecode(e.response!.data)['messages']
                  .toString()
                  .contains("token"))) {
            if (await storageService.hasKey(key: 'refreshToken')) {
              if (await refreshAuthToken()) {
                return handler.resolve(await _retry(e.requestOptions));
              }
            }
          }
        } on DioError catch (e) {
          return handler.next(e);
        }
        //token is expired
        //log user out
        if (e.response?.statusCode == 401 &&
            jsonDecode(e.response!.data)['messages'] != null &&
            jsonDecode(e.response!.data)['messages']
                .toString()
                .contains("token")) {
          await storageService.storage.deleteAll();
          locator<NavigationService>().navigateToAndRemoveUntil(loginRoute);
        }
        return handler.next(e);
      },
    ),
  );

  return dio;
}

Future<bool> refreshAuthToken() async {
  final refreshToken_ = await storageService.readItem(key: refreshToken);
  final accessToken_ = await storageService.readItem(key: accessToken);
  try {
    Response response = await connect()
        .post('tokens/refresh', data: {'refresh': refreshToken_, 'token':accessToken_ });

    if (response.statusCode == 201 || response.statusCode == 200) {
      print('refresh token went through');
      print("result : ${response.data}");
      newToken = jsonDecode(response.data)['access'];
      storageService.storeItem(key: accessToken, value: jsonDecode(response.data)['token']);
      storageService.storeItem(key: refreshToken, value: jsonDecode(response.data)['refreshToken']);

      return true;
    } else if (response.statusCode == 401) {
      print('refreshAuthToken');
      return false;
    } else {
      print('refresh token is wrong');
      storageService.deleteItem(key: refreshToken);
      storageService.deleteItem(key: accessToken);

      return false;
    }
  } catch (e) {
    return false;
  }
}

Future _retry(RequestOptions requestOptions) async {
  final options = Options(
      method: requestOptions.method,
      headers: {HttpHeaders.authorizationHeader: 'Bearer $newToken'});

  return connect().request(requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options);
}

List<String> convertDynamicListToStringList(List<dynamic> dynamicList) {
  List<String> stringList = [];

  for (var item in dynamicList) {
    if (item is String) {
      stringList.add(item);
    } else {
      // Convert the item to a String and add it to the list
      stringList.add(item.toString());
    }
  }

  return stringList;
}

String formatErrorMessageList(List<String> errorMessages) {
  if (errorMessages.isEmpty) {
    return ""; // Return an empty string if the list is empty
  }

  // Use a StringBuffer to efficiently build the formatted string
  StringBuffer formattedString = StringBuffer();

  for (int i = 0; i < errorMessages.length; i++) {
    String errorMessage = errorMessages[i];
    formattedString.write("• "); // Add a bullet point

    if (i == errorMessages.length - 1) {
      formattedString.write(errorMessage); // Add the error message without a new line
    } else {
      formattedString.writeln(errorMessage); // Add the error message with a new line
    }
  }

  return formattedString.toString(); // Convert the StringBuffer to a String
}