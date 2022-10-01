import 'package:flutter/material.dart';
import 'package:shifa_app_flutter/design/color.dart';
import 'package:shifa_app_flutter/screen/screens/appointejments_page.dart';
import 'package:shifa_app_flutter/screen/screens/home_page.dart';
import 'package:shifa_app_flutter/screen/screens/setting_page.dart';
class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int currentTab = 0;
  // late bool branchStatus = widget.isHasBranch;

  late bool branchStatus;
  final PageStorageBucket bucket = PageStorageBucket();
  final List<Widget> screens = [
    const HomePage(),
    const AppointmentsPage(),
    const SettingPage(),
  ];

  Widget currentScreen = const HomePage();

  @override
  void initState() {
    // branchStatus = widget.isHasBranch;
    super.initState();
    print('welcome in dashboard ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'HomeFAB',
        onPressed: () {
          setState(() {
            currentScreen = const AppointmentsPage();
            currentTab = 1;
          });
        },
        elevation: 0.0,
        child: Icon(
          Icons.calendar_today,
          color: CustomColors.primaryWhiteColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 3,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minWidth: 10,
                onPressed: () {
                  setState(() {
                    //ishasbranch could be set to false later
                    currentScreen = const HomePage();
                    currentTab = 0;
                  });
                },
                child: Container(
                  width: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color:
                      currentTab == 0 ?  CustomColors.lightGrayColor : CustomColors. primaryWhiteColor),
                  height: 35,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.home_outlined,
                    color: CustomColors.primaryWhiteColor,
                  ),
                )
                ,
              ),

              const SizedBox(
                width: 6,
              ),
              //Right tab bar icons
              MaterialButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minWidth: 20,
                onPressed: () {
                  setState(() {
                    currentScreen = const SettingPage();
                    currentTab = 2;
                  });
                },
                child: Container(
                  width: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color:
                      currentTab == 2 ?  CustomColors.lightGrayColor :  CustomColors.primaryWhiteColor),
                  height: 35,
                  alignment: Alignment.center,
                  child:  Icon(
                    Icons.settings,
                    color: CustomColors.primaryWhiteColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

