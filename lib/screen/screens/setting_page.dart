import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shifa_app_flutter/design/color.dart';
import 'package:shifa_app_flutter/dialogs/snack_message.dart';
import 'package:shifa_app_flutter/screen/screens/appointements_page.dart';
import 'package:shifa_app_flutter/screen/screens/home_page.dart';
import 'package:shifa_app_flutter/screen/widget/app_bar_design.dart';
import 'package:shifa_app_flutter/screen/widget/profile_widget.dart';

import '../../const/const.dart';
import '../../const/route_constants.dart';
import '../../helpers/route_helper.dart';
import 'info_page.dart';
import 'my_recipes.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppBar('Setting'),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              // Container(
              //   margin: const EdgeInsets.all(20),
              //   width: 100,
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: user != null
              //         ? (user.image != null
              //         ? Image.network(ApiConst.imageUrl + user.image!)
              //         : SvgPicture.asset('assets/images/users.svg'))
              //         : SvgPicture.asset('assets/images/users.svg'),
              //   ),
              //   decoration: BoxDecoration(
              //       color: primaryWhiteColor,
              //       borderRadius: BorderRadius.circular(20)),
              // ),

              ///////////////////
              const SizedBox(
                height: 20,
              ),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'welcome'.toUpperCase(),
                    style: TextStyle(
                        color: CustomColors.primaryBlackColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w800),
                  ))

              ///////
              ,
              const SizedBox(
                height: 20,
              ),
              profileListDesign('My Information', Icons.account_circle_outlined,
                  onPressed: () {
                if (Const.isUserGuest == false) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const MyInfo();
                  }));
                } else {
                  showSuccessMessage(context, 'You Have to Log In first ');
                }
              }),

              profileListDesign('My Prescriptions', Icons.contact_page_outlined,
                  onPressed: () {
                if (Const.isUserGuest == false) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const MyRecipes();
                  }));
                } else {
                  showSuccessMessage(context, 'You Have to Log In first ');
                }
              }),

              profileListDesign(
                  Const.isUserGuest ? 'Log In' : 'Sign Out', Icons.arrow_back,
                  onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Const.currentUserId = '';
                  Const.userName = '';
                  moveToNewStack(context, loginRoute);
                });
                // AuthRepository().logoutUser(context).then((value) {
                //   PreferencesHelper.setUser(null);
                //   PreferencesHelper.setUserLoggedIn(false);
                //   PreferencesHelper.clearUserToken();
                //
                //   moveToNewStack(context, loginRoute);
                // });
              })
            ],
          ),
        ),
      ),
    );
  }

  directToPage(page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}
