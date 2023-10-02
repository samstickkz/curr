import 'package:curr/utils/widget_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/string-extensions.dart';
import '../../../../../widgets/app_button.dart';
import '../../../../../widgets/apptexts.dart';
import '../../../../../widgets/text_field.dart';
import '../../../../base.ui.dart';
import 'buy.token.vm.dart';

class BuyTokenScreen extends StatelessWidget {
  const BuyTokenScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<BuyTokenViewModel>(
      builder: (_, model, child)=> ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        child: Scaffold(
          appBar: AppBar(
            title: const AppText('Make Deposit'),
            centerTitle: true,
            elevation: 0,


            // backgroundColor: Theme.of(context).dividerColor,
          ),
          body:

          Padding(
            padding: 16.0.padH,
            child:

            Column(
              children: [
               Column(
                 children: [
                    const AppText('Please note your desposit will be processed within 24 hours'),


                 ],
               ),
                Form(
                  key: model.formKey,
                  child: Column(
                    children: [
                      16.0.sbH,
                      AppTextField(
                        hint: "Amount",
                        keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                        validator: emptyValidator,
                        controller: model.amountController,
                        onChanged: (val){
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
                        onTap: (){
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
