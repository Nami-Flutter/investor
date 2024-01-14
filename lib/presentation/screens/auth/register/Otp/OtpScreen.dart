import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:speech/core/config/app_colors.dart';
import 'package:speech/core/config/app_strings.dart';
import 'package:speech/injection.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<OtpViewModel>(context, listen: false).init(widget.phoneNumber,widget.newAccount, context);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: AppColors.primaryColor,statusBarIconBrightness: Brightness.light),
      ),

      body: Column(
        children: [
          LogoContainer(
            ctx: context,
            arrowBack: true,
            height: 31.h,
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    DefaultText(
                      title: AppStrings.verify.tr(),
                      size: 14,
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
                            fontFamily: "DG Trika",
                            fontWeight: FontWeight.w400,
                            color: AppColors.normalText),
                        children: <TextSpan>[
                          TextSpan(
                              text: '+966${widget.phoneNumber}',
                              style: const TextStyle(
                                fontSize: 15,
                                color: AppColors.normalText,
                                fontWeight: FontWeight.w400,
                                fontFamily: "DG Trika",
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    VerificationCode(
                      margin: EdgeInsets.all(1.w),
                      digitsOnly: true,
                      fullBorder: true,
                      itemSize: 10.w,
                      textStyle: const TextStyle(fontSize: 20.0, color: Colors.black),
                      keyboardType: TextInputType.number,
                      underlineColor: AppColors.primaryColor,
                      underlineUnfocusedColor: Colors.blue,
                      length: 6,
                      cursorColor: Colors.blue, onCompleted: (String value) {
                      OtpViewModel otpViewModel = getIt();
                      otpViewModel.sms = value;
                       /*otpViewModel.checkSms(newAccount: widget.newAccount, context: context);*/
                    }, onEditing: (bool value) {

                    },

                    ),

                    Consumer<OtpViewModel>(builder: (context,provider,_){
                      return provider.seconds>0?DefaultText(
                        title: provider.isTimerStarted?provider.seconds.toString():'',
                        size: 28,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryColor,
                      ):TextButton(onPressed: (){

                      }, child: InkWell(
                        onTap: (){
                          provider.sendSms(newAccount: widget.newAccount, phoneNumber: widget.phoneNumber, context: context);

                        },
                        child: DefaultText(
                          title: 'resend'.tr(),
                          size: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor,
                        ),
                      ));
                    }),
                    SizedBox(
                      height: 8.h,
                    ),
                _button()
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }



  Widget _button(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Consumer<OtpViewModel>(builder: (context,provider,_){
        return AnimatedButton(
          isLoading:
          provider.isLoading,
          title: AppStrings.verify.tr(),
          onPressed: () {
            provider.checkSms(newAccount: widget.newAccount,context: context);
          },
          fontWeight: FontWeight.w400,
          backGroundColor: AppColors.primaryColor,
          textSize: 14,
          textColor: Colors.white,
        );
      },),
    );
  }
}
