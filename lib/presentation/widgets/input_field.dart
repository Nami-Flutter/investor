import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/config/app_colors.dart';

class InputField extends StatefulWidget {
  String? label;
  String? hint;
  Widget? prefixIcon;
  IconData? suffixIcon;
  bool secure;
  @required
  Function validated;
  @required
  Function onchange;

  // @required Function onEditingComplete;
  // @required Function onFieldSubmitted;
  TextEditingController? controller;
  VoidCallback? onTap;
  Color borderColor;
  bool readonly;
  int? maxLines;
  TextInputType? keyboardType;
  String? initialValue;
  bool autoFocus;
  double radius;

  InputField(
      {Key? key,
      this.readonly = false,
      this.label,
      this.hint,
      this.prefixIcon,
      this.suffixIcon,
      this.secure = false,
      this.controller,
      required this.validated,
      this.onTap,
      this.keyboardType,
      this.maxLines = 1,
      this.initialValue,
      required this.onchange,
      // required this.onEditingComplete,
      // required this.onFieldSubmitted,
      this.borderColor = AppColors.hintText,
      this.autoFocus = false,
      this.radius = 10})
      : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool hidePassword = true;
  var eyeIcon = Icons.remove_red_eye;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // onTapOutside: (event) {
      //   FocusManager.instance.primaryFocus?.unfocus();
      // },
      // onFieldSubmitted: (value)=>widget.onFieldSubmitted(value),
      autofocus: widget.autoFocus,
      maxLength: widget.keyboardType == TextInputType.phone?10:null,
      // onEditingComplete: ()=>widget.onEditingComplete(),
      onChanged: (p) => widget.onchange(p),
      // autofocus: false,
      initialValue: widget.initialValue,
      maxLines: widget.maxLines,
      inputFormatters: <TextInputFormatter>[
        if (widget.keyboardType == TextInputType.phone)FilteringTextInputFormatter.digitsOnly,

      ],
      keyboardType: widget.keyboardType,
      readOnly: widget.readonly,
      onTap: widget.onTap,
      validator: (p) => widget.validated(p),
      controller: widget.controller,
      decoration: InputDecoration(
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: .5,
            color: widget.borderColor,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: .5),
          borderRadius: BorderRadius.circular(widget.radius),
        ),
        labelText: widget.label,
        // alignLabelWithHint: true,
        labelStyle: const TextStyle(),
        hintText: widget.hint,
        hintStyle: const TextStyle(
            color: Color(0xffB2B5BC),
            fontSize: 14,
            fontWeight: FontWeight.w400),
        prefixIcon: widget.prefixIcon,
        counterText: '',
        suffixIcon: widget.secure
            ? IconButton(
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                    eyeIcon = hidePassword
                        ? Icons.remove_red_eye
                        : Icons.remove_red_eye_outlined;
                  });
                },
                icon: Icon(eyeIcon),
              )
            : null,
      ),
      obscureText: widget.secure && hidePassword,
    );
  }
}
