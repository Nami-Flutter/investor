import 'package:flutter/material.dart';
import 'package:speech/core/config/app_colors.dart';
import 'package:speech/presentation/widgets/default_text.dart';



class AnimatedButton extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final Color? backGroundColor;
  final Color? textColor;
  final Color? splashColor;
  final VoidCallback onPressed; // voidCallback = void Function()
  final String title;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;
  final double? elevation;
  final FontWeight? fontWeight;
   bool isLoading;
  final double? textSize;

   AnimatedButton(
      {Key? key,
        this.textColor = Colors.white,
         this.textSize=18,
        required this.onPressed,
        required this.title,
        this.width = double.infinity,
        this.backGroundColor = AppColors.primaryColor,
        this.radius = 8,
        this.splashColor,
        this.padding,
        this.height = 45,
        this.fontSize,
        this.fontWeight,
        this.elevation = 0,
        required this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: MaterialButton(
        padding: padding,
        elevation: elevation,
        splashColor: splashColor,
        color: backGroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius))),
        onPressed: onPressed,
        child:isLoading==true? const CircularProgressIndicator(color: Colors.white,strokeWidth: 2,):
        DefaultText(
          title:  title,
          maxLines: 1,
          color: textColor!,
          size: textSize!,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}