import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:speech/data/repositries/ForgetPasswordRepo.dart';
import 'package:speech/presentation/screens/auth/ForgetPassword/XForgetViewModel.dart';
import 'package:speech/presentation/screens/auth/login/logInViewModel.dart';
import 'package:speech/presentation/screens/auth/register/Otp/OtpViewModel.dart';
import 'package:speech/presentation/screens/auth/register/PersonalKnowledge/personal_knowledge_view_model.dart';
import 'package:speech/presentation/screens/auth/register/Register/register_view_model.dart';
import 'package:speech/presentation/screens/favorite/FavoriteViewModel.dart';
import 'package:speech/presentation/screens/home/Home/HomeViewModel.dart';
import 'package:speech/presentation/screens/home/projectDetails/AddInvestmentOrderViewModel.dart';
import 'package:speech/presentation/screens/home_layout/HomeLayOutViewModel.dart';
import 'package:speech/presentation/screens/orders_chat/OrdersViewModel.dart';
import 'package:speech/presentation/screens/orders_chat/chat_screens/ChatViewModel.dart';
import 'package:speech/presentation/screens/setting/SettingViewModel.dart';
import 'package:speech/presentation/screens/setting/setting_screens/InvestmentLibrary/InvestmentLibraryViewModel.dart';
import 'package:speech/presentation/screens/setting/setting_screens/InvestmentLibrary/InvestmentLibraryViewModel.dart';
import 'package:speech/presentation/screens/setting/setting_screens/ReportProblem/ReportProblemViewModel.dart';
import 'injection.dart';

class GenerateMultiProvider extends StatelessWidget {
  final Widget child;

  const GenerateMultiProvider({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => getIt<LocalAuthProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<LoginViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<RegisterViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<PersonalKnowledgeViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<HomeViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<FavoriteViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<ProjectDetailsViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<OrdersViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<InvestmentLibraryViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<ReportProblemViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<SettingViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<ChatViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<OtpViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<ForgetPasswordViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<HomeLayoutViewModel>()),




      ],
      child: child,
    );
  }
}
