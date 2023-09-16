import 'package:flutter/material.dart';
import '../../../../locator.dart';
import '../../../base.vm.dart';
import 'buy_token/buy.token.ui.dart';

class HomePageViewModel extends BaseViewModel{

  HomePageViewModel(){
    init();
  }

  init()async{
    // await fetchCryptoPrice();
  }



  setAsHidden() async {
    bool changedValue = userService.userCredentials.isHidden==null?false:userService.userCredentials.isHidden==true?false:true;
    startLoader();
    // try{
    //   var response = await authApi.updateUser(isHidden: changedValue);
    //   if(response){
    //     await authApi.getUser();
    //     initializer.init();
    //   }
    //   stopLoader();
    //   notifyListeners();
    // }catch(err){
    //   stopLoader();
    //   notifyListeners();
    // }

    // initializer.init();
    notifyListeners();
  }

  // Stream<List<Map<String, dynamic>>?> fetchCryptoPrice() async*{
  //   while(true){
  //     final response = await api.fetchCryptoPrice();
  //     List<Map<String, dynamic>> mappedList = convertToMaps(response);
  //     yield mappedList;
  //   }
  // }

  ScrollController scrollController = ScrollController();

  popBuyToken(BuildContext context){
    showBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.6,
          maxChildSize: 0.9,
          builder: (context, scrollController){
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