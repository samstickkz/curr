import 'package:curr/utils/widget_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants/constants.dart';
import '../../../constants/palette.dart';
import '../../../constants/reuseables.dart';
import '../../../utils/string-extensions.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/apptexts.dart';
import '../../../widgets/text_field.dart';
import '../../base.ui.dart';
import 'register.vm.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterViewModel>(
      builder: (_, model, child)=> Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: 16.0.padH,
          child: Form(
            key: model.formKey,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      16.0.sbH,
                      SvgPicture.asset(AppImages.logoFull, height: 45, fit: BoxFit.contain,),
                      28.0.sbH,
                      const Row(
                        children: [
                          Expanded(child: AppText("Create your account", isBold: true, align: TextAlign.center, size: 34,)),
                        ],
                      ),
                      20.0.sbH,
                      AppTextField(
                        hint: "First name",
                        controller: model.firstNameController,
                        autofillHints: const [AutofillHints.givenName, AutofillHints.familyName],
                        validator: emptyValidator,
                        onChanged: (val){
                          model.formKey.currentState?.validate();
                        },
                      ),
                      15.0.sbH,
                      AppTextField(
                        hint: "Last name",
                        controller: model.lastNameController,
                        autofillHints: const [AutofillHints.givenName, AutofillHints.familyName],
                        validator: emptyValidator,
                        onChanged: (val){
                          model.formKey.currentState?.validate();
                        },
                      ),
                      15.0.sbH,
                      AppTextField(
                        hint: "UserName",
                        keyboardType: TextInputType.visiblePassword,
                        controller: model.userNameController,
                        autofillHints: const [AutofillHints.username],
                        validator: emptyValidator,
                        onChanged: (val){
                          model.formKey.currentState?.validate();
                        },
                      ),
                      15.0.sbH,
                      AppTextField(
                        hint: "Email Address",
                        keyboardType: TextInputType.emailAddress,
                        controller: model.emailController,
                        autofillHints: const [AutofillHints.email],
                        validator: emailValidator,
                        onChanged: (val){
                          model.formKey.currentState?.validate();
                        },
                      ),
                      15.0.sbH,
                      CustomPhoneNumberInput(
                        // controller: model.phoneNumberController,
                        isoCode: model.countryCode,
                        onInputChanged: (v) {
                          model.countryCode = v.dialCode;
                          model.phoneNumber = v.phoneNumber;
                          model.formKey.currentState?.validate();
                        },
                        validator: (val){
                          String phoneNumber = model.phoneNumber??"";
                          if(model.countryCode==null){
                            return "Select A country to proceed";
                          }else if(phoneNumber.isEmpty){
                            return "Phone Number cannot be empty";
                          }else if(phoneNumber.length<11){
                            return "Enter a correct phone number";
                          }
                        },
                      ),
                      15.0.sbH,
                      AppTextField(
                        hint: "Password",
                        keyboardType: TextInputType.visiblePassword,
                        controller: model.passwordController,
                        autofillHints: const [AutofillHints.newPassword],
                        validator: passwordValidator,
                        isPassword: true,
                        onChanged: (val){
                          model.formKey.currentState?.validate();
                        },
                      ),
                      15.0.sbH,
                      AppTextField(
                        hint: "Confirm Password",
                        keyboardType: TextInputType.visiblePassword,
                        controller: model.confirmPasswordController,
                        autofillHints: const [AutofillHints.newPassword],
                        validator: (val){
                          String value = val??"";
                          if(value.trim().isEmpty){
                            return "Confirm password cannot be empty";
                          }else if(value.trim() != model.passwordController.text){
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
                        onTap: model.register,
                        isGradient: true,
                        text: 'Register',
                      ),

                      25.0.sbH,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Expanded(
                            child: AppText(
                              'Got an account?', size: 15,align: TextAlign.end,
                            ),
                          ),
                          InkWell(
                            onTap: navigationService.goBack,
                            child: AppText(
                              ' Sign in instead', isBold: true, size: 15,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      50.0.sbH,
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