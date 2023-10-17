
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech/data/repositries/ChatRepo.dart';
import 'package:speech/data/repositries/FavoriteRepo.dart';
import 'package:speech/data/repositries/ForgetPasswordRepo.dart';
import 'package:speech/data/repositries/InvestmentLibraryRepo.dart';
import 'package:speech/data/repositries/OrdersRepo.dart';
import 'package:speech/data/repositries/ProjectDetailsRepo.dart';
import 'package:speech/data/repositries/HomeRepo.dart';
import 'package:speech/data/repositries/SettingRepo.dart';
import 'package:speech/data/repositries/auth_repo.dart';
import 'package:speech/data/repositries/personal_knowledge_repo.dart';
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
import 'package:speech/presentation/screens/setting/setting_screens/ReportProblem/ReportProblemViewModel.dart';

import 'data/app_urls/app_url.dart';
import 'data/datasource/remote/dio/dio_client.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';
import 'data/repositries/ReportProblemRepo.dart';
import 'data/repositries/SaveUserData.dart';
final getIt = GetIt.instance;

Future<void> init() async {
  /// Core
   getIt.registerLazySingleton(() => DioClient(AppURL.kBaseURL, getIt(), loggingInterceptor: getIt(), sharedPreferences: getIt()));


  /// Providers
   getIt.registerLazySingleton(() =>LoginViewModel(authRepo: getIt(),saveUserData: getIt()));
   getIt.registerLazySingleton(() =>RegisterViewModel(authRepo: getIt(),saveUserData: getIt()));
   getIt.registerLazySingleton(() =>PersonalKnowledgeViewModel(personalKnowledgeRepo: getIt()));
   getIt.registerLazySingleton(() =>HomeViewModel(projectsRepo: getIt()));
   getIt.registerLazySingleton(() =>ProjectDetailsViewModel(projectDetailsRepo: getIt()));
   getIt.registerLazySingleton(() =>InvestmentLibraryViewModel(investmentLibraryRepo: getIt()));
   getIt.registerLazySingleton(() =>ReportProblemViewModel(reportProblemRepo: getIt()));
   getIt.registerLazySingleton(() =>SettingViewModel(settingRepo: getIt()));
   getIt.registerLazySingleton(() =>OrdersViewModel(ordersRepo: getIt()));
   getIt.registerLazySingleton(() =>FavoriteViewModel(favoriteRepo: getIt()));
   getIt.registerLazySingleton(() =>ChatViewModel(chatRepo: getIt()));
   getIt.registerLazySingleton(() =>OtpViewModel());
   getIt.registerLazySingleton(() =>ForgetPasswordViewModel(forgetPasswordRepo: getIt(),saveUserData: getIt()));
   getIt.registerLazySingleton(() =>HomeLayoutViewModel());


   /// Repository
   getIt.registerLazySingleton(() => AuthRepo(dioClient: getIt(), saveUserData: getIt()));
   getIt.registerLazySingleton(() => SaveUserData(sharedPreferences: getIt()));
   getIt.registerLazySingleton(() => PersonalKnowledgeRepo(dioClient: getIt()));
   getIt.registerLazySingleton(() => ProjectsRepo(dioClient: getIt(),saveUserData: getIt()));
   getIt.registerLazySingleton(() => ProjectDetailsRepo(dioClient: getIt(),saveUserData: getIt()));
   getIt.registerLazySingleton(() => InvestmentLibraryRepo(dioClient: getIt(),saveUserData: getIt()));
   getIt.registerLazySingleton(() => ReportProblemRepo(dioClient: getIt(),saveUserData: getIt()));
   getIt.registerLazySingleton(() => SettingRepo(dioClient: getIt(),saveUserData: getIt()));
   getIt.registerLazySingleton(() => OrdersRepo(dioClient: getIt(),saveUserData: getIt()));
   getIt.registerLazySingleton(() => FavoriteRepo(dioClient: getIt(),saveUserData: getIt()));
   getIt.registerLazySingleton(() => ChatRepo(dioClient: getIt(),saveUserData: getIt()));
   getIt.registerLazySingleton(() => ForgetPasswordRepo(dioClient: getIt(),saveUserData: getIt()));


   /// External
   final sharedPreferences = await SharedPreferences.getInstance();
   getIt.registerLazySingleton(() => sharedPreferences);
   getIt.registerLazySingleton(() => Dio());
    getIt.registerLazySingleton(() => LoggingInterceptor());
   // getIt.registerLazySingleton(() => Connectivity());
}
