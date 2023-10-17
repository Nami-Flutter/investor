import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech/core/config/app_Images.dart';
import 'package:speech/core/config/app_colors.dart';
import 'package:speech/core/routing/navigation_services.dart';
import 'package:speech/data/model/response/ProjectsModel.dart';
import 'package:speech/presentation/screens/favorite/FavoriteViewModel.dart';
import 'package:speech/presentation/screens/home/Home/HomeViewModel.dart';
import 'package:speech/presentation/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/RoundedImage.dart';
import '../projectDetails/ProjectDetails.dart';

class AllProjectsContainer extends StatefulWidget {
  AllProjectsContainer(
      {Key? key, required this.index, required this.allProjects})
      : super(key: key);
  int index;
  ProjectsModel allProjects;

  @override
  State<AllProjectsContainer> createState() => _AllProjectsContainerState();
}

class _AllProjectsContainerState extends State<AllProjectsContainer> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: .5,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            _abbBar(widget.allProjects.data![widget.index].id, widget.index),
            SizedBox(
              height: 1.h,
            ),
            GestureDetector(
              onTap: () {
                NavigationService.push(ProjectsDetails(
                    index: widget.index, projectsModel: widget.allProjects));
              },
              child: Column(
                children: [
                  _stackedPhoto(
                      sectorKind: widget
                          .allProjects.data![widget.index].sector!.title
                          .toString()),
                  SizedBox(
                    height: 1.h,
                  ),
                  _projectName(),
                  SizedBox(
                    height: 1.h,
                  ),
                  _projectDetails(),
                  _tourKindAndExpectedPrice()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _abbBar(projectId, index) {
    return Row(
      children: [
        _imageProfile(),
        SizedBox(
          width: 1.h,
        ),
        DefaultText(
          title: widget.allProjects.data![widget.index].businessPioneer!.name
              .toString(),
          size: 18,
          fontWeight: FontWeight.w800,
          color: Colors.black,
        ),
        const Expanded(child: SizedBox()),
        GestureDetector(
            onTap: () {
              Provider.of<FavoriteViewModel>(context, listen: false)
                  .addFavoriteProject(projectId: projectId, context: context);
            },
            child: Image.asset(
              widget.allProjects.data![index].is_favourite == 0
                  ? AppImages.loveIcon
                  : AppImages.prefeareIcon,
            ))
      ],
    );
  }

  Widget _imageProfile() {
    return  RoundedImage(
                imageUrl: widget
                    .allProjects.data![widget.index].businessPioneer!.image
                    .toString(),
                error: widget.allProjects.data![widget.index].businessPioneer!
                                .image
                                .toString() ==
                            "https://investor.ascit.sa/storage" ||
                        widget.allProjects.data![widget.index].businessPioneer!
                                .image
                                .toString() ==
                            ""
                    ? true
                    : false,
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

  Widget _projectName() {
    return Row(
      children: [
        DefaultText(
          title: widget.allProjects.data![widget.index].name.toString(),
          size: 18,
          fontWeight: FontWeight.w500,
        ),
        const Expanded(child: SizedBox()),
        DefaultText(
          title: widget.allProjects.data![widget.index].address.toString(),
          size: 13,
          fontWeight: FontWeight.w400,
          color: AppColors.hintText,
        ),
      ],
    );
  }

  Widget _projectDetails() {
    return DefaultText(
      title: widget.allProjects.data![widget.index].details.toString(),
      size: 16,
      fontWeight: FontWeight.w400,
      maxLines: 10,
      color: AppColors.normalText,
    );
  }

  Widget _tourKindAndExpectedPrice() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(AppImages.moneyIcon),
        SizedBox(
          width: 1.w,
        ),
        DefaultText(
          title: "${widget.allProjects.data![widget.index].profits}\$",
          size: 16,
          fontWeight: FontWeight.w500,
          color: const Color(0xffE78F2C),
          align: TextAlign.end,
        ),
        const Expanded(child: SizedBox()),
        Image.asset(AppImages.kindIcon),
        SizedBox(
          width: 1.w,
        ),
        DefaultText(
          title: widget.allProjects.data![widget.index].investmentTour!.title
              .toString(),
          size: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryColor,
        ),
      ],
    );
  }
}
