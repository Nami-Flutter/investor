import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:speech/core/routing/navigation_services.dart';
import 'package:speech/data/repositries/SaveUserData.dart';
import 'package:speech/injection.dart';
import 'package:speech/presentation/screens/home_layout/home_layout_screen.dart';

import '../../core/config/app_Images.dart';
import '../../core/config/app_colors.dart';
import 'auth/login/login_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SaveUserData saveUserData=getIt();

  @override
  void initState() {
    Timer(
        const Duration(seconds: 4),
            () {
          saveUserData.getLoggedIn()==true?
              NavigationService.pushReplacement(HomeLayoutScreen())
          :
              NavigationService.pushReplacement(const LoginScreen());
            });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: AppColors.primaryColor,
          child: Stack(
            alignment: Alignment.center,
            children: [
              const SizedBox(
                  height: double.infinity,
                  width: double.infinity,
              ),

             SvgPicture.asset(
              AppImages.splashLogo,
                  width: 50.w,
               height: 5.h,
             ),
              // Image.asset(
              //   AppImages.logoY,
              //   fit: BoxFit.fill,
              //   width: 60.w,
              // )
            ],
          ),
        ),
      ),
    );
  }
}
