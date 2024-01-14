import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speech/core/config/app_Images.dart';
import 'package:sizer/sizer.dart';
import 'package:speech/core/config/app_colors.dart';

class CustomAppBar extends StatelessWidget {
   CustomAppBar({Key? key,required this.prefixIcon,required this.suffixIcon}) : super(key: key);

  Widget prefixIcon;
  Widget suffixIcon;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      margin: EdgeInsets.only(top: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          prefixIcon,
          const Expanded(child: SizedBox()),
          SvgPicture.asset(
            AppImages.splashLogo,
          color: AppColors.primaryColor,
          height: 3.h),
          const Expanded(child: SizedBox()),
         suffixIcon
        ],
      ),
    );
  }
}
