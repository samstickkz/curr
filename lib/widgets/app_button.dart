import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants/palette.dart';
import '../utils/widget_extensions.dart';
import 'apptexts.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool? isTransparent;
  final bool? isGradient;
  final double? borderWidth;
  final Color? borderColor;
  final Color? backGroundColor;
  final Color? textColor;
  final String? text;
  final List<Color>? gradientColors;
  final Widget? child;
  final bool isLoading;
  const AppButton(
      {Key? key, required this.onTap,
        this.isTransparent,
        this.isGradient,
        this.isLoading =false,
        this.gradientColors, this.child, this.borderWidth, this.borderColor, this.textColor, this.backGroundColor, this.text
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width(context),
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: isGradient == true?primaryGradient :null,
        border: Border.all(width:borderWidth?? (isTransparent==true? 1: 0), color: borderColor ?? (isTransparent ==true? textColor??Colors.white: Colors.transparent)),
        color: isGradient == true? null: isTransparent==true? Colors.transparent: backGroundColor ?? primaryColor,
      ),
      child: InkWell(
        onTap: isLoading==true?null: onTap,
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          width: width(context),
          height: height(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isLoading?  const SpinKitThreeInOut(color: Colors.white) : child ??
                    AppText(text??"", family: 'Inter', size: 20, isBold: true, color: textColor, align: TextAlign.center,),
              ],
            )
          ),
        ),
      ),
    );
  }
}
