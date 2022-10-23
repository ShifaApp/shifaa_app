import 'package:flutter/cupertino.dart';
import 'package:shifa_app_flutter/screen/screens/hospital/register_hospital.dart';
import 'package:shifa_app_flutter/screen/screens/login_page.dart';
import 'package:shifa_app_flutter/screen/screens/signup_page.dart';

import '../screen/screens/dashboard_page.dart';


const String homeRoute = "home";
const String splashRoute = "splash";
const String aboutRoute = "about";
const String cartRoute = "cart";
const String loginRoute = "login";
const String signupRoute = "signup";
const String welcomeRoute = "welcome";
const String languageRoute = "language";
const String noPage = "noPage";
const String editInfoRoute = "editInfo";
const String mainRoute = "mainRoute";
//const String mapRoute = "mapRoute";
const String dashBoardRoute = "dashBoard";
const String registerHospitalRoute = "registerHospital";


final Map<String, WidgetBuilder> routMap = {
 //  splashRoute: (BuildContext context) => const SplashScreen(),
   registerHospitalRoute: (BuildContext context) => const RegisterHospital(),
   loginRoute: (BuildContext context) => const LogInPage(),
   signupRoute: (BuildContext context) => const SignUpPage(),
 // // mapRoute: (BuildContext context) => const LocationScreen(),
   dashBoardRoute: (BuildContext context) => const DashboardPage(),
 //  languageRoute: (BuildContext context) => const LanguagePage(),


};
