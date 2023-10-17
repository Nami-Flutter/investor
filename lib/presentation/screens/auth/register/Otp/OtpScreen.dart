import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:speech/core/config/app_colors.dart';
import 'package:speech/core/config/app_strings.dart';
import 'package:speech/presentation/screens/auth/register/Otp/OtpViewModel.dart';
import 'package:speech/presentation/screens/auth/register/PersonalKnowledge/personal_knowledge.dart';
import 'package:speech/presentation/widgets/AnimatedButton.dart';
import 'package:speech/presentation/widgets/default_text.dart';
import '../../../../widgets/logo_container.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:timer_count_down/timer_count_down.dart';

class OTP extends StatefulWidget {
  OTP({Key? key, required this.newAccount,required this.phoneNumber}) : super(key: key);

  bool newAccount;
  String phoneNumber;

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            LogoContainer(
              ctx: context,
              arrowBack: true,
              height: 22.h,
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      DefaultText(
                        title: AppStrings.verify.tr(),
                        size: 28,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),

                      RichText(
                        maxLines: 10,
                        text: TextSpan(
                          text: AppStrings.enterCode.tr(),
                          style: const TextStyle(
                              fontSize: 15,
                              fontFamily: "DIN Next LT W23",
                              fontWeight: FontWeight.w400,
                              color: AppColors.normalText),
                          children: <TextSpan>[
                            TextSpan(
                                text: widget.phoneNumber,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: AppColors.normalText,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "DIN Next LT W23",
                                )),
                          ],
                        ),
                      ),

                      VerificationCode(
                        margin: EdgeInsets.all(1.w),
                        digitsOnly: true,
                        fullBorder: true,
                        itemSize: 10.w,
                        isSecure: true,
                        textStyle: const TextStyle(
                            fontSize: 20.0, color: Colors.black),
                        keyboardType: TextInputType.number,
                        underlineColor: const Color(0xff3E8CAB),
                        underlineUnfocusedColor: Colors.blue,
                        length: 6,
                        cursorColor: Colors.blue,
                        clearAll: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Provider.of<OtpViewModel>(context,).title=="resend".tr()?
                          TextButton(
                            child: Text( Provider.of<OtpViewModel>(context,).title,
                                style: const TextStyle(
                                    fontSize: 14.0, color: AppColors.primaryColor)),
                           onPressed: (){
                             Provider.of<OtpViewModel>(context,listen: false).sendSms(newAccount: widget.newAccount, phoneNumber:widget.phoneNumber , context: context);
                           },
                          )
                              :Text(
                               Provider.of<OtpViewModel>(context,).title,
                                style: const TextStyle(
                                    fontSize: 14.0, color: Color(0xff686A71)),
                              ),
                              Countdown(
                                seconds: Provider.of<OtpViewModel>(context,).seconds ,
                                build: (BuildContext context, double time) =>
                                    DefaultText(
                                  title: time.toInt().toString(),
                                  color: Colors.blue,
                                  size: 16,
                                ),
                                interval: const Duration(seconds: 1),
                                onFinished: () {
                                  Provider.of<OtpViewModel>(context,listen: false).changeTitle();
                                },
                              ),
                            ],
                          ),
                        ),
                        onCompleted: (String value) {
                          Provider.of<OtpViewModel>(context, listen: false)
                              .sms = value;
                        },
                        onEditing: (bool value) {},
                      ),
                      SizedBox(
                        height: 11.h,
                      ),
                  _button()
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }



  Widget _button(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: AnimatedButton(
        isLoading:
        Provider.of<OtpViewModel>(context).isLoading,
        title: AppStrings.verify.tr(),
        onPressed: () {
          Provider.of<OtpViewModel>(context, listen: false)
              .checkSms(newAccount: widget.newAccount,context: context);
        },
        fontWeight: FontWeight.w400,
        backGroundColor: const Color(0xff3E8CAB),
        textSize: 18,
        textColor: Colors.white,
      ),
    );
  }
}
