import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:speech/core/config/app_colors.dart';
import 'package:speech/presentation/screens/setting/setting_screens/ReportProblem/ReportProblemViewModel.dart';
import 'package:speech/presentation/widgets/default_text.dart';

import '../../../../../core/config/app_Images.dart';
import '../../../../../core/config/app_strings.dart';
import '../../../widgets/AnimatedButton.dart';
import '../../../widgets/input_field.dart';
import 'XForgetViewModel.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({Key? key}) : super(key: key);

  @override
  State<NewPassword> createState() => _NewPassword();
}

class _NewPassword extends State<NewPassword> {


  var passwordController=TextEditingController();
  var rePasswordController=TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<ReportProblemViewModel>(
        builder:(context, value, child) =>  Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                _appBar(),

                SizedBox(
                  height: 7.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: DefaultText(
                    title:
                    AppStrings.forget.tr(),
                    size: 14,
                    fontWeight: FontWeight.w400,
                    maxLines: 4,
                    color: AppColors.normalText,
                  ),
                ),
                SizedBox(height: 2.h,),

                _form(),

                SizedBox(
                  height: 10.h,
                ),

                _button()

              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _appBar(){
    return Container(
      alignment: Alignment.center,
      height: 8.h,
      width: double.infinity,
      color: AppColors.primaryColor,
      // decoration: BoxDecoration(
      //     image: DecorationImage(
      //         fit: BoxFit.fill,
      //         image: AssetImage(
      //           AppImages.backGround,
      //         ))),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_outlined,
                color: Colors.white,
              )),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              // width: 3.w,
              height: 6.h,
              child: SvgPicture.asset(
                AppImages.logo,
                color: Colors.white,
              ),
            ),
          ),
          IconButton(icon: const Icon(Icons.add,color: Colors.transparent),onPressed: (){}),
        ],
      ),
    );
  }

  Widget _form(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Form(
          key: formKey,
          child: Column(
            children: [
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
                    return AppStrings.enterEmail.tr();
                  } else {
                    return null;
                  }
                },
                onchange: (value) {
                },
              ),
              SizedBox(height: 3.h,),
              InputField(
                secure: true,
                keyboardType: TextInputType.name,
                controller: rePasswordController,
                hint: AppStrings.rePassword.tr(),
                validated: (String value) {
                  if (value!=passwordController.text) {
                    return "passwordDoesNotMatch".tr();
                  } else {
                    return null;
                  }
                },
                onchange: (value) {
                },
              ),
            ],
          )),
    );
  }

  Widget _button(){
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 7.w),
        child: AnimatedButton(
          isLoading:Provider.of<ForgetPasswordViewModel>(context).isNewPassLoading ,
          title: "confirm".tr(),
          onPressed: () {
            if(formKey.currentState!.validate()){
              Provider.of<ForgetPasswordViewModel>(context,listen: false).newPassword(context: context, password: passwordController.text);
            }
          },
          fontWeight: FontWeight.w400,
          backGroundColor: AppColors.primaryColor,
          textSize: 14,
          textColor: Colors.white,
        ),
      ),
    );
  }

}
