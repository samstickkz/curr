import 'package:cached_network_image/cached_network_image.dart';
import 'package:curr/utils/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../constants/constants.dart';
import '../../../../../constants/palette.dart';
import '../../../../../constants/reuseables.dart';
import '../../../../../widgets/apptexts.dart';
import '../../../../base.ui.dart';
import 'drawer.vm.dart';
import 'raffle/raflle.ui.dart';

class DrawerScreen extends StatelessWidget {
  final VoidCallback drawer;
  const DrawerScreen({Key? key, required this.drawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<DrawerViewModel>(
      builder: (_, model, child)=> Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              70.0.sbH,
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: CachedNetworkImageProvider(AppString.profilePic),
                  ),
                ],
              ),
              16.0.sbH,
              Row(
                children: [
                  Expanded(child: AppText("${userService.userCredentials.firstName} ${userService.userCredentials.lastName}", size: 20, align: TextAlign.center,)),
                ],
              ),
              10.0.sbH,
              Divider(color: primaryColor,),
              ListTile(
                leading: const Icon(
                  Icons.calculate_sharp,
                  color: Colors.white,
                ),
                title: const Text(
                  'Calculator',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                trailing: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: HexColor('8BC185'),
                  ),
                  child: const Center(
                      child: Text(
                        '4',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      )),
                ),
                onTap: () {},
              ),
              //rewards
              ListTile(
                leading: const Icon(
                  Icons.money_outlined,
                  color: Colors.white,
                ),
                title: const Text(
                  'news',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                trailing: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: HexColor('8BC185'),
                  ),
                  child: const Center(
                      child: Text(
                        '11',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      )),
                ),
              ),
              //Address
              ListTile(
                leading: const Icon(
                  Icons.account_balance_wallet_rounded,
                  color: Colors.white,
                ),
                title: const Text(
                  'Address',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                trailing: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.deepPurpleAccent.shade200,
                  ),
                  child: const Center(
                      child: Text(
                        '1',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      )),
                ),
              ),
              //Payments
              InkWell(
                onTap: drawer,
                child: ListTile(
                  leading: const Icon(
                    Icons.wind_power,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Raffle',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  trailing: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: const Center(
                        child: Text(
                          '22',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        )),
                  ),
                ),
              ),
            ],
          ),
          16.0.sbH,
          ListTile(
            leading: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.white),
              ),
              child: const Icon(
                Icons.question_mark,
                color: Colors.white,
              ),
            ),
            title: const Text(
              'Log Out',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: ()=>model.popLogout(context),
          ),
        ],
      ),
    );
  }
}
