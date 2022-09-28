import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:shifa_app_flutter/helpers/pref/pref_manager.dart';

import '../../const/pref_const.dart';





class PreferencesHelper {
  static Future<bool> get getIsUserFirstLogIn =>
      SharedPrefsManager.getBool(firstLogin);

  static Future setUserFirstLogIn(bool value) =>
      SharedPrefsManager.setBool(firstLogin, value);

  //----------------
  static Future<bool> get getIsUserLoggedIn =>
      SharedPrefsManager.getBool(isLoggedIn);
  static Future setUserLoggedIn(bool value) =>
      SharedPrefsManager.setBool(isLoggedIn, value);
  //----------------
  static Future<bool> get getIsUserGuest =>
      SharedPrefsManager.getBool(isGuest);
  static Future setUserGuest(bool value) =>
      SharedPrefsManager.setBool(isGuest, value);

  //------------------

  static Future<bool> get getIsUserLoggedOut =>
      SharedPrefsManager.getBool(isLoggedOut);
  static Future setUserLoggedOut(bool value) =>
      SharedPrefsManager.setBool(isLoggedOut, value);



  //--------------------
  static Future<String> get getSelectedLanguage =>
      SharedPrefsManager.getString(currentLanguage);

  static Future setSelectedLanguage({String value = 'en'}) =>
      SharedPrefsManager.setString(currentLanguage, value);
  //--------------------

  static Future<String> get getUserToken => SharedPrefsManager.getString(token);

  static Future setUserToken(String value) => SharedPrefsManager.setString(token,'Bearer $value');
  static Future clearUserToken() =>
      SharedPrefsManager.setString(token,'');
  //--------------------
/*
  static Future<List<Cities>> get getCities async {
    List<Cities> citiesList =[];
  */ /*  Map<String, dynamic> userMap =
    await SharedPrefsManager.getFromJson(cities);*/ /*
   List< Cities> o = SharedPrefsManager.getFromJson(cities);
    o.forEach((v) {
      citiesList.add(Cities.fromJson(v));
    });
    return citiesList;//Cities.fromJson(userMap);
  }

  static Future setCities(List<Cities>? citiesValue) {
    //  user = User.fromJson(user);
    if (citiesValue != null)
      return SharedPrefsManager.setToJson(cities, citiesValue);
    else
      return SharedPrefsManager.setToJson(cities, '');
  }*/
  //--------------------
  // static Future<User> get getUser async {
  //   Map<String, dynamic> userMap =
  //   await SharedPrefsManager.getFromJson(currentUser);
  //   return User.fromJson(userMap);
  // }
  //
  // static Future setUser(User? user) {
  //   //  user = User.fromJson(user);
  //   if (user != null) {
  //     return SharedPrefsManager.setToJson(currentUser, user);
  //   } else {
  //     return SharedPrefsManager.setToJson(currentUser, '');
  //   }
  // }

  //--------------------


  static void clearPrefs() {
    SharedPrefsManager.clear();
  }
/*  Future<void> clear() async {
    await Future.wait(<Future>[
      setAuthenticated(false),
      setTutorialString(''),
      setPasscode(''),
    ]);
  }*/
}
