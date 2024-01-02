import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:speech/presentation/screens/auth/register/PersonalKnowledge/personal_knowledge.dart';
import 'package:speech/presentation/widgets/SnackBar.dart';
import '../../../../../core/config/app_strings.dart';
import '../../../../../core/routing/navigation_services.dart';

class OtpViewModel with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  String? verificationId;
  bool isLoading=false;
  int seconds=45;
  int? resendToken;
  Timer? timer;
  bool isTimerStarted = false;


  void init(String phoneNumber,bool newAccount,BuildContext context){
    seconds = 45;
    isLoading = false;
    isTimerStarted = false;
    notifyListeners();
    sendSms(newAccount: newAccount, phoneNumber: phoneNumber, context: context);
  }

  void startTimer(){
    seconds = 45;
    stopTimer();
    isTimerStarted = true;
    notifyListeners();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {

      if(seconds>0){
        seconds--;
        notifyListeners();
      }else{
        timer.cancel();
        isTimerStarted = false;
        notifyListeners();
      }
    });
  }

  void stopTimer(){
    if(timer!=null&&timer!.isActive){
      timer!.cancel();
    }
  }


  Future sendSms({required bool newAccount,required String phoneNumber,required context}) async {
    String phone ='';
    if(phoneNumber.startsWith('0')){
     phoneNumber =  phoneNumber.replaceFirst('0', '');
     phone = '+966$phoneNumber';
    }else{
      phone = '+966$phoneNumber';
    }
    notifyListeners();

    try{
      await auth.verifyPhoneNumber(
        phoneNumber:phone,
        timeout: const Duration(seconds: 45),
        forceResendingToken: resendToken,
        verificationCompleted: (PhoneAuthCredential credential) {
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            snackBar(context: context, message: "Phone number is invalid should start with +966 and 9 digits or 10 digits start with zero".tr(), color: Colors.red);

          }else{
            snackBar(context: context, message: e.code, color: Colors.red);

          }
        },
        codeSent: (String verificationId, int? resendToken) {
          this.resendToken = resendToken;
          this.verificationId=verificationId;
          startTimer();
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          snackBar(context: context, message: "Session expired".tr(), color: Colors.red);

        },
      ).then((value) {


      }).catchError((onError){


      });
    }catch (e){

    }

  }


  String sms="";

  checkSms({required bool newAccount,required context})async{

    if(sms.length!=6){
      snackBar(context: context, message: "Invalid verification code".tr(), color: Colors.red);
      return;
    }

    if(verificationId!=null){
      isLoading=true;
      notifyListeners();
      try{
        print('sms=>>>${sms}');

        /*PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId!, smsCode: sms);
        await auth.signInWithCredential(credential).then((value){
          print(value);
          isLoading=true;
          notifyListeners();
        });
*/
        PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId!, smsCode: sms);
        await auth.signInWithCredential(credential).catchError((onError) {
          isLoading = false;
          notifyListeners();


          throw onError;
        }).then((value) {
          isLoading = false;
          notifyListeners();
          stopTimer();
          seconds = 45;
          NavigationService.pushReplacement(PersonalKnowledgeScreen(newAccount: newAccount,));
        });

      }catch(e){
        print('errrrr=>>>>${e}');

        if (e is FirebaseAuthException) {

          print("error=>>>>>${e.code}");

          if (e.code == "session-expired") {
            snackBar(context: context, message: "Session expired".tr(), color: Colors.red);

          }else if(e.code=='invalid-verification-code'){
            snackBar(context: context, message: "Invalid verification code".tr(), color: Colors.red);

          }else{
            snackBar(context: context, message: e.code, color: Colors.red);

          }
        }




      }


      isLoading=false;
      notifyListeners();
    }else{
      snackBar(context: context, message: "Code not sent".tr(), color: Colors.red);

    }

  }


}
