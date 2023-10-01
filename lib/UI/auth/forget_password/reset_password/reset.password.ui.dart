import 'package:curr/UI/base.ui.dart';
import 'package:curr/constants/palette.dart';
import 'package:curr/utils/widget_extensions.dart';
import 'package:curr/widgets/appCard.dart';
import 'package:flutter/material.dart';

import '../../../../utils/string-extensions.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/apptexts.dart';
import '../../../../widgets/text_field.dart';
import 'reset.password.vm.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String? email;
  const ResetPasswordScreen({Key? key, this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ResetPasswordViewModel>(
      onModelReady: (m){
        m.init(email);
      },
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
                  Expanded(child: AppText("Reset Password", isBold: true, align: TextAlign.center, size: 25,)),
                ],
              ),
              20.0.sbH,
              AppCard(
                backgroundColor: primaryDarkColor.withOpacity(0.5),
                child: const AppText("Copy token from your mail and put it in the token field here and set a new password", align: TextAlign.center, isBold: true,),),
              16.0.sbH,
              AppTextField(
                hintText: "Email",
                hint: "Enter your Email",
                keyboardType: TextInputType.emailAddress,
                validator: emailValidator,
                controller: model.emailController,
                readonly: true,
                autofillHints: const [AutofillHints.email],
                onChanged: (val){
                  model.formKey.currentState?.validate();
                },
              ),
              16.0.sbH,
              AppTextField(
                hintText: "Token",
                hint: "Enter token from mail",
                keyboardType: TextInputType.text,
                validator: emptyValidator,
                controller: model.token,
                onChanged: (val){
                  model.formKey.currentState?.validate();
                },
              ),
              16.0.sbH,
              AppTextField(
                hintText: "Password",
                hint: "Enter New Password",
                keyboardType: TextInputType.visiblePassword,
                controller: model.password,
                autofillHints: const [AutofillHints.newPassword],
                validator: passwordValidator,
                isPassword: true,
                onChanged: (val){
                  model.formKey.currentState?.validate();
                },
              ),
              16.0.sbH,
              AppTextField(
                hintText: "Confirm Password",
                hint: "Confirm New Password",
                keyboardType: TextInputType.visiblePassword,
                controller: model.confirmPassword,
                autofillHints: const [AutofillHints.newPassword],
                validator: (val){
                  String value = val??"";
                  if(value.trim().isEmpty){
                    return "Confirm password cannot be empty";
                  }else if(value.trim() != model.password.text){
                    return "Enter the same password";
                  }
                },
                onChanged: (val){
                  model.formKey.currentState?.validate();
                },
                isPassword: true,
              ),
              16.0.sbH,
              AppButton(
                onTap: model.reset,
                isGradient: true,
                text: 'Reset',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
