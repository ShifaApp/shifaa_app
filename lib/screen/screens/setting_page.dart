import 'package:flutter/material.dart';
import 'package:shifa_app_flutter/design/color.dart';
import 'package:shifa_app_flutter/screen/screens/appointejments_page.dart';
import 'package:shifa_app_flutter/screen/screens/home_page.dart';
import 'package:shifa_app_flutter/screen/widget/app_bar_design.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: basicAppBar('Setting'),);
  }
}
