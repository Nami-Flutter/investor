import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

snackBar({required context,required String message,required Color color}){
  ScaffoldMessenger.of(context).showSnackBar( SnackBar(
    duration: const Duration(seconds: 1),
    content: Text(message),
    backgroundColor: color,));
}