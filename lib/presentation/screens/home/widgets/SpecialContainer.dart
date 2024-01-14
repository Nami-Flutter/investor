import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:speech/core/config/app_Images.dart';
import 'package:speech/core/config/app_colors.dart';
import 'package:speech/core/config/app_strings.dart';
import 'package:speech/data/model/response/ProjectsModel.dart';
import 'package:speech/presentation/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/RoundedImage.dart';
import '../Home/HomeViewModel.dart';
class FavContainer extends StatelessWidget {
   FavContainer({Key? key,required this.specialProjectsModel,required this.index}) : super(key: key);

   ProjectsModel specialProjectsModel;
   int index;

  @override
  Widget build(BuildContext context) {
    return Card(
       elevation: .2,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: 67.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultText(title: AppStrings.specialProjects.tr(), size: 14,color: const Color(0xffE39236),fontWeight: FontWeight.w500,),
            Row(
              children: [
             _imageProfile(context),
                SizedBox(width: 1.w,),
                DefaultText(title:specialProjectsModel.data![index].businessPioneer!.name.toString() , size: 14,fontWeight: FontWeight.w400,color: AppColors.boldText,)
              ],
            ),
            Row(
              children: [
                SizedBox(width: 5.w,),
                Image.asset(AppImages.bg,height: 10.h,width: 55.w,fit: BoxFit.fitWidth,),
              ],
            ),
          ],
        ),
      ),
    );
  }


   Widget _imageProfile(context) {
      return
     // Provider.of<HomeViewModel>(context).isLoading==true?
     // const CircularProgressIndicator()
     //     :
     specialProjectsModel.data==null?
     const CircleAvatar(
       radius: 12,
     ):
     RoundedImage(
       imageUrl: specialProjectsModel.data![index].businessPioneer!.image.toString(),
       error:  specialProjectsModel.data![index].businessPioneer!.image.toString()=="https://investor.ascit.sa/storage"|| specialProjectsModel.data![index].businessPioneer!.image.toString()==""|| specialProjectsModel.data==null?true:false,
       whileError: AppImages.image,
       radius: 13,

     );
   }
}
