import 'package:curr/utils/string-extensions.dart';
import 'package:curr/utils/widget_extensions.dart';
import 'package:curr/widgets/text_field.dart';
import 'package:flutter/material.dart';

import '../../../../../widgets/app_button.dart';
import '../../../../base.ui.dart';
import 'change_password.vm.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ChangePasswordViewModel>(
      builder: (_, model, child)=>Scaffold(
        appBar: AppBar(
          title: const Text("Change Password"),
        ),
        body: Form(
          key: model.formKey,
          child: ListView(
            padding: 16.0.padA,
            children: [
              30.0.sbH,
              AppTextField(
                isPassword: true,
                controller: model.oldPasswordController,
                hint: "Enter Old Password",
                onChanged: model.validate,
                validator: emptyValidator,
              ),
              16.0.sbH,
              AppTextField(
                isPassword: true,
                controller: model.newPasswordController,
                hint: "Enter New Password",
                validator: passwordValidator,
                keyboardType: TextInputType.visiblePassword,
                onChanged: model.validate,
              ),
              16.0.sbH,
              AppTextField(
                isPassword: true,
                controller: model.confirmNewPasswordController,
                hint: "Confirm New Password",
                onChanged: model.validate,
                validator: (val){
                  String value = val??'';
                  if(value.trim().isEmpty){
                    return "Confirm password cannot be empty";
                  }else if(value.trim()!=model.newPasswordController.text.trim()){
                    return "Confirm password must be the same as new password";
                  }
                },
              ),
              30.0.sbH,
              AppButton(
                onTap: model.submit,
                text: "Submit",
                isGradient: true,
              ),
              50.0.sbH,

            ],
          ),
        ),
      ),
    );
  }
}
