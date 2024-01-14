import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:speech/core/config/app_colors.dart';
import 'package:speech/core/config/app_strings.dart';
import 'package:speech/data/model/response/InvestmentLibraryModel.dart';
import '../../../../../core/config/app_Images.dart';
import '../../../../widgets/AnimatedButton.dart';
import '../../../../widgets/ShowAnimationDialog.dart';
import '../../../../widgets/default_text.dart';
import '../../../../widgets/input_field.dart';
import 'InvestmentLibraryViewModel.dart';

class InvestmentLibrary extends StatefulWidget {
  const InvestmentLibrary({Key? key}) : super(key: key);

  @override
  State<InvestmentLibrary> createState() => _InvestmentLibraryState();
}

class _InvestmentLibraryState extends State<InvestmentLibrary> {
  @override
  void initState() {
    Provider.of<InvestmentLibraryViewModel>(context, listen: false)
        .getInvestmentLibraries(context);
    // TODO: implement initState
    super.initState();
  }

  TextEditingController nameController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<InvestmentLibraryViewModel>(
        builder: (context, value, child) => Scaffold(
          body: Column(
            children: [
              _appBar(context),
              _constText(),
              _listView(investmentLibraryModel: value.investmentLibraryModel),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar(context) {
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
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_outlined,
                color: Colors.white,
              )),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              // width: 3.w,
              height: 6.h,
              child: SvgPicture.asset(
                AppImages.logo,
                color: Colors.white,
              ),
            ),
          ),
         IconButton(onPressed: (){}, icon: const Icon(Icons.add),color: Colors.transparent,)
        ],
      ),
    );
  }

  Widget _constText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Row(
        children: [
          DefaultText(
            size: 14,
            title: AppStrings.investmentLibrary.tr(),
            fontWeight: FontWeight.w400,
          )
        ],
      ),
    );
  }

  Widget _listView({required InvestmentLibraryModel investmentLibraryModel}) {
    return Expanded(
      child: ListView.separated(
        itemCount: investmentLibraryModel.data!.length,
        separatorBuilder: (context, index) => SizedBox(
          height: 1.h,
        ),
        itemBuilder: (context, index) => _investmentRow(investmentLibraryModel, index),
      ),
    );
  }

  Widget _investmentRow(InvestmentLibraryModel investmentLibraryModel, int index) {
    return GestureDetector(
      onTap: () {
        // Provider.of<InvestmentLibraryViewModel>(
            // context, listen: false).downloadAttach(url:
            // investmentLibraryModel.data![index].attach
            //     .toString());
        showAnimationDialog(
            context: context,
            title: "downloadFile".tr(),
            message: "areYouSure".tr(),
            needButtons: true,
            needRichText: false,
            buttons: Column(
              children: [
                InputField(
                  controller: nameController,
                  validated: (v){},
                  onchange: (v){},
                  hint: "enterName".tr(),
                ),
                SizedBox(height: 2.h,),

                Consumer<InvestmentLibraryViewModel>(
                  builder: (context, value, child) =>
                   AnimatedButton(
                    isLoading: value.isDownloadLoading,
                    title:"save".tr() ,
                    onPressed: (){
                      Provider.of<InvestmentLibraryViewModel>(context,listen: false).downloadAttach(context: context,url: investmentLibraryModel.data![index].attach.toString(),name:nameController.text);
                    },
                    backGroundColor: AppColors.primaryColor,
                    textColor: AppColors.whiteColor,
                  ),
                )
              ],
            )
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey.withOpacity(0.1),
          ),
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
          child: Row(
            children: [
              Image.asset(AppImages.pdfIcon),
              SizedBox(
                width: 1.w,
              ),
              Text(
                investmentLibraryModel.data![index].name.toString(),
                style: TextStyle(color: Color(0xff2F3135)),
              ),
              const Expanded(child: SizedBox()),
              Image.asset(
                AppImages.downloadIcon,
              ),
            ],
          ),
        ),
      ),
    );
  }

   _downloadFileDialog({required attach}){
    showAnimationDialog(
        context: context,
        title: "downloadFile".tr(),
        message: "areYouSure".tr(),
        needButtons: true,
        needRichText: false,
        buttons: Column(
          children: [
            InputField(
              controller: nameController,
              validated: (v){},
              onchange: (v){},
              hint: "enterName".tr(),
            ),
            SizedBox(height: 2.h,),

            AnimatedButton(
              isLoading: false,
              title:"save".tr() ,
              onPressed: (){
                Provider.of<InvestmentLibraryViewModel>(context,listen: false).downloadAttach(context: context,url:attach,name:nameController.text);
              },
              backGroundColor: AppColors.primaryColor,
              textColor: AppColors.whiteColor, textSize: null,
            )
          ],
        )
    );
  }

}
