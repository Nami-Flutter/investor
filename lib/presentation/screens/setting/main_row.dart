import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:speech/presentation/widgets/SnackBar.dart';
import '../../../core/config/app_colors.dart';
import '../../../core/routing/navigation_services.dart';
import '../../widgets/default_text.dart';

class MainRow extends StatelessWidget {
   MainRow({Key? key,required this.title,required this.nextPage,this.noInternet=false }) : super(key: key);
String title;
Widget nextPage;
bool? noInternet;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
            highlightColor: Colors.transparent,
            onTap: (){
              if(noInternet==true){
                snackBar(context: context, message: "checkYourInternet".tr(), color: Colors.red);
              }else{
                NavigationService.push(nextPage);
              }
            },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.only(bottom: 1.h),
            child:Row(
                  children: [
                    DefaultText(
                      title: title,
                      size: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.normalText,
                    ),
                    const Expanded(child: SizedBox()),
                  const Icon(Icons.arrow_forward_ios_sharp,size: 15,opticalSize: .1,),
                  ],
            ),
          ),
        ),
        const Divider(thickness: .3,),
      ],
    );
  }
}
