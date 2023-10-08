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
                      // AppTextField(
                      //   hint: "Full name",
                      //   keyboardType: TextInputType.visiblePassword,
                      //   controller: model.fullNameController,
                      //   autofillHints: const [AutofillHints.givenName, AutofillHints.middleName, AutofillHints.familyName],
                      //   validator: (val){
                      //     String value = val??"";
                      //     if (!validateFullName(value.trim())) {
                      //       return "Invalid full name";
                      //     }
                      //   },
                      //   onChanged: (val){
                      //     model.formKey.currentState?.validate();
                      //   },
                      // ),
                      // 15.0.sbH,
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
                      15.0.sbH,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CupertinoCheckbox(value: model.isActive, onChanged: model.changeStatus, activeColor: primaryColor,),
                          16.0.sbH,
                          Expanded(child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'I have read and accepted the ',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Terms and Conditions',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: primaryColor,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = (){}, // Add tap gesture recognizer
                                ),
                              ],
                            ),
                          ))
                        ],
                      ),
                      15.0.sbH,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Expanded(
                            child: AppText(
                              'Got an account?', size: 14,align: TextAlign.end,
                            ),
                          ),
                          InkWell(
                            onTap: navigationService.goBack,
                            child: AppText(
                              ' Sign in instead', isBold: true, size: 14,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      15.0.sbH,

                    ],
                  ),
                ),
                Column(
                  children: [
                    AppButton(
                      onTap: model.register,
                      isGradient: true,
                      text: 'Register',
                    ),
                    16.0.sbH,
                    // AppButton(
                    //   onTap: model.authApi.signinWithGoogle,
                    //   isTransparent: true,
                    //   child: Row(
                    //     children: [
                    //       Image.asset(
                    //         'images/Google.png',
                    //         width: 18,
                    //         height: 18,
                    //       ),
                    //       10.0.sbW,
                    //       const AppText(
                    //           'SignUp in Google'
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    40.0.sbH
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
