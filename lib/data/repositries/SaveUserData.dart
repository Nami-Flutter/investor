import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech/presentation/screens/splash_screen.dart';
import '../../core/routing/navigation_services.dart';
import '../../core/utils/app_constants.dart';

class SaveUserData {
  final SharedPreferences sharedPreferences;
  SaveUserData({required this.sharedPreferences});

  /// save SharedData
  Future<void> saveUserId(String userId) async {
    // dioClient.updateHeader(token, "null");
    try {
      await sharedPreferences.setString(AppConstants.userId, userId);
    } catch (e) {
      throw e;
    }
  }
  Future<void> saveUserToken(String userTOKEN) async {
    try {
      await sharedPreferences.setString(AppConstants.userTOKEN, userTOKEN);
    } catch (e) {
      throw e;
    }
  }
  Future<void> saveUserName(String userName) async {
    try {
      await sharedPreferences.setString(AppConstants.userName, userName);
    } catch (e) {
      throw e;
    }
  }
  Future<void> saveUserPhone(String userPhone) async {
    try {
      await sharedPreferences.setString(AppConstants.userPhone, userPhone);
    } catch (e) {
      throw e;
    }
  }
  Future<void> saveUserPassword(String password) async {
    try {
      await sharedPreferences.setString(AppConstants.password, password);
    } catch (e) {
      throw e;
    }
  }
  Future<void> saveRememberMe(bool rememberMe) async {
    try {
      await sharedPreferences.setBool(AppConstants.rememberMe, rememberMe);
    } catch (e) {
      throw e;
    }
  }
  Future<void> saveUserEmail(String userEmail) async {
    try {
      await sharedPreferences.setString(AppConstants.userEmail, userEmail);
    } catch (e) {
      throw e;
    }
  }

   Future<void> saveLoggedIn(bool loggedIn) async {
    try {
      await sharedPreferences.setBool(AppConstants.loggedIn, loggedIn);
    } catch (e) {
      throw e;
    }
  }



  ///get SharedData
  String getUserId() {
    return sharedPreferences.getString(AppConstants.userId) ?? "";
  }
  String getUserToken() {
    return sharedPreferences.getString(AppConstants.userTOKEN) ?? "";
  }
  String getUserName() {
    return sharedPreferences.getString(AppConstants.userName) ?? "";
  }
  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.userId);
  }
  String getUserPhone() {
    return sharedPreferences.getString(AppConstants.userPhone) ?? "";
  }
  String getUserEmail() {
    return sharedPreferences.getString(AppConstants.userEmail) ?? "";
  }
  String getUserPassword() {
    return sharedPreferences.getString(AppConstants.password) ?? "";
  }
  bool getRememberMe() {
    return sharedPreferences.getBool(AppConstants.rememberMe) ?? false;
  }
  bool getLoggedIn(){
    return sharedPreferences.getBool(AppConstants.loggedIn) ?? false;

  }
  ///clear SharedData
  Future<bool> clearSharedData() async {
    await sharedPreferences.remove(AppConstants.userName);
    await sharedPreferences.remove(AppConstants.userId);
    await sharedPreferences.remove(AppConstants.userTOKEN);
    await sharedPreferences.remove(AppConstants.userEmail);
    await sharedPreferences.remove(AppConstants.userPhone);
    await sharedPreferences.remove(AppConstants.userCompanyName);
    await sharedPreferences.remove(AppConstants.firebaseToken);

    NavigationService.pushAndRemoveUntil(const SplashScreen());
    return true;
  }

}
