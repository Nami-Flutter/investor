import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:speech/core/config/app_strings.dart';
import 'package:speech/core/routing/navigation_services.dart';
import 'package:speech/data/model/response/ProjectsModel.dart';
import 'package:speech/presentation/screens/home/Payment/pay_screen.dart';
import 'package:speech/presentation/screens/home/projectDetails/AddInvestmentOrderViewModel.dart';
import 'package:speech/presentation/screens/setting/setting_screens/InvestmentLibrary/InvestmentLibraryViewModel.dart';
import 'package:speech/presentation/screens/setting/setting_screens/Profile.dart';
import 'package:speech/presentation/widgets/AnimatedButton.dart';
import 'package:speech/presentation/widgets/RoundedImage.dart';
import 'package:speech/presentation/widgets/default_text.dart';
import 'package:speech/presentation/widgets/input_field.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/config/app_Images.dart';
import '../../../../core/config/app_colors.dart';
import '../../../widgets/ShowAnimationDialog.dart';
import '../../../widgets/main_button.dart';
import '../../../widgets/text_button.dart';
import '../../setting/setting_screens/InvestmentLibrary/InvestmentLibraryViewModel.dart';

class ProjectsDetails extends StatefulWidget {
   ProjectsDetails({Key? key,required this.projectsModel,required this.index}) : super(key: key);

  ProjectsModel projectsModel;
  int index;

  @override
  State<ProjectsDetails> createState() => _ProjectsDetailsState();
}

class _ProjectsDetailsState extends State<ProjectsDetails> {

