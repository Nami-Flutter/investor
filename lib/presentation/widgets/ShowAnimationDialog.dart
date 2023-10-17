import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:speech/presentation/widgets/default_text.dart';

import '../../core/config/app_colors.dart';

showAnimationDialog({
 required context,
  required String message,
  Widget? buttons,
  required String title,
  String? titleMessage,
  String? bodyMessage,
  bool needRichText = false,
  bool needButtons = true,
}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 2.h,),
                DefaultText(title: title, size: 14.sp),
                SizedBox(height: 2.h,),
                DefaultText(title: message, size: 14.sp),
                SizedBox(height: 2.h,),
                needRichText == true
                    ? RichText(
                        maxLines: 10,
                        text: TextSpan(
                          text: titleMessage,
                          style: const TextStyle(
                              fontSize: 15,
                              fontFamily: "DIN Next LT W23",
                              fontWeight: FontWeight.w400,
                              color: AppColors.normalText),
                          children: <TextSpan>[
                            TextSpan(
                                text: bodyMessage,
                                style: const TextStyle(
                                  height: 1.8,
                                  fontSize: 15,
                                  color: AppColors.hintText,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "DIN Next LT W23",
                                )),
                          ],
                        ),
                      )
                    : Container(),
                SizedBox(height: 2.h,),
                needButtons == true
                    ? buttons!
                    : Container(),
                SizedBox(height: 1.5.h,),
              ],
            ),
          ),
        );
      });
}
