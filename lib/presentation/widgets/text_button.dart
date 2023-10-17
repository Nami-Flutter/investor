import 'package:flutter/material.dart';

class ButtonText extends StatelessWidget {
  VoidCallback onPress;
  String title;
  Color textColor;
  double textSize;

  ButtonText({Key? key, required this.onPress, required this.title,required this.textColor,required this.textSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style:
            ButtonStyle(
              // fixedSize: MaterialStatePropertyAll(Size.zero),
              tapTargetSize:MaterialTapTargetSize.shrinkWrap,
              alignment: Alignment.center,
              foregroundColor: MaterialStatePropertyAll(textColor),
                ),
        onPressed: onPress,
        child: Text(title,style: TextStyle(fontSize: textSize),));
  }
}
