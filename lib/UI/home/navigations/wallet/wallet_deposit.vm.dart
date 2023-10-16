import 'dart:async';
import 'dart:convert';

import 'package:curr/UI/base.vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../constants/reuseables.dart';
import '../../../../core/models/model.dart';

class WalletDepositViewModel extends BaseViewModel{
  String walletAddress = '';

  init(BuildContext ctx){
    context = ctx;
    startScrolling();
    notifyListeners();
  }

  late BuildContext context;

  final List<String> names = ['John', 'Alice', 'Bob', 'Eve'];
  final ScrollController scrollController = ScrollController();
  double scrollOffset = 0.0;

  void startScrolling() {
    Timer.periodic(const Duration(milliseconds: 20), (timer) {
      if (scrollController.hasClients) {
        scrollOffset += 1.0;
        scrollController.jumpTo(scrollOffset);
        if (scrollOffset >= scrollController.position.maxScrollExtent) {
          scrollOffset = 0.0;
        }
      }
      notifyListeners();
    });
  }

  Future<void> fetchWalletAddress() async {
    const apiUrl =
        'https://projectx-anf9.onrender.com/api/addresses/createaddress/3';
    startLoader();
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        final welcome = Welcome.fromJson(decodedResponse);
        walletAddress = welcome.data.address;
        notifyListeners();
        stopLoader();
      } else {
        notifyListeners();
        stopLoader();
      }
    } catch (e) {
      notifyListeners();
      stopLoader();
    } finally {
      notifyListeners();
      stopLoader();
    }
  }

  void showDepModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 300,
        color: HexColor('232336'),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'Deposit',
              style: TextStyle(
                color: HexColor('E4E4F0'),
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            //textfield
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                width: double.infinity,
                height: 100.0,
                child: isLoading
                    ? const Text(
                  'loading....',
                  style: TextStyle(color: AppStyle.textColorWhite),
                )
                    : Text(
                  walletAddress,
                  style: TextStyle(
                    color: HexColor('E4E4F0'),
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            //button
            ElevatedButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: walletAddress));
                Get.snackbar(
                  'Copied',
                  'Address copied to clipboard',
                  backgroundColor: Colors.white,
                  colorText: HexColor('000000'),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: HexColor('4A4A58'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: SizedBox(
                width: 125,
                child: Row(
                  children: [
                    Text(
                      'Copy Address',
                      style: TextStyle(
                        color: HexColor('E4E4F0'),
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.copy,
                      size: 15,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}