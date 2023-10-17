import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech/core/config/app_colors.dart';
import 'package:speech/core/config/app_strings.dart';
import 'package:sizer/sizer.dart';
import 'package:speech/core/routing/navigation_services.dart';
import 'package:speech/presentation/screens/auth/register/Otp/OtpViewModel.dart';
import 'package:speech/presentation/screens/auth/register/PersonalKnowledge/personal_knowledge.dart';
import 'package:speech/presentation/screens/auth/register/PersonalKnowledge/personal_knowledge_view_model.dart';
import 'package:speech/presentation/screens/auth/register/Register/register_view_model.dart';
import 'package:speech/presentation/screens/setting/SettingViewModel.dart';
import 'package:speech/presentation/widgets/AnimatedButton.dart';
import 'package:speech/presentation/widgets/input_field.dart';
import '../../../../widgets/logo_container.dart';
import '../../../../widgets/default_text.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key, this.newAccount = true}) : super(key: key);

  bool newAccount;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var rePasswordController = TextEditingController();

  var idController = TextEditingController();

  var phoneNumberController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.newAccount == false) {
      emailController.text = Provider.of<SettingViewModel>(context, listen: false).userModel.data!.email.toString();
      idController.text = Provider.of<SettingViewModel>(context, listen: false).userModel.data!.national_num.toString();
    }

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LogoContainer(
              ctx: context,
              arrowBack: true,
              height: 19.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 2.h,
                        ),
                        DefaultText(
                          title: widget.newAccount == false
                              ? "updateProfile".tr()
                              : AppStrings.createAccount.tr(),
                          size: 16.sp,
                          color: AppColors.boldText,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        _form(),
                        SizedBox(
                          height: 8.h,
                        ),
                        _registerButton()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _form() {
    return Form(
        key: formKey,
        child: Column(
          children: [
            _id(),
            SizedBox(
              height: 2.h,
            ),
            _email(),
            SizedBox(
              height: 2.h,
            ),
            widget.newAccount==false?
            Container():
            _phoneNumber(),
            SizedBox(
              height: 2.h,
            ),
            widget.newAccount==false?
                Container():
            _password(),
            SizedBox(
              height: 2.h,
            ),
            widget.newAccount==false?
            SizedBox(height: 10.h,):
            _rePassword(),
          ],
        ));
  }

  Widget _id() {
    return InputField(
      hint: AppStrings.id.tr(),
      controller: idController,
      keyboardType: TextInputType.phone,
      validated: (String value) {
        if (value.trim().isEmpty) {
          return AppStrings.enterId.tr();
        } else {
          return null;
        }
      },
      onchange: (v) {},
    );
  }

  Widget _email() {
    return InputField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      hint: AppStrings.email.tr(),
      validated: (String value) {
        if ( value.isEmpty || !value.contains('@') || !value.contains('.')) {
          return "validEmail".tr();
        } else {
          return null;
        }
      },
      onchange: (v) {},
    );
  }

  Widget _phoneNumber() {
    return InputField(
      controller: phoneNumberController,
      keyboardType: TextInputType.phone,
      hint: AppStrings.mobile.tr(),
      validated: (String value) {
        if (value.trim().isEmpty) {
          return AppStrings.enterMobileNumber.tr();
        } else if(value.length<10){
          return "wrongPhone".tr();
          }     else{
            return null;
        }

      },
      onchange: (value) {},
    );
  }

  Widget _password() {
    return InputField(
      secure: true,
      controller: passwordController,
      hint: AppStrings.password.tr(),
      validated: (String value) {
        if (value.trim().length < 6) {
          return AppStrings.enterPassword.tr();
        } else {
          return null;
        }
      },
      onchange: (v) {},
    );
  }

  Widget _rePassword() {
    return InputField(
      secure: true,
      controller: rePasswordController,
      hint: AppStrings.rePassword.tr(),
      validated: (String value) {
        if (value != passwordController.text) {
          return AppStrings.passwordDoesNotMatch.tr();
        } else {
          return null;
        }
      },
      onchange: (v) {},
    );
  }

  Widget _registerButton() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: AnimatedButton(
    isLoading: Provider.of<OtpViewModel>(context).isSendSmsLoading==true|| Provider.of<PersonalKnowledgeViewModel>(context).isSectorLoading==true?true:false,
    title: widget.newAccount==false?
        "continue".tr()
    :AppStrings.createAccount.tr(),
    onPressed: () {
      if(widget.newAccount==false){
        Provider.of<PersonalKnowledgeViewModel>(context, listen: false).getSectors(context,);
        Provider.of<PersonalKnowledgeViewModel>(context, listen: false).getCategories(context,);
        NavigationService.push(PersonalKnowledgeScreen(newAccount: widget.newAccount));
      }else{
        if (formKey.currentState!.validate()) {
          Provider.of<RegisterViewModel>(context, listen: false).national_num = idController.text;
          Provider.of<RegisterViewModel>(context, listen: false).email = emailController.text;
          Provider.of<RegisterViewModel>(context, listen: false).phone = phoneNumberController.text;
          Provider.of<RegisterViewModel>(context, listen: false).password = passwordController.text;
          Provider.of<OtpViewModel>(context, listen: false).sendSms(newAccount: widget.newAccount,phoneNumber: phoneNumberController.text,context: context).then((value) {
            Provider.of<PersonalKnowledgeViewModel>(context, listen: false).getSectors(context,);
            Provider.of<PersonalKnowledgeViewModel>(context, listen: false).getCategories(context,);
          }).catchError((onError){
            print(onError);
          });

        }

      }

    },
    fontWeight: FontWeight.w400,
    textSize: 18,
    textColor: Colors.white,
        ),
      );
  }



}
