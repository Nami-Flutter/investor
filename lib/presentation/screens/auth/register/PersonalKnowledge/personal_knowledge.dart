import 'dart:io';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:speech/core/config/app_Images.dart';
import 'package:speech/core/config/app_colors.dart';
import 'package:speech/core/config/app_strings.dart';
import 'package:sizer/sizer.dart';
import 'package:speech/core/routing/navigation_services.dart';
import 'package:speech/presentation/screens/auth/register/PersonalKnowledge/personal_knowledge_view_model.dart';
import 'package:speech/presentation/screens/auth/register/Register/register_view_model.dart';
import 'package:speech/presentation/widgets/AnimatedButton.dart';
import 'package:speech/presentation/widgets/default_text.dart';
import 'package:speech/presentation/widgets/input_field.dart';
import '../../../../widgets/logo_container.dart';
import '../../../setting/SettingViewModel.dart';

class PersonalKnowledgeScreen extends StatefulWidget {
   PersonalKnowledgeScreen({Key? key,required this.newAccount}) : super(key: key);

   bool newAccount;

  @override
  State<PersonalKnowledgeScreen> createState() =>
      _PersonalKnowledgeScreenState();
}

class _PersonalKnowledgeScreenState extends State<PersonalKnowledgeScreen> {
  @override
  void dispose() {
    _cnt1.dispose();
    _cnt2.dispose();
    super.dispose();
  }



  ImagePicker picker = ImagePicker();

  var userNameController = TextEditingController();

  var nationalityController = TextEditingController();

  var backGroundController = TextEditingController();

  var selectPreferController = TextEditingController();

  var selectSalaryController = TextEditingController();

  var _cnt1 = SingleValueDropDownController();
  var _cnt2 = SingleValueDropDownController();


