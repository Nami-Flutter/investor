import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgPhoto extends StatelessWidget {
  SvgPhoto(
      {Key? key, required this.photoUrl,required this.boxFit, this.height, this.width, this.color})
      : super(key: key);

  String photoUrl;
  double? height;
  double? width;
  Color? color;
  BoxFit boxFit;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      photoUrl,
      height: height,
      width: width,
      color: color,
      fit: boxFit,
    );
  }
}
