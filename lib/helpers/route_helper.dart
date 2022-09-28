import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void moveToNewStack(BuildContext context, String routeString) {
  Navigator.of(context)
      .pushNamedAndRemoveUntil(routeString, (Route<dynamic> route) => false);
}

void moveToNewStackWithArgs(context, MaterialPageRoute materialPageRoute) {
  Navigator.pushAndRemoveUntil(context, materialPageRoute, (route) => false);
}

void logoutUser(context) async {

  //----------start api ----------------
/*

  Map<String, dynamic> headerMap = await getHeaderMap();


  ProfileRepository editProfileRepository = ProfileRepository(headerMap);



  editProfileRepository.logOut().then((result) async {

    print('logout successfully');
  });

  PreferencesHelper.setUser(null);
  PreferencesHelper.setUserLoggedIn(false);
  PreferencesHelper.setUserFirstLogIn(false);
  Provider.of<BranchProvider>(context, listen: false).clearProvider();
  Provider.of<ProductProvider>(context, listen: false).clearProvider();
  moveToNewStack(context, loginRoute);
*/

}
