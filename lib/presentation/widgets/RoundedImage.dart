import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RoundedImage extends StatelessWidget {
  RoundedImage(
      {Key? key,
      required this.imageUrl,
      this.radius,
      this.color,
      this.width,
      this.height,
      this.error,
      this.whileError})
      : super(key: key);

  String? whileError;
  String imageUrl;
  double? radius=13.w;
  double? height;
  double? width;
  Color? color;
  bool? error = true;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      child: error == true
          ? Icon(
        Icons.person,
              color: color,
            )
          : CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(
          imageUrl,
        ),
          ),
    );
  }
}
