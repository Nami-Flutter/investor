import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:speech/core/config/app_colors.dart';
import 'package:speech/presentation/screens/setting/main_row.dart';
import 'package:speech/presentation/widgets/appbar.dart';
import 'package:sizer/sizer.dart';

import '../../../core/config/app_Images.dart';
import '../../../core/config/app_strings.dart';
import '../../../core/routing/navigation_services.dart';
import '../../widgets/default_text.dart';
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> titles=[AppStrings.investmentRequestHasBeenSent.tr(),AppStrings.investmentRequestHasBeenAnswered.tr(),AppStrings.creditCardAdded.tr(),AppStrings.investmentApplicationFeeHasBeenDeducted.tr(),AppStrings.congratulationsAnInvestmentTransactionHasSeenCompletedSuccessfully.tr(),];

    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              CustomAppBar(
                  prefixIcon: IconButton(
                      onPressed: () {
                        NavigationService.goBack();
                      },
                      icon: Icon(Icons.arrow_back),color: AppColors.normalText,iconSize: 20.sp,splashRadius:10.sp),
                  suffixIcon: Text("     ")),

              SizedBox(height: 4.h,),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Row(
                  children: [
                    DefaultText(
                      title: AppStrings.notifications.tr(),
                      size: 28,
                      fontWeight: FontWeight.w500,
                    ),
                    Expanded(child: SizedBox()),
                    Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: InkWell(
                            child: Image.asset(AppImages.filterIcon))),
                  ],
                ),
              ),
              SizedBox(height: 3.h,),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.h),
                child: SizedBox(
                  height: 50.h,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(thickness: .2,),
                    itemCount: titles.length,
                    itemBuilder: (context, index) =>_MainRow(context,title:titles[index] ),),
                ),

              )


            ],
          ),
        ),
      ),
    );
  }


  Widget _MainRow(context,{required String title}){

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultText(
                maxLines: 10,
                title: title,
                size:Localizations.localeOf(context).languageCode=='en'? 9:16,
                fontWeight: FontWeight.w400,
                color: AppColors.normalText,
              ),
              DefaultText(
                maxLines: 10,
                title: title,
                size:Localizations.localeOf(context).languageCode=='en'? 8:14,
                fontWeight: FontWeight.w400,
                color: AppColors.hintText,
              ),
            ],
          ),
          const Expanded(child: SizedBox()),
          const Icon(Icons.arrow_forward_ios_sharp,size: 15,opticalSize: .1,color: AppColors.normalText,),
        ],
      ),
    );


  }




}
