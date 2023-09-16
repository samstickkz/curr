import 'dart:convert';

import 'package:dio/dio.dart';

import '../../models/crypto_response.dart';
import 'base-api.dart';
import 'nertwork_config.dart';

class ExternalApiServices {
  Future<List<dynamic>> fetchCryptoPrice()async{
    try{
      Dio dio = Dio();
      var response = await dio.get(NetworkConfig.cryptoPrice);
      List<dynamic> responseData = response.data;
      return responseData;
    }catch(err){
      handleError(err);
      print(err);
      return [];
    }
  }


  List<Map<String, dynamic>> convertToDesiredList(Map<String, dynamic> data) {
    List<Map<String, dynamic>> resultList = [];

    data.forEach((type, values) {
      Map<String, dynamic> entry = {
        "type": type,
        "values": values
      };
      resultList.add(entry);
    });

    return resultList;
  }
}