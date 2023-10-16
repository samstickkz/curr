import 'package:curr/utils/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import '../../../../../utils/string-extensions.dart';
import '../../../../../widgets/app_button.dart';
import '../../../../../widgets/apptexts.dart';
import '../../../../../widgets/text_field.dart';
import '../../../../base.ui.dart';
import 'buy.token.vm.dart';

class BuyTokenScreen extends StatelessWidget {
  String enteredAmount = '';
  BuyTokenScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<BuyTokenViewModel>(
      builder: (_, model, child) => ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        child: Scaffold(
          appBar: AppBar(
            title: const AppText('Make Deposit'),
            centerTitle: true,
            elevation: 0,

            // backgroundColor: Theme.of(context).dividerColor,
          ),
          body: Padding(
            padding: 16.0.padH,
            child: Column(
              children: [
                Column(
                  children: [
                    const AppText(
                        'Please note your desposit will be processed within 24 hours'),
                    16.0.sbH,
                    //account number
                    GestureDetector(
                      onTap: () {
                        const accountNumber =
                            '0111375104'; // Replace with your actual account number
                        Clipboard.setData(
                            const ClipboardData(text: accountNumber));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Account number copied to clipboard')),
                        );
                      },
                      child: Row(
                        children: [
                          const AppText('Account Number:'),
                          8.0.sbW,
                          const AppText('0111375104'),
                          8.0.sbH,
                          const Icon(Icons.content_copy,
                              color: Colors.grey, size: 16),
                        ],
                      ),
                    ),

                    16.0.sbH,
                    Row(
                      children: [
                        const AppText('Bank Name:'),
                        8.0.sbW,
                        const AppText('Guarantee Trust Bank'),
                      ],
                    ),
                    16.0.sbH,
                    Row(
                      children: [
                        const AppText('Amount:'),
                        8.0.sbW,
                        Text(
                          enteredAmount,
                          style: const TextStyle(color: Colors.white),
                        ), // Display the entered amount here
                      ],
                    ),
                  ],
                ),
                16.0.sbH,
                Form(
                  key: model.formKey,
                  child: Column(
                    children: [
                      16.0.sbH,
                      AppTextField(
                        hint: "Amount",
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        validator: emptyValidator,
                        controller: model.amountController,
                        onChanged: (val) {
                          enteredAmount =
                              val; // Update the entered amount when the TextField value changes
                          model.formKey.currentState?.validate();
                        },
                        prefix: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: AppText('NGN:'),
                            ),
                          ],
                        ),
                      ),
                      16.0.sbH,
                      AppButton(
                        onTap: () {
                          // model.popLogout(context);
                        },
                        isGradient: true,
                        text: "Make Payment",
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