  String projectName = "ملف المشروع";

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    return SafeArea(
      child: Consumer<ProjectDetailsViewModel>(
        builder: (context, data, child) =>
         Scaffold(
          key: scaffoldKey,
          body: Column(
            children: [
              _stackedPhoto(sectorKind:widget.projectsModel.data![widget.index].sector!.title.toString()),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 7,),
                          _projectNameRow(companyName:widget.projectsModel.data![widget.index].name.toString(), profits:widget.projectsModel.data![widget.index].profits.toString()),
                          SizedBox(height: 7,),
                          _projectDescription(projectDescription:widget.projectsModel.data![widget.index].details.toString()),
                          _link(location: false,imageIcon: AppImages.linkIcon, link:widget.projectsModel.data![widget.index].website.toString()),
                          _link(imageIcon: AppImages.locationIcon, link:widget.projectsModel.data![widget.index].address.toString()),

                          const Divider(),
                          SizedBox(height: 1.h,),
                          _showProfileContainer(name:widget.projectsModel.data![widget.index].businessPioneer!.name.toString(), image: AppImages.picture),
                          const Divider(),

                          _title(title: "partnersAndContracts".tr()),
                          _sections(
                                  title: "numberOfFoundingPartners:".tr(),
                                  hint: widget.projectsModel.data![widget.index].partners_num.toString(),
                                  imageIcon: AppImages.peopleIcon),
                          _sections(
                                  title: "namesOfFoundingPartners:".tr(),
                                  hint: widget.projectsModel.data![widget.index].partners_name.toString(),
                                  imageIcon: AppImages.peopleIcon),
                          _sections(
                                  title: "contractsAndMemorandumsOfUnderstanding:".tr(),
                                  hint:widget.projectsModel.data![widget.index].contracs.toString(),
                                  imageIcon: AppImages.peopleIcon),
                          const Divider(),
                          SizedBox(height: 1.h,),

                          _title(title: AppStrings.generalVisionOfTheProject.tr()),
                         _sections(
                                  title: "theProblemThatTheProjectSeeksToSolve:".tr(),
                                  hint: widget.projectsModel.data![widget.index].problem_solve.toString(),
                                  imageIcon: AppImages.peopleIcon),
                          _sections(
                                  title: "howDoesTheProjectSolveThisProblem:".tr(),
                                  hint: widget.projectsModel.data![widget.index].how_solve.toString(),
                                  imageIcon: AppImages.peopleIcon),
                          _sections(
                                  title: "competitiveAdvantageOfTheProject:".tr(),
                                  hint: widget.projectsModel.data![widget.index].feature.toString(),
                                  imageIcon: AppImages.peopleIcon),
                          _sections(
                                  title: "targetMarketSize:".tr(),
                                  hint: widget.projectsModel.data![widget.index].market_size.toString(),
                                  imageIcon: AppImages.peopleIcon),
                          _sections(
                                  title: "listOfCompetitors:".tr(),
                                  hint: widget.projectsModel.data![widget.index].rivals.toString(),
                                  imageIcon: AppImages.peopleIcon),
                          const Divider(),
                          SizedBox(
                            height: 1.h,
                          ),
                          _title(title: AppStrings.financialPerformanceAndFinancing.tr()),
                          _sections(
                                title: "dateOfInceptionOfTheProject:".tr(),
                                hint:widget.projectsModel.data![widget.index].build_up_date.toString(),
                                imageIcon: AppImages.peopleIcon),
                          _sections(
                                title: "projectProfitsSinceItsLaunch:".tr(),
                                hint: widget.projectsModel.data![widget.index].profits.toString(),
                                imageIcon: AppImages.peopleIcon),
                          _sections(
                                title: "projectExpensesAndCostsSinceItsLaunch:".tr(),
                                hint: widget.projectsModel.data![widget.index].expenses.toString(),
                                imageIcon: AppImages.peopleIcon),
                          _sections(
                                title: "mechanismForFinancingProjectExpensesAndCosts:".tr(),
                                hint: widget.projectsModel.data![widget.index].financing.toString(),
                                imageIcon: AppImages.peopleIcon),
                          const Divider(),
                          SizedBox(
                            height: 1.h,
                          ),
                          _title(title: AppStrings.offeredInvestmentOpportunity.tr()),
                          _sections(
                                title: "typeOfTourOffered:".tr(),
                                hint: widget.projectsModel.data![widget.index].investmentTour!.title.toString(),
                                imageIcon: AppImages.peopleIcon),
                          _sections(
                                title: "requiredInvestmentAmount:".tr(),
                                hint: widget.projectsModel.data![widget.index].categories!.title.toString(),
                                imageIcon: AppImages.peopleIcon),
                          _sections(
                                title: "percentageOfferedByTheCompany:".tr(),
                                hint: widget.projectsModel.data![widget.index].partnership_ratio.toString(),
                                imageIcon: AppImages.peopleIcon),

                          const Divider(),
                          SizedBox(
                            height: 1.h,
                          ),
                          DefaultText(
                            title:"documents".tr(),
                            size: 14,
                            color: AppColors.normalText,
                            maxLines: 6,
                            fontWeight: FontWeight.w400,
                          ),


                          _projectFile(),

                          SizedBox(
                            height: 10.h,
                          ),
                          _button(business_pioneer_id:widget.projectsModel.data![widget.index].business_pioneer_id!.toInt() ,project_id:widget.projectsModel.data![widget.index].id!.toInt() ),
                          SizedBox(
                            height: 7.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  Widget _stackedPhoto({required String sectorKind}) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: 23.h,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                AppImages.backGround,
              ))),
      child: Column(
        children: [
         _appBar(),
          const Expanded(child: SizedBox()),
          Row(
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
                  size: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _appBar(){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
              size: 15.sp,
            )),
        // Expanded(
        //     child: SvgPicture.asset(
        //       AppImages.logo,
        //       height: 2.5.h,
        //     )),
        IconButton(onPressed: (){}, icon: const Icon(Icons.add),color: Colors.transparent,)
      ],
    );
  }

  Widget _projectNameRow({required String companyName,required String profits}){
    return Row(
      children: [
        DefaultText(
          title: companyName,
          size: 15,
          fontWeight: FontWeight.w500,
        ),
        const Expanded(child: SizedBox()),
        DefaultText(
          title: "$profits \$",
          size: 14,
          color: Color(0xffE28B2A),
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }

  Widget _projectDescription({required String projectDescription}){
    return  DefaultText(
      title:projectDescription,
      size: 14,
      color: AppColors.normalText,
      maxLines: 6,
      fontWeight: FontWeight.w400,
    );
  }

  Widget _link({required String imageIcon,required String link,bool location =true}){
    return Row(
      children: [
        Image.asset(imageIcon),
        ButtonText(
          onPress: () {
            if(location==false){
              _launchUrl(url: link);
            }
          },
          title:link,
          textColor: AppColors.primaryColor,
          textSize: 13,
        )
      ],
    );
  }

  Widget _showProfileContainer({required String name,required String image}){
    return  Row(
      children: [
    RoundedImage(
    imageUrl:image,
    error: widget.projectsModel.data![widget.index].businessPioneer!.image=="https://investor.ascit.sa/storage"||widget.projectsModel.data![widget.index].businessPioneer!.image==""?true:false,
    whileError: AppImages.image,
    radius: 6.w,

    ),
        SizedBox(
          width: 2.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultText(
              title:name,
              size: 14,
              color: AppColors.boldText,
              maxLines: 6,
              fontWeight: FontWeight.w500,
            ),
            ButtonText(
              onPress: () {
                NavigationService.push(Profile(projectsModel: widget.projectsModel, index: widget.index));
              },
              title: "showProfile".tr(),
              textColor: AppColors.primaryColor,
              textSize: 13,
            )
          ],
        )
      ],
    );
  }

  Widget _title({required String title}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultText(
          title:title,
          size: 14,
          color: AppColors.normalText,
          maxLines: 6,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(
          height: 1.h,
        ),
        Divider(
          endIndent: 82.w,
          color: AppColors.primaryColor,
          thickness: 2,
          height: 8,
        ),
        SizedBox(
          height: 1.5.h,
        ),
      ],
    );
  }

  Widget _sections(
      {
      required String title,
      required String hint,
      required String imageIcon,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    flex: 1,
                    child: Image.asset(imageIcon)),
                SizedBox(
                  width: 2.w,
                ),
                Expanded(
                  flex: 10,
                  child: RichText(
                    maxLines: 10,
                    text:  TextSpan(
                      text: "$title \n",
                      style: const TextStyle(fontSize: 15,fontFamily: "DG Trika",fontWeight: FontWeight.w400,color: AppColors.normalText),
                      children: <TextSpan>[
                        TextSpan(
                            text:hint,
                            style:const  TextStyle(fontSize: 13,color:AppColors.hintText,fontWeight: FontWeight.w400 ,fontFamily: "DG Trika",)),
                      ],
                    ),
                  ),
                ),
              ],
      ),
    );
  }

  Widget _projectFile(){
    return  Container(
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xffF3F3F3),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(
        onTap: () {
          _downloadFileDialog();
           },
        child: Row(
          children: [
            Image.asset(AppImages.pdfIcon),
            SizedBox(width: 2.w),
            DefaultText(
              title: projectName,
              size: 13,
              maxLines: 6,
              fontWeight: FontWeight.w400,
            ),
            const Expanded(child: SizedBox()),
            Image.asset(AppImages.downloadIcon),
          ],
        ),
      ),
    );
  }

  TextEditingController nameController=TextEditingController();


   _downloadFileDialog(){
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
                Provider.of<InvestmentLibraryViewModel>(context,listen: false).downloadAttach(context: context,url:widget.projectsModel.data![widget.index].attachment.toString(),name:nameController.text);
              },
              backGroundColor: AppColors.primaryColor,
              textColor: AppColors.whiteColor,
            ),
          )
        ],
      )
    );
  }

  _showBottomSheet({required context ,required int business_pioneer_id,required int project_id}) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(8), topLeft: Radius.circular(8)),
          color: Colors.white),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 2.h,
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.centerRight,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.hintText,
              child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          RichText(
            maxLines: 10,
            text: const TextSpan(
              text: 'يرجى ملاحظة ، ',
              style: TextStyle(fontSize: 18, color: AppColors.boldText,fontFamily: "DG Trika",fontWeight: FontWeight.w400,wordSpacing: 2),
              children: <TextSpan>[
                TextSpan(
                    text:
                        ' أنه يجب دفع رسوم بقيمة 100 دولار عند تقديم طلب الاستثمار ، وسيتم خصمها في حال تم الرد على الطلب .',
                    style: TextStyle(fontSize: 14,color:AppColors.normalText,fontWeight: FontWeight.w400 ,fontFamily: "DG Trika",height: 1.5)),
              ],
            ),
          ),
          SizedBox(
            height: 9.h,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: MainButton(
              title: AppStrings.confirmRequest.tr(),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PayScreen(business_pioneer_id:business_pioneer_id ,project_id: project_id),
                    ));
              },
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
              textSize: 14.sp,
              textColor: Colors.white,
            ),
          ),
          SizedBox(
            height: 5.h,
          )
        ],
      ),
    );
  }

  Widget _button({required int business_pioneer_id,required int project_id}){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: MainButton(
        title: AppStrings.investmentRequest.tr(),
        onPressed: () {
          showModalBottomSheet(
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
              context: context,
              builder: (context) => _showBottomSheet(context:context,project_id:project_id ,business_pioneer_id: business_pioneer_id),
              barrierColor: Colors.black45);
        },
        fontWeight: FontWeight.w500,
        color: AppColors.primaryColor,
        textSize: 10.sp,
        textColor: Colors.white,
      ),
    );
  }
}


Future<void> _launchUrl({required  url}) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}