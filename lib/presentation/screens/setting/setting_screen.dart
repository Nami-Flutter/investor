import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:speech/core/routing/navigation_services.dart';
import 'package:speech/data/model/response/UserModel.dart';
import 'package:speech/data/repositries/SaveUserData.dart';
import 'package:speech/presentation/screens/auth/register/Register/register_screen.dart';
import 'package:speech/presentation/screens/setting/SettingViewModel.dart';
import 'package:speech/presentation/screens/setting/setting_screens/InvestmentLibrary/InvestmentLibraryScreen.dart';
import 'package:speech/presentation/screens/setting/setting_screens/language_screen.dart';
import 'package:speech/presentation/screens/setting/setting_screens/ReportProblem/report_problem_screen.dart';
import 'package:speech/presentation/screens/setting/setting_screens/whoAreWe_Screen.dart';
import 'package:speech/presentation/widgets/RoundedImage.dart';
import 'package:speech/presentation/widgets/main_button.dart';
import '../../../core/config/app_Images.dart';
import '../../../core/config/app_colors.dart';
import '../../../core/config/app_strings.dart';
import '../../../injection.dart';
import '../../widgets/ShowAnimationDialog.dart';
import '../../widgets/default_text.dart';
import '../../widgets/text_button.dart';
import 'main_row.dart';

class SettingScreen extends StatefulWidget {
   SettingScreen({Key? key}) : super(key: key);
  SaveUserData saveUserData=getIt();

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<SettingViewModel>(
        builder: (context, value, child) =>
            SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            _appBar(),
            SizedBox(
              height: 2.h,
            ),

            _imageProfile(value.userModel),
            SizedBox(
              height: 1.h,
            ),
             _name(value.userModel),
            Divider(
              indent: 6.w,
              endIndent: 6.w,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 3.h,
                  ),
                  DefaultText(
                    title: "setting".tr(),
                    size: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  Divider(
                    endIndent: 78.w,
                    color: Colors.blue,
                    thickness: 2,
                    height: 0,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  MainRow(
                      noInternet:value.userModel.data==null?true:false ,
                      title: AppStrings.accountSetting.tr(),
                      nextPage: RegisterScreen (newAccount: false,)),
                  MainRow(
                      title: AppStrings.problem.tr(),
                      nextPage: const ReportProblemScreen()),
                  MainRow(
                      title: AppStrings.language.tr(), nextPage: LanguageScreen()),
                  SizedBox(
                    height: 4.h,
                  ),
                  DefaultText(
                    title: AppStrings.general.tr(),
                    size: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  Divider(
                    endIndent: Localizations.localeOf(context).languageCode == 'en'
                        ? 78.w
                        : 85.w,
                    color: Colors.blue,
                    thickness: 2,
                    height: 0,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  MainRow(
                      title: AppStrings.whoAreWe.tr(), nextPage: const WhoAreWeScreen()),
                  MainRow(
                      title: AppStrings.investmentLibrary.tr(),
                      nextPage: const InvestmentLibrary()),
                ],
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            _logoutButton()
          ]),
            ),
      ),
    );
  }

  Widget _appBar() {
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
      child: SizedBox(
        // width: 3.w,
        height: 6.h,
        child: SvgPicture.asset(
          AppImages.logo,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _imageProfile(UserModel userModel) {
    return  Provider.of<SettingViewModel>(context).isLoading==true?
        const CircularProgressIndicator()
    :
    userModel.data==null?
        const CircleAvatar(
          radius: 40,
        ):
    RoundedImage(
        imageUrl: userModel.data!.image.toString(),
      error: userModel.data!.image.toString()=="https://investor.ascit.sa/storage"||userModel.data!.image.toString()==""||userModel.data==null?true:false,
      whileError: AppImages.image,
      radius: 40,

    );
  }

  Widget _name(UserModel userModel) {
    return DefaultText(
      title:userModel.data==null?"...": userModel.data!.name.toString()!=""? userModel.data!.name.toString():"",
      size: 14,
      fontWeight: FontWeight.w400,
    );
  }

  Widget _logoutButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: MainButton(
        title: AppStrings.logout.tr(),
        onPressed: ()  {
           showAnimationDialog(context: context,buttons:_rowButtonsDialog(),message: "areYouSure".tr(),title: "logout".tr());
        },
        fontWeight: FontWeight.w500,
        color: AppColors.primaryColor,
        textSize: 10.sp,
        textColor: Colors.white,
      ),
    );
  }

  Widget _rowButtonsDialog(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        _cancelButton(),
        _confirmButton()
      ],
    );
  }

  Widget _cancelButton(){
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(7),
      child: ButtonText(
        textSize: 10.sp,
        textColor:AppColors.whiteColor ,
        title: "cancel".tr() ,
        onPress: (){
          NavigationService.goBack();
        },
      ),
    ) ;
  }

  Widget _confirmButton(){
    return Container(
      decoration: BoxDecoration(
        color:AppColors.primaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(7),
      child: ButtonText(
        textSize: 10.sp,
        textColor:AppColors.whiteColor ,
        title: "confirm".tr() ,
        onPress: (){
          Provider.of<SettingViewModel>(context,listen: false).logout(context);
          widget.saveUserData.saveLoggedIn(false);
        },
      ),
    ) ;
  }

}
