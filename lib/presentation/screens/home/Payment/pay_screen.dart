import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech/core/config/app_colors.dart';
import 'package:sizer/sizer.dart';
import 'package:speech/presentation/widgets/AnimatedButton.dart';
import '../../../../core/config/app_Images.dart';
import '../../../../core/config/app_strings.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/default_text.dart';
import '../../../widgets/input_field.dart';
import '../../../widgets/main_button.dart';
import '../investment_success_screen.dart';
import '../projectDetails/AddInvestmentOrderViewModel.dart';


class PayScreen extends StatefulWidget {
   PayScreen({Key? key,required this.project_id,required this.business_pioneer_id}) : super(key: key);

   int business_pioneer_id;
   int project_id;


  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {


  bool payWay1=true;
  bool payWay2=false;

  @override
  Widget build(BuildContext context) {
    print(payWay1);
    print(payWay2);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(
                prefixIcon: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon:const Icon(Icons.arrow_back),color: AppColors.normalText, ),
                suffixIcon: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 17,
                    child: IconButton(
                        onPressed: () {
                        },
                        icon:
                        ImageIcon(AssetImage(AppImages.notificationIcon)),color: Colors.white,)),
              ),

              SizedBox(height: 8.h,),
              _payWayRow(checked: payWay1,title:AppStrings.creditCard.tr() ,image1:AppImages.masterCard ,image2:AppImages.visa ),
              SizedBox(height: 2.h,),
              _payWayRow(checked: !payWay1,title:AppStrings.otherPaymentMethods.tr(),image1:AppImages.googlePay ,image2:AppImages.paypal ),
              SizedBox(height: 7.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: SizedBox(
                  height: 6.h,
                  child: InputField(
                      borderColor: AppColors.hintText,
                      hint: AppStrings.theNameOfTheCardHolder.tr(),
                      validated: (value) {},
                      onchange: (value) {},
                      ),
                ),
              ),
              SizedBox(height: 3.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: SizedBox(
                  height: 6.h,
                  child: InputField(
                      borderColor: AppColors.hintText,
                      hint: AppStrings.cardNumber.tr(),
                      validated: (value) {},
                      onchange: (value) {},
                      ),
                ),
              ),
              SizedBox(height: 3.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Row(
                  children: [
                    Expanded(
                        child:  SizedBox(
                          height: 6.h,
                          child: InputField(
                              borderColor: AppColors.hintText,
                              hint: AppStrings.cardDate.tr(),
                              validated: (value) {},
                              onchange: (value) {},
                             ),
                        ),
                    ),
                    SizedBox(width: 8.w,),
                    Expanded(
                        child:  SizedBox(
                          height: 6.h,
                          child: InputField(
                              borderColor: AppColors.hintText,
                              hint: AppStrings.securityCode.tr(),
                              validated: (value) {},
                              onchange: (value) {},
                             ),
                        ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h,),
              Row(
                children: [
                  Checkbox(

                    checkColor: Colors.white,
                    activeColor: Colors.blue,
                    value: true,
                    onChanged: (bool? value) async{
                    },
                  ),
                  DefaultText(title: AppStrings.saveCardInformation.tr(), size: 18,fontWeight: FontWeight.w400,color: AppColors.normalText,)
                ],
              ),
              SizedBox(height: 13.h,),
              _button()
            ],
          ),
        ),
      ),
    );
  }



  Widget _payWayRow({required bool checked ,required String title,required String image1,required String image2,}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(

          checkColor: Colors.white,
          activeColor: Colors.blue,
          value: checked,
          shape: const CircleBorder(),
          onChanged: (bool? value) async{
            payWay1=!payWay1;
              setState(() {

              });
          },
        ),
        DefaultText(
          title:title ,
          size:20 ,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(width:6.w),
        Image.asset(image1),
        SizedBox(width:8.w),
        Image.asset(image2),

      ],
    );
  }

  Widget _button(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: AnimatedButton(
        isLoading: Provider.of<ProjectDetailsViewModel>(context).isLoading,
        title: AppStrings.sendInvestmentRequest.tr(),
        onPressed: () {
          Provider.of<ProjectDetailsViewModel>(context,listen: false).addInvestmentRequest(business_pioneer_id:widget.business_pioneer_id, project_id:widget.project_id, context: context);
        },
        fontWeight: FontWeight.w500,
        backGroundColor: AppColors.primaryColor,
        textSize: 14.sp,
        textColor: Colors.white,
      ),
    );
  }
}
