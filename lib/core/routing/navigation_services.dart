import 'package:flutter/material.dart';

import '../../main.dart';

class NavigationService {

  static void push(Widget page) async {

     await Navigator.of(navigationKey.currentContext!).push(
         PageRouteBuilder(
       pageBuilder: (context, animation, secondaryAnimation) => page,
       transitionsBuilder: (context, animation, secondaryAnimation, child) {
         const begin = Offset(0.0, 1.0);
         const end = Offset.zero;
         const curve = Curves.ease;

         var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

         return SlideTransition(
           position: animation.drive(tween),
           child: child,
         );
       },
     ));
  }

  static void pushReplacement(Widget page) async {
     await Navigator.of(navigationKey.currentContext!).pushReplacement(MaterialPageRoute(builder: (_)=> page));

  }

  static void pushAndRemoveUntil(Widget page) async {
     await Navigator.of(navigationKey.currentContext!).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=> page), (route) => false);
  }

  static dynamic goBack([Object? result]) {
    return Navigator.pop(navigationKey.currentContext!, result);
  }
}
