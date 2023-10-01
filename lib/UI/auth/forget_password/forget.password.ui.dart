import 'package:curr/UI/base.ui.dart';
import 'package:curr/utils/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/reuseables.dart';
import '../../../utils/string-extensions.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/apptexts.dart';
import '../../../widgets/text_field.dart';
import 'forget.password.vm.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ForgetPasswordViewModel>(
      builder: (_, model, child)=> Scaffold(
        appBar: AppBar(),
        body: Form(
          key: model.formKey,
          child: ListView(
            padding: 16.0.padA,
            children: [
              16.0.sbH,
              const Row(
                children:  [
                  Expanded(child: AppText("Forgot Password", isBold: true, align: TextAlign.center, size: 25,)),
                ],
              ),
              50.0.sbH,
              AppTextField(
                hintText: "Enter Email",
                hint: "Enter your Email",
                keyboardType: TextInputType.emailAddress,
                validator: emailValidator,
                controller: model.emailController,
                autofillHints: const [AutofillHints.email],
                onChanged: (val){
                  model.formKey.currentState?.validate();
                },
              ),
              20.0.sbH,
              AppButton(
                onTap: model.forgetPassWord,
                isGradient: true,
                text: 'Submit',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
