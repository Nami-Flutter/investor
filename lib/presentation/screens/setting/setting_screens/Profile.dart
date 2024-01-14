import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:speech/core/config/app_colors.dart';
import 'package:speech/core/config/app_strings.dart';
import 'package:speech/core/routing/navigation_services.dart';
import 'package:speech/data/model/response/ProjectsModel.dart';
import '../../../../core/config/app_Images.dart';
import '../../../widgets/RoundedImage.dart';
import '../../../widgets/default_text.dart';

class Profile extends StatelessWidget {
   Profile({Key? key,required this.projectsModel,required this.index}) : super(key: key);

  ProjectsModel projectsModel;
  int index;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _stack(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 _name(name: projectsModel.data![index].businessPioneer!.name.toString()),
                 _address(address:  projectsModel.data![index].address.toString()),
                  SizedBox(
                    height: 1.h,
                  ),
               _end(experience:  projectsModel.data![index].businessPioneer!.experience.toString())
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _stack (){
    return   Stack(
      children: [
        Container(
          height: 33.h,
        ),
        Stack(
          children: [
            _appBar(),
            Positioned(
                top: 8.h,
                right: 3.w,
                child: Padding(
                  padding: EdgeInsets.only(left: 2.w),
                  child: Image.asset(AppImages.backGround2),
                ))
          ],
        ),
        _imageProfile()
      ],
    );
  }
  Widget _appBar(){
    return Container(
      alignment: Alignment.topCenter,
      height: 25.h,
      width: double.infinity,
      color: AppColors.primaryColor,
      // decoration: BoxDecoration(
      //     image: DecorationImage(
      //         fit: BoxFit.fill,
      //         image: AssetImage(
      //           AppImages.backGround,
      //         ))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                NavigationService.goBack();
              },
              icon: const Icon(
                Icons.arrow_back_outlined,
                color: Colors.white,
              )),
          Expanded(
              child: SvgPicture.asset(
                AppImages.logo,
                height: 6.h,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ))
        ],
      ),
    );
  }
  Widget _imageProfile(){
    return Positioned(
        top: 20.h,
        left: 0,
        right: 0,
        child: SizedBox(
          child:RoundedImage(
            imageUrl: projectsModel.data![index].businessPioneer!.image.toString(),
            error: projectsModel.data![index].businessPioneer!.image.toString()=="https://investor.ascit.sa/storage"|| projectsModel.data![index].businessPioneer!.image.toString()==""?true:false,
            whileError: AppImages.image,
            radius: 40,

          )
        )
    );
  }
  Widget _name ({required String name}){
    return  DefaultText(
        title: name,
        size: 28,
        fontWeight: FontWeight.w500,
        color: AppColors.primaryColor,
        maxLines: 1);
  }
  Widget _address ({required String address}){
    return  DefaultText(
        title:address,
        size: 14,
        color: AppColors.hintText,
        maxLines: 1);
  }
  Widget _end ({required String experience}){
    return    Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.white,
      ),
      child: DefaultText(
        title: experience,
        size: 14,
        color: AppColors.hintText,
        maxLines: 2,
      ),
    );
  }





}
