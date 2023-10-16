import 'package:cached_network_image/cached_network_image.dart';
import 'package:curr/UI/base.ui.dart';
import 'package:curr/constants/reuseables.dart';
import 'package:curr/utils/string-extensions.dart';
import 'package:curr/utils/widget_extensions.dart';
import 'package:curr/widgets/app_button.dart';
import 'package:curr/widgets/apptexts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'edit.profile.vm.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<EditProfileViewModel>(
      builder: (_,model,child)=>RefreshIndicator(
        onRefresh: ()async => model.getUser(),
        child: Scaffold(
          appBar: AppBar(
            title: Text("My Profile"),
          ),
          body: ListView(
            padding: 16.0.padH,
            children: [
              40.0.sbH,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      height: 100, width: 100,
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: model.files.value.isNotEmpty? null: const DecorationImage(
                          image: CachedNetworkImageProvider(AppString.profilePic)
                        )
                      ),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          model.files.value.isNotEmpty? Container(
                            height: height(context),
                            width: width(context),
                            child: Image.file(model.files.value.first, fit: BoxFit.cover,),
                          ):0.0.sbH,
                          GestureDetector(
                            onTap: ()=> model.files.value.isEmpty? model.getImage(context): model.removeItem(),
                            child: Container(
                              height: 30,
                              color: Colors.black.withOpacity(0.5),
                              child: Center(
                                child: model.files.value.isEmpty? const AppText("EDIT",isBold: true, size: 13,) : const AppText("REMOVE",isBold: true, size: 13,),
                              ),
                            ),
                          ),
                        ],
                      )
                    ),
                  ),
                ],
              ),
              30.0.sbH,
              ProfileInputField(
                controller: model.usernameController,
                hint: "Username:",
                onChanged: (v){},
              ),
              ProfileInputField(
                controller: model.firstNameController,
                hint: "First Name:",
                onChanged: (v){},
              ),
              ProfileInputField(
                controller: model.lastNameController,
                hint: "Last Name:",
                onChanged: (v){},
              ),
              ProfileInputField(
                controller: model.emailController,
                hint: "Email:",
                onChanged: (v){},
              ),
              ProfileInputField(
                controller: model.phoneNumberController,
                hint: "Phone Number:",
                onChanged: (v){},
                keyboardType: TextInputType.number,
              ),
              30.0.sbH,
              AppButton(
                onTap: model.updateProfile,
                text: "Save Changes",
                isGradient: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileInputField extends StatelessWidget {
  final TextEditingController? controller;
  final TextStyle? style;
  final TextInputType keyboardType;
  final String? hint;
  final Function(String)? onChanged;
  const ProfileInputField({
    super.key, this.controller, this.style, this.hint, this.onChanged, this.keyboardType=TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AppText(hint??"Name: ", color: context.textTheme.bodySmall?.color,),
            Expanded(
              child: TextFormField(
                textDirection: TextDirection.rtl,
                controller: controller,
                onChanged: onChanged,
                keyboardType: keyboardType,
                style: style?? appStyle.copyWith(fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                ),
              )
            )
          ],
        ),
        Container(height: 0.4, width: width(context), color: Colors.white,),
        16.0.sbH
      ],
    );
  }
}
