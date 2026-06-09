import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sinden_tb_app/constan/color.dart';
import 'package:sinden_tb_app/constan/preference.dart';
import 'package:sinden_tb_app/view/auth/loginscreen.dart';
import 'package:sinden_tb_app/view/bottomnavbar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startSplashScreen() async {
    var status = await Prefence().getStatusLogin();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            if (status == true) {
              return const BottomNavBarScreen();
            } else {
              return const LoginScreen();
            }
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColor.accentGreen,
        body: Stack(
          children: [
            Container(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.4),
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset("assets/ic_iconApps.png"),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.1),
                    child: const Text(
                      "Sinden TB",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColor.green,
                      ),
                    ),
                  ),
                  Image.asset("assets/bg_blur_bottom.png"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
