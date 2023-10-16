import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:curr/UI/base.ui.dart';
import 'package:curr/utils/widget_extensions.dart';
import 'package:curr/widgets/apptexts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../../constants/reuseables.dart';
import '../../../../../core/models/model.dart';
import 'wallet_deposit.vm.dart';

class WalletDeposit extends StatelessWidget {
  const WalletDeposit({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<WalletDepositViewModel>(
      onModelReady: (m)=> m.init(context),
      onDisposeReady: (m)=> m.scrollController.dispose(),
      builder: (_, model, child)=> Scaffold(
        body: SafeArea(
          top: true,
          child: ListView(
            padding: 10.0.padH,
            children: [
              Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // add image
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: CachedNetworkImageProvider(AppString.profilePic),
                  ),
                  16.0.sbW,
                  //Welcome message
                  AppText('Welcome ${model.userService.userCredentials.firstName} ${model.userService.userCredentials.lastName}',
                      align: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 20),
              AppText('Account Balance',
                  align: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 15,
                  )),
              const SizedBox(height: 30),
              const AppText('\$25,000',
                  align: TextAlign.center,
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
                  controller: model.scrollController,
                  itemCount: model.names.length *
                      2, // A large number to simulate infinite scrolling
                  itemBuilder: (context, index) {
                    final nameIndex = index % model.names.length;
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
                            model.names[nameIndex],
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
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
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
              )

            ],
          ),
        ),
      ),
    );
  }
}

