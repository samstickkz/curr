import 'package:curr/utils/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

import '../constants/palette.dart';


Widget toast(String message, {bool? success}) {
  return
    Padding(
      padding: const EdgeInsets.only(top: 55),
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          width: double.infinity,
          // height: 40.0,
          color:
          !success! ? Colors.red : primaryDarkColor,
          child: Row(
            children: [
              if (!success) const Icon(Icons.error_outline, color: Colors.white,
                size: 24,),
              10.0.sbW,
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    color: !success ? Colors.white : Colors.white,
                    fontSize: 13.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
}

// styled! ?:

showCustomToast(String message, {bool success = false, num? time}) {

  // toast message
  showToastWidget(
    toast(message, success: success),
    duration: const Duration(seconds: 3),
    onDismiss: () {},
  );
}