import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:speech/core/config/app_colors.dart';
import 'package:speech/core/config/app_strings.dart';
import 'package:sizer/sizer.dart';
import 'package:speech/core/routing/navigation_services.dart';
import 'package:speech/data/repositries/SaveUserData.dart';
import 'package:speech/injection.dart';
import 'package:speech/presentation/screens/auth/ForgetPassword/SendEmail.dart';
import 'package:speech/presentation/screens/auth/register/Register/register_screen.dart';
import 'package:speech/presentation/widgets/AnimatedButton.dart';
import 'package:speech/presentation/widgets/input_field.dart';
import '../../../widgets/logo_container.dart';
import '../../../widgets/default_text.dart';
import '../../../widgets/text_button.dart';
import 'logInViewModel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  SaveUserData saveUserData = getIt();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool checked = false;

  @override
  void initState() {
    if (saveUserData.getRememberMe() == true) {
      emailController.text = saveUserData.getUserEmail();
      passwordController.text = saveUserData.getUserPassword();
    }

    // TODO: implement initState
    super.initState();
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LogoContainer(
            height: 31.h,
            arrowBack: false,
            ctx: context,
          ),
          SizedBox(
            height: 2.5.h,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultText(
                      title: AppStrings.login.tr(),
                      size: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.boldText,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    _form(),
                    _forgetPasswordRow(),
                    SizedBox(
                      height: 8.h,
                    ),

                    // _loginButton(),
                    _loginButton(),

                    SizedBox(
                      height: 7.h,
                    ),
                    _registerTextButton()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _form() {
    return Form(
        key: formKey,
        child: Column(
          children: [
            InputField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              borderColor: AppColors.hintText,
              hint: AppStrings.email.tr(),
              validated: (String value) {
                if (value.isEmpty ||
                    !value.contains('@') ||
                    !value.contains('.')) {
                  return "validEmail".tr();
                } else {
                  return null;
                }
              },
              onchange: (value) {},
            ),
            SizedBox(
              height: 3.h,
            ),
            InputField(
              secure: true,
              keyboardType: TextInputType.name,
              controller: passwordController,
              hint: AppStrings.password.tr(),
              validated: (String value) {
                if (value.trim().isEmpty) {
                  return AppStrings.enterPassword.tr();
                } else {
                  return null;
                }
              },
              onchange: (value) {},
            ),
          ],
        ));
  }

  Widget _forgetPasswordRow() {
    return Row(
      children: [_rememberMe(), _forgetPassword()],
    );
  }

  Widget _rememberMe() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
              checkColor: Colors.white,
              activeColor: Colors.blue,
              value:
                  Provider.of<LoginViewModel>(context, listen: false).checked,
              shape: const CircleBorder(),
              onChanged: (bool? value) {
                Provider.of<LoginViewModel>(context, listen: false)
                    .changeChecked(check: value!);
              }),
          DefaultText(
            color: AppColors.normalText,
            title: AppStrings.remember.tr(),
            fontWeight: FontWeight.w200,
            size: 6.5.sp,
          ),
        ],
      ),
    );
  }

  Widget _forgetPassword() {
    return ButtonText(
      onPress: () {
        NavigationService.push(const SendEmail());
      },
      title: AppStrings.forget.tr(),
      textColor: AppColors.normalText,
      textSize: 7.5.sp,
    );
  }

  Widget _loginButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: AnimatedButton(
        isLoading: Provider.of<LoginViewModel>(context).isLoading,
        title: AppStrings.login.tr(),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            Provider.of<LoginViewModel>(context, listen: false)
                .login(emailController.text, passwordController.text, context);
          }else{
            return;
          }
        },
        fontWeight: FontWeight.w500,
        textColor: Colors.white,
      ),
    );
  }

  Widget _registerTextButton(){
    return  Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: ButtonText(
        textSize: 12.sp,
        textColor: AppColors.boldText,
        onPress: () {
          NavigationService.push(RegisterScreen());
        },
        title: AppStrings.createAccount.tr(),
      ),
    );
  }
}
