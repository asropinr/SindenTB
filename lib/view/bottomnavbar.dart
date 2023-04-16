import 'package:flutter/material.dart';
import 'package:sinden_tb_app/constan/color.dart';
import 'package:sinden_tb_app/view/homescreen.dart';
import 'package:sinden_tb_app/view/infoscreen.dart';
import 'package:sinden_tb_app/view/settingscreen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  final pageControl = PageController();
  int selectIndex = 0;

  ontapKonten(int index) {
    setState(() {
      selectIndex = index;
    });

    pageControl.animateToPage(selectIndex,
        duration: const Duration(milliseconds: 10), curve: Curves.easeIn);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildBottomNavigation(),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageControl,
        children: [
          HomeScreen(),
          InfoScreen(),
          SettingScreen(),
        ],
      ),
    );
  }

  buildBottomNavigation() {
    return BottomNavigationBar(
      elevation: 10,
      currentIndex: selectIndex,
      onTap: ontapKonten,
      selectedItemColor: AppColor.green,
      unselectedItemColor: AppColor.grey700,
      selectedLabelStyle: const TextStyle(
          fontSize: 10, fontWeight: FontWeight.w500, color: AppColor.green),
      unselectedLabelStyle: const TextStyle(
          fontSize: 10, fontWeight: FontWeight.w500, color: AppColor.grey700),
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Image.asset(
              height: 20,
              "assets/ic_home.png",
              color: selectIndex == 0 ? AppColor.green : AppColor.grey700,
            ),
            label: "Home"),
        BottomNavigationBarItem(
            icon: Image.asset(
              height: 20,
              "assets/ic_info.png",
              color: selectIndex == 1 ? AppColor.green : AppColor.grey700,
            ),
            label: "Info"),
        BottomNavigationBarItem(
            icon: Image.asset(
              height: 20,
              "assets/ic_setting.png",
              color: selectIndex == 2 ? AppColor.green : AppColor.grey700,
            ),
            label: "Setting"),
      ],
    );
  }
}
