import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:speech/core/config/app_colors.dart';
import 'package:speech/core/routing/navigation_services.dart';
import 'package:speech/presentation/widgets/default_text.dart';
import '../../../../core/config/app_Images.dart';

class LanguageScreen extends StatefulWidget {
  LanguageScreen({Key? key}) : super(key: key);
  bool checked = false;
  bool checked2 = false;

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: AppColors.primaryColor,
              alignment: Alignment.center,
              height: 8.h,
              width: double.infinity,
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
                        NavigationService.goBack();
                        // Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => HomeLayoutScreen(),),(route) => false,);
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
                        child:SvgPicture.asset(
                          color:Colors.white,
                          AppImages.logo,
                        ),
                    ),
                  ),
                  const Text("    "),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DefaultText(
                size: 17,
                title: tr("language"),
                fontWeight: FontWeight.w400,
                color: AppColors.normalText,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.only(
                    left: 5, right: 10, top: 5, bottom: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white),
                child: Row(
                  children: [
                    DefaultText(
                      title: "العربية",
                      size: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    const Expanded(child: SizedBox()),
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: Colors.blue,
                      value: widget.checked2 == true
                          ? widget.checked = false
                          : widget.checked,
                      shape: const CircleBorder(),
                      onChanged: (bool? value)  {
                        setState(() {
                          widget.checked = value!;
                          widget.checked2 = false;
                          context.setLocale(const Locale("ar"));
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.only(left: 5, right: 10, top: 5, bottom: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white),
                child: Row(
                  children: [
                    DefaultText(
                      title: "English",
                      size: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    const Expanded(child: SizedBox()),
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: Colors.blue,
                      value: widget.checked == true
                          ? widget.checked2 = false
                          : widget.checked2,
                      shape: const CircleBorder(),
                      onChanged: (bool? value) {
                     EasyLocalization.of(context)!.setLocale(Locale("en"));
                        widget.checked2 = value!;

                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
