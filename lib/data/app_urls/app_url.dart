class AppURL {

  static const String kBaseURL = "https://investor.ascit.sa/api/";

  ///Auth  \\ Register  //logout // profile
  static const String kLoginURI = "investor/auth/login";
  static const String kRegisterURI = "investor/auth/register";
  static const String kSectorURI = "investor/auth/sectors";
  static const String kCategoryURI = "investor/auth/categories";
  static const String kLogoutURI = "investor/auth/logout";
  static const String kProfileURI = "investor/auth/profile";
  static const String kUpdateProfileURI = "investor/auth/update/profile";

  /// forget password
  static const String kSendEmailURI = "investor/auth/send-email";
  static const String kConfirmCodeURI = "investor/auth/confirm-code";
  static const String kNewPasswordURI = "investor/auth/new-password";

/// home
  static const String kSpecialProjectsURI = "investor/home/projects/featured";
  static const String kAllProjectsURI = "investor/home/projects";
  static const String kProjectDetailURI = "investor/home/projects/";
  static const String kFavoriteProjectsURI = "investor/favourites";
  static const String kAddFavoriteProjectsURI = "investor/favourites/store";
  static const String kAddInvestmentProjectsURI = "investor/orders/store";
  static const String kGetHomeSectorsURI = "investor/home/sectors";
  static const String kGetHomeInvestmentToursURI = "investor/home/investment_tours";
  static const String kGetSearchProjectURI = "investor/home/search";



/// orders
  static const String kCompletedOrdersURI = "investor/orders/ended";
  static const String kCurrentOrdersURI = "investor/orders/current";
  static const String kShowMessagesOrdersURI = "business_pioneer/orders/messages/";
  static const String kSendMessagesOrdersURI = "business_pioneer/orders/messages/store";
  static const String kChangeOrdersStatusURI = "investor/orders/update-status/";




/// setting
  static const String kInvestmentLibraryURI = "investor/investment_library";
  static const String kReportProblemURI = "investor/problems/store";
  static const String kGetProblemsURI = "investor/problems";






}
