import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shifa_app_flutter/design/color.dart';
import 'package:shifa_app_flutter/screen/screens/dashboard_page.dart';
import 'package:shifa_app_flutter/screen/screens/login_page.dart';

import 'const/route_constants.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    //options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) {
        return 'SHIFA ';
      },        debugShowCheckedModeBanner: false,


      routes: routMap,
      theme: ThemeData(
        fontFamily: 'Cairo',
        accentColor: CustomColors.lightBlueColor,
        primarySwatch: Colors.lightBlue,
      ),
      home: const DashboardPage(),
    );
  }
}
