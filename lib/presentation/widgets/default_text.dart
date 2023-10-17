import 'package:flutter/material.dart';

class DefaultText extends StatelessWidget {
   DefaultText({Key? key,required this.title,required this.size,this.fontWeight=FontWeight.w500,this.color=Colors.black,this.maxLines=1,this.align}) : super(key: key);
  double size;
  String title;
  FontWeight? fontWeight;
  Color? color;
  int? maxLines;
   TextAlign? align;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: align,
      style: TextStyle(
        fontFamily: "DIN Next LT W23",
        // decoration:
        // TextDecoration.underline,
        // decorationColor: Colors.blue,
        // decorationThickness: 3,
        // decorationStyle: TextDecorationStyle.solid,
        fontSize: size,
        fontWeight:fontWeight,
        color: color,
      ),
      maxLines: maxLines,
    );
  }
}
