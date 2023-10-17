import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speech/core/config/app_colors.dart';
import 'package:speech/core/config/app_strings.dart';
import 'package:speech/presentation/screens/home_layout/home_layout_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:speech/presentation/widgets/default_text.dart';
import '../../../core/config/app_Images.dart';
import '../../widgets/main_button.dart';
class InvestmentSuccess extends StatelessWidget {
  const InvestmentSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20,),
            Container(
              child: SvgPicture.asset(AppImages.splashLogo),),

            const Expanded(
                flex: 2,
                child: SizedBox()),

            Image.asset(AppImages.success),
            SizedBox(height: 2.h,),
            DefaultText(title: AppStrings.yourRequestHasBeenSentSuccessfully.tr(), size: 26,fontWeight: FontWeight.w400,color: AppColors.normalText,maxLines: 10,),
             SizedBox(height: 12.h,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.15),
              child: MainButton(
                onPressed: ()async{
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeLayoutScreen()));
                },
                title: AppStrings.home.tr(),
                color: const Color(0xff3E8CAB),
                textColor: Colors.white,
              ),
            ),
            const Expanded(
                flex: 3,
                child: SizedBox())

          ],
        ) ,
      ),
    );
  }
}