import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech/core/config/app_Images.dart';
import 'package:speech/core/config/app_colors.dart';
import 'package:speech/core/config/app_strings.dart';
import 'package:speech/data/model/response/ProjectsModel.dart';
import 'package:speech/presentation/widgets/default_text.dart';
import 'package:sizer/sizer.dart';
import '../../widgets/RoundedImage.dart';
import '../home/Home/HomeViewModel.dart';
import '../home/projectDetails/ProjectDetails.dart';
import 'FavoriteViewModel.dart';

class FavoriteContainer extends StatefulWidget {
   FavoriteContainer({Key? key,required this.favouriteProjectsModel,required this.index}) : super(key: key);

  ProjectsModel favouriteProjectsModel;
  int index;

  @override
  State<FavoriteContainer> createState() => _FavoriteContainerState();
}

class _FavoriteContainerState extends State<FavoriteContainer> {

  bool isPref=true;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(10),
      child:Column(
        children: [
          _appBar(),
          GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  ProjectsDetails(projectsModel: widget.favouriteProjectsModel,index: widget.index),
                  ));
            },
            child: Column(
              children: [
                SizedBox(height: 1.h,),
                _stackedPhoto(sectorKind:widget.favouriteProjectsModel.data![widget.index].sector!.title.toString()),
                SizedBox(height: 1.h,),

                _projectAndAddressName(projectName:widget.favouriteProjectsModel.data![widget.index].name.toString(), address: widget.favouriteProjectsModel.data![widget.index].address.toString()),

                SizedBox(height: 1.h,),

                DefaultText(title: widget.favouriteProjectsModel.data![widget.index].details.toString(), size: 16,fontWeight: FontWeight.w400,maxLines: 3,color: AppColors.normalText,),

                _investmentKindAndSalary(salary: "25", investmentKind: widget.favouriteProjectsModel.data![widget.index].investmentTour!.title.toString())
              ],
            ),
          )

        ],
      ),
    );
  }

  Widget _appBar(){
    return  Row(
      children: [
        _imageProfile(),
        SizedBox(width: 1.h,),
        _name(name:widget.favouriteProjectsModel.data![widget.index].businessPioneer!.name.toString()),
        const Expanded(child: SizedBox()),
        _likeIcon()
      ],
    );
  }

  Widget _imageProfile() {
    return
    RoundedImage(
      imageUrl: widget.favouriteProjectsModel.data![widget.index].businessPioneer!.image.toString(),
      error:  widget.favouriteProjectsModel.data![widget.index].businessPioneer!.image.toString()=="https://investor.ascit.sa/storage"|| widget.favouriteProjectsModel.data![widget.index].businessPioneer!.image.toString()==""|| widget.favouriteProjectsModel.data==null?true:false,
      whileError: AppImages.image,
      radius: 20,

    );
  }

  Widget _stackedPhoto({required String sectorKind}) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: 15.h,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                AppImages.backGround,
              ))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.all(3),
            child: Image.asset(
              AppImages.backGround2,
              height: 10.h,
            ),
          ),
          Expanded(child: SizedBox()),
          Padding(
            padding: EdgeInsets.all(10),
            child: DefaultText(
              title: sectorKind,
              size: 20,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }




  Widget _name({required String name}){
   return DefaultText(title:name, size: 18,fontWeight: FontWeight.w800,color: Colors.black,);
  }


  Widget _likeIcon(){
   return GestureDetector(
       onTap: (){
         Provider.of<FavoriteViewModel>(context,listen: false).addFavoriteProject(projectId:widget.favouriteProjectsModel.data![widget.index].id!.toInt(), context: context);
       },
       child: Image.asset(AppImages.prefeareIcon));
  }


  Widget _projectAndAddressName({required String projectName,required String address}){
   return Row(
     children: [
       DefaultText(title:projectName , size: 18,fontWeight: FontWeight.w500,),
       const Expanded(child: SizedBox()),
       DefaultText(title:address, size: 13,fontWeight: FontWeight.w400,color: AppColors.hintText,),
     ],
   );
  }


  Widget _investmentKindAndSalary({required String salary,required String investmentKind}){
   return  Row(
     children: [
       Image.asset(AppImages.moneyIcon),
       const SizedBox(width: 15,),
       DefaultText(title: "$salary \$", size: 16,fontWeight: FontWeight.w500,color: const Color(0xffE78F2C),),
       const Expanded(child: SizedBox()),
       Image.asset(AppImages.kindIcon),
       const SizedBox(width: 15,),
       DefaultText(title: investmentKind, size: 16,fontWeight: FontWeight.w500,color:AppColors.primaryColor,),
     ],
   );
  }



}