  @override
  void initState() {
    if(widget.newAccount==false){
      userNameController.text=Provider.of<SettingViewModel>(context,listen: false).userModel.data!.name.toString();
      nationalityController.text=Provider.of<SettingViewModel>(context,listen: false).userModel.data!.nationalty.toString();
      backGroundController.text=Provider.of<SettingViewModel>(context,listen: false).userModel.data!.experience.toString();
    }
    // TODO: implement initState

    super.initState();
    Provider.of<PersonalKnowledgeViewModel>(context, listen: false).getSectors(context,);
    Provider.of<PersonalKnowledgeViewModel>(context, listen: false).getCategories(context,);


  }



  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    return Consumer<PersonalKnowledgeViewModel>(builder:(context, value, child) =>
        Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: AppColors.primaryColor,statusBarIconBrightness: Brightness.light),
          ),

          body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: 34.h,
                  ),
                  LogoContainer(
                    ctx: context,
                    height: 26.h,
                    arrowBack: true,
                  ),
               Provider.of<RegisterViewModel>(context).c == "0"
                      ? Positioned(
                          top: 19.h,
                          left: 0,
                          right: 0,
                          child: SizedBox(
                              height: 26.w,
                              child:const CircleAvatar(
                                child: Icon(Icons.person),
                              )
                          ))
                      : Positioned(
                          top: 20.h,
                          child: CircleAvatar(
                            radius: 13.w,
                            backgroundImage: FileImage(File( Provider.of<RegisterViewModel>(context).imagePath)),
                          ),
                        ),
                  Positioned(
                      top: 26.5.h,
                      right: 35.w,
                      child: CircleAvatar(
                        radius: 20,
                        child: IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(30))),
                                  barrierColor: Colors.black45,
                                  context: context,
                                  builder: (context) => _bottomSheet());
                            },
                            icon: const Icon(Icons.camera_alt)),
                      )),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultText(
                        title:"personalInformation".tr(),
                        size: 16.sp,
                        color: AppColors.boldText,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      _form(data: value),
                      SizedBox(
                        height: 5.h,
                      ),
                      _button()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _bottomSheet() {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8))),
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                NavigationService.goBack();
                Provider.of<RegisterViewModel>(context,listen: false).pickImage(pickType: "camera");
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.camera_alt,
                      size: 20.w, color: AppColors.primaryColor),
                  DefaultText(
                    title: AppStrings.camera.tr(),
                    size: 22,
                    color: AppColors.normalText,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                NavigationService.goBack();
                Provider.of<RegisterViewModel>(context,listen: false).pickImage(pickType: "gallery");
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.camera, size: 20.w, color: AppColors.primaryColor),
                  DefaultText(
                    title: AppStrings.gallery.tr(),
                    size: 22,
                    color: AppColors.normalText,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _form({required var data}) {
    return Form(
        key: formKey,
        child: Column(
          children: [
            _userName(),
            SizedBox(
              height: 2.h,
            ),
            _nationality(),
            SizedBox(
              height: 2.h,
            ),
            _backGround(),
            SizedBox(
              height: 2.h,
            ),
            _sectors(data),
            SizedBox(
              height: 2.h,
            ),
            _categories(data),

          ],
        ));
  }


  Widget _userName(){
    return   InputField(
      hint: AppStrings.userName.tr(),
      controller: userNameController,
      keyboardType: TextInputType.name,
      validated: (String value) {
        if (value.trim().isEmpty) {
          return AppStrings.enterUserName.tr();
        } else {
          return null;
        }
      },
      onchange: (value) {},
    );
  }
  Widget _nationality(){
    return InputField(
      hint: "nationality".tr(),
      controller: nationalityController,
      keyboardType: TextInputType.text,
      validated: (String value) {
        if (value.trim().isEmpty) {
          return AppStrings.nationality.tr();
        } else {
          return null;
        }
      },
      onchange: (value) {},
    );
  }
  Widget _backGround(){
    return InputField(
      hint: AppStrings.yourAcademicAndBusinessBackground.tr(),
      controller: backGroundController,
      keyboardType: TextInputType.text,
      validated: (String value) {
        if (value.trim().isEmpty) {
          return AppStrings.enterYourAcademicAndBusinessBackground.tr();
        } else {
          return null;
        }
      },
      onchange: (value) {},
    );
  }
  Widget _sectors(data){
    return DropDownTextField(
      textFieldDecoration: InputDecoration(
          hintText: "choseSectors".tr(),
          hintStyle:
          const TextStyle(fontSize: 14, color: AppColors.hintText),
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
      dropDownList: data.sectorList,
      onChanged: (val) {
        Provider.of<RegisterViewModel>(context,listen: false).categoriesId=_cnt1.dropDownValue!.value;
      },
    );
  }
  Widget _categories(data){
    return  DropDownTextField(
      textFieldDecoration: InputDecoration(
          hintText: "choseCategories".tr(),
          hintStyle:
          const TextStyle(fontSize: 14, color: AppColors.hintText),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10))),
      controller: _cnt2,
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
      dropDownItemCount:  3,
      dropDownList:
      data.categoriesList,
      onChanged: (val) {

        Provider.of<RegisterViewModel>(context,listen: false).sectorId=_cnt2.dropDownValue!.value;
      },
    );
  }

  Widget _button(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: AnimatedButton(
        isLoading:   Provider.of<RegisterViewModel>(context, listen: false).isLoading,
        title: "confirm".tr(),
        onPressed: () {
          if (formKey.currentState!.validate()) {

            widget.newAccount==false?
            Provider.of<RegisterViewModel>(context,
                listen: false)
                .updateProfile(
              context:  context,
              nationality: nationalityController.text,
              name: userNameController.text,
              experience: backGroundController.text,
            )
            :
            Provider.of<RegisterViewModel>(context,
                listen: false)
                .registerApi(
              context:  context,
              nationality: nationalityController.text,
              name: userNameController.text,
              experience: backGroundController.text,
            );
          }
        },
        fontWeight: FontWeight.w500,
        backGroundColor: const Color(0xff3E8CAB),
        textSize: 14.sp,
        textColor: Colors.white,
      ),
    );
  }


}
