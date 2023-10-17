import 'package:dropdown_textfield/dropdown_textfield.dart';
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
import '../../../../widgets/AnimatedButton.dart';
import '../../../../widgets/input_field.dart';
import '../../../../widgets/main_button.dart';

class ReportProblemScreen extends StatefulWidget {
  const ReportProblemScreen({Key? key}) : super(key: key);

  @override
  State<ReportProblemScreen> createState() => _ReportProblemScreenState();
}

class _ReportProblemScreenState extends State<ReportProblemScreen> {
  var _cnt1 = SingleValueDropDownController();

  var detailsController=TextEditingController();


  @override
  void initState() {
    Provider.of<ReportProblemViewModel>(context,listen: false).getProblems(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _cnt1.dispose();
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
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: DefaultText(
                    title:
                        "notHappy".tr(),
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
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                AppImages.backGround,
              ))),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_outlined,
                color: Colors.white,
              )),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              // width: 3.w,
              height: 2.5.h,
              child: SvgPicture.asset(
                AppImages.logo,
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
              DropDownTextField(
                textFieldDecoration: InputDecoration(
                    hintText: AppStrings.chooseTheTypeOfProblem.tr(),
                    hintStyle: const TextStyle(
                        fontSize: 14, color: AppColors.hintText),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                controller: _cnt1,
                clearOption: true,
                searchDecoration:
                    const InputDecoration(iconColor: AppColors.primaryColor),
                validator: (String? value) {
                  if (value!.isEmpty){
                    return "requiredField".tr();
                  } else {
                    return null;
                  }
                },
                dropDownItemCount: 2,
                dropDownList:
                    Provider.of<ReportProblemViewModel>(context).problemsList,
                onChanged: (value) {
                  Provider.of<ReportProblemViewModel>(context, listen: false)
                          .problem_id =_cnt1.dropDownValue!.value;
                },

              ),
              SizedBox(
            height: 3.h,
          ),
          InputField(
            keyboardType: TextInputType.name,
            controller: detailsController,
            hint: AppStrings.howCanWeImproveOurService.tr(),
              validated: (String value) {
                if (value.trim().isEmpty) {
                  return "pleaseEnterYourOpinion".tr();
                } else {
                  return null;
                }
            },
            onchange: (value) {
              Provider.of<ReportProblemViewModel>(context,listen: false).details=value;
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
          isLoading:Provider.of<ReportProblemViewModel>(context,listen: false).isProblemReportedLoading ,
          title: AppStrings.reportProblem.tr(),
          onPressed: () {
            if(formKey.currentState!.validate()){
              Provider.of<ReportProblemViewModel>(context,listen: false).reportProblems( context);
            }
          },
          fontWeight: FontWeight.w400,
          backGroundColor: AppColors.primaryColor,
          textSize: 18,
          textColor: Colors.white,
        ),
      ),
    );
 }

}
