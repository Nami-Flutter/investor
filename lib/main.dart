import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'app.dart';
import 'injection.dart';


final navigationKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  await init();
  runApp(Sizer(
    builder: (ctx, orientation, deviceType) =>
    EasyLocalization(
      supportedLocales: const [Locale('ar'),Locale('en'),],
      path: 'assets/localizations',
      useOnlyLangCode: true,
      startLocale: const Locale("ar"),
      saveLocale: true,
      fallbackLocale: const Locale('ar'),
      child:  const MyApp(),
    ),
  ));
}

