import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:speech/presentation/screens/auth/register/PersonalKnowledge/personal_knowledge.dart';
import 'package:speech/presentation/widgets/SnackBar.dart';
import '../../../../../core/config/app_strings.dart';
import '../../../../../core/routing/navigation_services.dart';
import 'OtpScreen.dart';

class OtpViewModel with ChangeNotifier {


  OtpViewModel();


  FirebaseAuth auth = FirebaseAuth.instance;
  String verificationID='';

  bool isLoading=false;
  bool _isSendSmsLoading=false;
  bool get isSendSmsLoading => _isSendSmsLoading;


  int seconds=45;

  String title= AppStrings.donotReceive.tr();

  changeTitle(){
    title="resend".tr();
    notifyListeners();
  }




  Future sendSms({required bool newAccount,required  phoneNumber,required context}) async {
    _isSendSmsLoading=true;
    title= AppStrings.donotReceive.tr();
    seconds=45;
    notifyListeners();
    await auth.verifyPhoneNumber(
      phoneNumber: '+20 10 02459682',
      verificationCompleted: (PhoneAuthCredential credential) {
      },
      verificationFailed: (FirebaseAuthException e) {
        print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee$e");
        snackBar(context: context, message: "blockDevice".tr(), color: Colors.red);
        _isSendSmsLoading=false;
        notifyListeners();
      },
      codeSent: (String verificationId, int? resendToken) {
        title= AppStrings.donotReceive.tr();
        seconds=45;
        notifyListeners();
        verificationID=verificationId;
        NavigationService.push( OTP(newAccount: newAccount,phoneNumber: phoneNumber,));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    ).then((value) {
      if(verificationID!=""){
        _isSendSmsLoading=false;
        notifyListeners();
      }

    }).catchError((onError){
      _isSendSmsLoading=false;
      notifyListeners();

    });
  }


  String sms="";

  checkSms({required bool newAccount,required context})async{

    isLoading=true;
    notifyListeners();
    try{
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationID, smsCode: sms);
      await auth.signInWithCredential(credential).then((value){
        print(value);
        isLoading=true;
        notifyListeners();
        NavigationService.pushReplacement( PersonalKnowledgeScreen(newAccount: newAccount,));
      });
      if(sms!=verificationID){
        isLoading=false;
        notifyListeners();
      }
    }catch(e){
      snackBar(context: context, message: "wrongCode".tr(), color: Colors.red);
      if (kDebugMode) {
        print(e);
      }
    }


    isLoading=false;
    notifyListeners();
  }


}
