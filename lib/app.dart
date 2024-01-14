import 'package:easy_localization/easy_localization.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:speech/presentation/screens/splash_screen.dart';
import 'package:speech/GenerateMultiProviders.dart';

import 'main.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key, }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GenerateMultiProvider(
      child: MaterialApp(
        theme: ThemeData(
            fontFamily: "DG Trika"
        ),
        debugShowCheckedModeBanner: false,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
        navigatorKey: navigationKey,
        home: const SplashScreen(),
      ),
    );
  }
}