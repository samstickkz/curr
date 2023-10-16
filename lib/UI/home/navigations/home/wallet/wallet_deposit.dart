import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../../constants/reuseables.dart';
import '../../../../../core/models/model.dart';

class WalletDeposit extends StatefulWidget {
  const WalletDeposit({super.key});

  @override
  State<WalletDeposit> createState() => _WalletDepositState();
}

class _WalletDepositState extends State<WalletDeposit> {
  String walletAddress = '';
  bool isLoading = false;

  Future<void> fetchWalletAddress(BuildContext context) async {
    const apiUrl =
        'https://projectx-anf9.onrender.com/api/addresses/createaddress/3';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        print(response.body);
        final decodedResponse = json.decode(response.body);
        final welcome = Welcome.fromJson(decodedResponse);
        setState(() {
          isLoading = false;

          walletAddress = welcome.data.address;
        });
      } else {
        setState(() {
          print(response.body);
          walletAddress = 'Failed to fetch address.';
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        walletAddress = 'Error: $e';
      });
    } finally {
      setState(() {
        isLoading =
            false; // Set isLoading to false in both success and error cases
      });
    }
  }

  void _showDepModal(BuildContext context) {
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

  final List<String> names = ['John', 'Alice', 'Bob', 'Eve'];
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _startScrolling();
  }

  void _startScrolling() {
    Timer.periodic(const Duration(milliseconds: 20), (timer) {
      if (_scrollController.hasClients) {
        setState(() {
          _scrollOffset += 1.0;
          _scrollController.jumpTo(_scrollOffset);
          if (_scrollOffset >= _scrollController.position.maxScrollExtent) {
            _scrollOffset = 0.0;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 24, right: 24),
        child: Column(
          children: [
            const Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // add image
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Container(
                //     height: 50,
                //     width: 50,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(50),
                //       color: HexColor('232336'),
                //     ),
                //     child: Padding(
                //       padding: const EdgeInsets.all(12.0),
                //       child: Image.asset(
                //         'assets/image/grow.png',
                //         height: 32,
                //         width: 32,
                //       ),
                //     ),
                //   ),
                // ),

                //Welcome message
                Text('Welcome Samuel',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ],
            ),

            const SizedBox(height: 20),
            Text('Account Balance',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 15,
                )),
            const SizedBox(height: 30),
            const Text('\$25,000',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold)),

            //deposit, withdraw and

            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.deepPurpleAccent,
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/image/Download.png',
                          height: 15, // Adjusted height to match the container
                          width: 17, // Adjusted width to match the container
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Withdraw',
                      style: TextStyle(color: Colors.white.withOpacity(0.5)),
                    )
                  ],
                ),
                const SizedBox(
                  width: 40,
                ),
                Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.deepPurpleAccent,
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/image/Send.png',
                          height: 15, // Adjusted height to match the container
                          width: 17, // Adjusted width to match the container
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Transfer',
                      style: TextStyle(color: Colors.white.withOpacity(0.5)),
                    )
                  ],
                ),
                const SizedBox(
                  width: 40,
                ),
                Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.deepPurpleAccent,
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/image/Wallet 2.png',
                          height: 15, // Adjusted height to match the container
                          width: 17, // Adjusted width to match the container
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Deposit',
                      style: TextStyle(color: Colors.white.withOpacity(0.5)),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            const Row(
              children: [
                Text('Latest Winners',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    )),
              ],
            ),

            const SizedBox(
              height: 20,
            ),
            //latest winners slide in containers with blue background
            // Expanded(
            //
            //   child: ListView(
            //
            //     scrollDirection: Axis.horizontal,
            //     children: [
            //       Container(
            //         height: 90,
            //         width: 126,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(12),
            //           color: Colors.deepPurpleAccent,
            //         ),
            //       ),    Container(
            //         height: 90,
            //         width: 126,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(12),
            //           color: Colors.deepPurpleAccent,
            //         ),
            //       ),    Container(
            //         height: 90,
            //         width: 126,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(12),
            //           color: Colors.deepPurpleAccent,
            //         ),
            //       ),
            //     ],
            //   ),
            // )
            //     Container(
            //       height: 50.0,
            //       width: double.infinity,
            //       // color: Colors.white.withOpacity(0.5),
            //       child: ListView.builder(
            //         scrollDirection: Axis.horizontal,
            //         itemCount: names.length * 2, // A large number to simulate infinite scrolling
            //         itemBuilder: (context, index) {
            //           final nameIndex = index % names.length;
            //           return Container(
            //             width: 120.0, // Adjust the width as needed
            //             margin: EdgeInsets.symmetric(horizontal: 8.0), // Add spacing between boxes
            //             alignment: Alignment.center,
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(12),
            //               border: Border.all(color: Colors.deepPurpleAccent), // Add borders around each box
            //             ),
            //             child: Text(
            //               names[nameIndex],
            //               style: TextStyle(fontSize: 18.0, color: Colors.white
            //             ),
            //           ));
            //         },
            //       ),
            //     ),

            Container(
              height: 50.0,
              width: double.infinity,
              // color: Colors.white.withOpacity(0.5),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                itemCount: names.length *
                    2, // A large number to simulate infinite scrolling
                itemBuilder: (context, index) {
                  final nameIndex = index % names.length;
                  return Container(
                    width: 120.0, // Adjust the width as needed
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8.0), // Add spacing between boxes
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: Colors
                              .deepPurpleAccent), // Add borders around each box
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          names[nameIndex],
                          style: const TextStyle(
                              fontSize: 18.0, color: Colors.white),
                        ),
                        const Text(
                          '\$2000',
                          style: TextStyle(fontSize: 10.0, color: Colors.green),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 13,
                        ),
                        Column(
                          children: [
                            GestureDetector(




                              child: Container(
                                  height: 73,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: HexColor('232336'),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          'images/Solana icon.png',
                                          height: 32,
                                          width: 32,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Solana',
                                              style: TextStyle(
                                                color: HexColor('E4E4F0'),
                                                fontSize: 17,
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  '30 Jul 2022, 3.30 PM',
                                                  style: TextStyle(
                                                    color: HexColor('A7A7CC'),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              '+0.65 ETH',
                                              style: TextStyle(
                                                color: HexColor('E4E4F0'),
                                              ),
                                            ),
                                            Text(
                                              '+0.54%',
                                              style: TextStyle(
                                                color: HexColor('7878FA'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Watchlist',
                                  style: TextStyle(
                                    color: HexColor('E4E4F0'),
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                                height: 73,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: HexColor('232336'),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        'images/Bitcoin.png',
                                        height: 32,
                                        width: 32,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Bitcoin',
                                            style: TextStyle(
                                              color: HexColor('E4E4F0'),
                                              fontSize: 17,
                                            ),
                                          ),
                                          Text(
                                            'BTC',
                                            style: TextStyle(
                                              color: HexColor('A7A7CC'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 100,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '\$21,262.60',
                                            style: TextStyle(
                                              color: HexColor('E4E4F0'),
                                            ),
                                          ),
                                          Row(
                                            // mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                '+0.54%',
                                                style: TextStyle(
                                                  color: HexColor('7878FA'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                                height: 73,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: HexColor('232336'),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        'images/Ethereum icon.png',
                                        height: 32,
                                        width: 32,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Ethereum',
                                            style: TextStyle(
                                              color: HexColor('E4E4F0'),
                                              fontSize: 17,
                                            ),
                                          ),
                                          Text(
                                            'ETH',
                                            style: TextStyle(
                                              color: HexColor('A7A7CC'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 100,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '\$1,225.85',
                                            style: TextStyle(
                                              color: HexColor('E4E4F0'),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '+0.54%',
                                                style: TextStyle(
                                                  color: HexColor('7878FA'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),

      // Column(
      //   children: [
      //     Center(
      //         child: Text(
      //       'Wallet',
      //       style: TextStyle(
      //           color: Colors.white,
      //           fontSize: 20,
      //           fontWeight: FontWeight.bold),
      //     )),
      //     SizedBox(height: 20),
      //     // Padding(
      //     //   padding: const EdgeInsets.all(8.0),
      //     //   child: Column(
      //     //     children: [
      //     //       Container(
      //     //           height: 100,
      //     //           width: double.infinity,
      //     //           decoration: BoxDecoration(
      //     //             borderRadius: BorderRadius.circular(12),
      //     //             color: HexColor('232336'),
      //     //           ),
      //     //           child: Padding(
      //     //             padding: const EdgeInsets.all(12.0),
      //     //             child: Row(
      //     //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     //               children: [
      //     //                 Image.asset(
      //     //                   'images/Ethereum icon.png',
      //     //                   height: 32,
      //     //                   width: 32,
      //     //                 ),
      //     //                 Column(
      //     //                   mainAxisAlignment:
      //     //                       MainAxisAlignment.spaceBetween,
      //     //                   crossAxisAlignment: CrossAxisAlignment.start,
      //     //                   children: [
      //     //                     Text(
      //     //                       'Ethereum',
      //     //                       style: TextStyle(
      //     //                         color: HexColor('E4E4F0'),
      //     //                         fontSize: 17,
      //     //                       ),
      //     //                     ),
      //     //
      //     //                     //button
      //     //                     ElevatedButton(
      //     //                       onPressed: () async {
      //     //                         setState(() {
      //     //                           isLoading = true;
      //     //                         });
      //     //                         await fetchWalletAddress(context);
      //     //                         _showDepModal(context);
      //     //                         //show modal bottom sheet
      //     //                       },
      //     //                       style: ElevatedButton.styleFrom(
      //     //                         backgroundColor: HexColor('4A4A58'),
      //     //                         shape: RoundedRectangleBorder(
      //     //                           borderRadius: BorderRadius.circular(12),
      //     //                         ),
      //     //                       ),
      //     //                       child: Text(
      //     //                         'Deposit',
      //     //                         style: TextStyle(
      //     //                           color: HexColor('E4E4F0'),
      //     //                           fontSize: 17,
      //     //                         ),
      //     //                       ),
      //     //                     ),
      //     //                   ],
      //     //                 ),
      //     //                 const SizedBox(
      //     //                   width: 100,
      //     //                 ),
      //     //                 Column(
      //     //                   crossAxisAlignment: CrossAxisAlignment.end,
      //     //                   mainAxisAlignment:
      //     //                       MainAxisAlignment.spaceBetween,
      //     //                   children: [
      //     //                     Text(
      //     //                       'Balance: \$2000',
      //     //                       style: TextStyle(
      //     //                         color: HexColor('E4E4F0'),
      //     //                       ),
      //     //                     ),
      //     //                     //withdraw button
      //     //                     ElevatedButton(
      //     //                       onPressed: () {
      //     //                         // Get.to(() => CoinPage());
      //     //                       },
      //     //                       style: ElevatedButton.styleFrom(
      //     //                         backgroundColor: HexColor('4A4A58'),
      //     //                         shape: RoundedRectangleBorder(
      //     //                           borderRadius: BorderRadius.circular(12),
      //     //                         ),
      //     //                       ),
      //     //                       child: Text(
      //     //                         'Withdraw',
      //     //                         style: TextStyle(
      //     //                           color: HexColor('E4E4F0'),
      //     //                           fontSize: 17,
      //     //                         ),
      //     //                       ),
      //     //                     ),
      //     //                   ],
      //     //                 ),
      //     //               ],
      //     //             ),
      //     //           )),
      //     //     ],
      //     //   ),
      //     // ),
      //
      //
      //   ],
      // ),
    ));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
