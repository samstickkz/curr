import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../../core/models/user.dart';
import '../../../../locator.dart';
import '../../../../routes/routes.dart';
import '../../../base.vm.dart';
import 'buy_token/buy.token.ui.dart';

class HomePageViewModel extends BaseViewModel{

  init(BuildContext contexts)async{
    context = contexts;
    // await fetchCryptoPrice();
  }

  late BuildContext context;



  setAsHidden() async {
    bool changedValue = userService.hideDetails;
    var data = {"value": !changedValue};
    storageService.storeItem(key: "CHANGE_VISIBILITY", value:  jsonEncode(data));
    userService.hideDetails = !changedValue;
    await initializer.init();
    notifyListeners();

  }

  Future<User?> getUser()async{
    startLoader();
    try{
      var response = await repository.getUser();
      await initializer.init();

      stopLoader();
      notifyListeners();
      return response;
    }catch(err){
      stopLoader();
      notifyListeners();
      return null;
    }
  }

  // Stream<List<Map<String, dynamic>>?> fetchCryptoPrice() async*{
  //   while(true){
  //     final response = await api.fetchCryptoPrice();
  //     List<Map<String, dynamic>> mappedList = convertToMaps(response);
  //     yield mappedList;
  //   }
  // }

  navigateToBalance(){
    navigationService.navigateTo(buyBal);
  }


  popBuyToken(BuildContext context){
    showBottomSheet(
      context: context,
      builder: (_) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.6,
          maxChildSize: 0.9,
          builder: (_, scrollController){
            return const BuyTokenScreen();
          }
        );
      },
    );
  }

  // Future<List<dynamic>?> fetchCryptoPrice() async {
  //   startLoader();
  //   try {
  //     var response = await api.fetchCryptoPrice();
  //     List<Map<String, dynamic>> mappedList = convertToMaps(response);
  //     cryptoList = mappedList;
  //     stopLoader();
  //   } catch (e) {
  //     print('Error fetching crypto prices: $e');
  //     stopLoader();
  //   }
  // }

  List<Map<String, dynamic>> cryptoList = [];

  String toTitleCase(String text) {
    return text.split(' ').map((word) {
      if (word.isEmpty) {
        return '';
      }
      return '${word[0].toUpperCase()}${word.substring(1)}';
    }).join(' ');
  }

  List<Map<String, dynamic>> convertToMaps(List<dynamic> originalList) {
    List<Map<String, dynamic>> resultList = [];

    for (dynamic item in originalList) {
      if (item is Map<String, dynamic>) {
        resultList.add(item);
      } else {
        // Handle cases where the item is not a map
        // For example, you might create a default map with some values
        Map<String, dynamic> defaultMap = {'defaultKey': 'defaultValue'};
        resultList.add(defaultMap);
      }
    }

    return resultList;
  }

}