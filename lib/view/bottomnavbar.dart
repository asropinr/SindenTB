import 'package:flutter/material.dart';
import 'package:sinden_tb_app/constan/color.dart';
import 'package:sinden_tb_app/view/bantuan/chatboxscreen.dart';
import 'package:sinden_tb_app/view/bantuan/faqscreen.dart';
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
    return SafeArea(
      top: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: buildBottomAppBar(),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageControl,
          children: [
            HomeScreen(),
            InfoScreen(),
            HelpCenterScreen(),
            SettingScreen(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          shape: CircleBorder(),
          backgroundColor: AppColor.green,
          child: Icon(
            Icons.messenger_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const HealthAssistantScreen(),
              ),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Widget buildBottomAppBar() {
    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      removeTop: true,
      child: BottomAppBar(
        padding: EdgeInsets.all(0),
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        shadowColor: Colors.black.withOpacity(0.15),
        color: Colors.white,
        child: SizedBox(
          height: 58,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _navItem(
                  icon: "assets/ic_home.png",
                  label: "Home",
                  index: 0,
                ),
              ),
              Expanded(
                child: _navItem(
                  icon: "assets/ic_info.png",
                  label: "Info",
                  index: 1,
                ),
              ),
              const SizedBox(width: 60),
              Expanded(
                child: _navItem(
                  icon: null,
                  label: "FAQ",
                  index: 2,
                  isChat: true,
                ),
              ),
              Expanded(
                child: _navItem(
                  icon: "assets/ic_setting.png",
                  label: "Setting",
                  index: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem({
    String? icon,
    required String label,
    required int index,
    bool isChat = false,
  }) {
    final isSelected = selectIndex == index;

    return InkWell(
      onTap: () => ontapKonten(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isChat)
            Icon(
              Icons.help_outline_rounded,
              size: 22,
              color: isSelected ? AppColor.green : AppColor.grey700,
            )
          else
            Image.asset(
              icon!,
              height: 20,
              color: isSelected ? AppColor.green : AppColor.grey700,
            ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isSelected ? AppColor.green : AppColor.grey700,
            ),
          ),
        ],
      ),
    );
  }
}
