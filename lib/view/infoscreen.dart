import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sinden_tb_app/constan/color.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final pageControl = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageControl,
        children: [
          Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                "assets/Information 4.png",
                fit: BoxFit.fill,
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 50.h,
                  left: 32.w,
                  right: 32.w,
                ),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          pageControl.animateToPage(1,
                              duration: const Duration(milliseconds: 10),
                              curve: Curves.easeIn);
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 14.h),
                          height: 50.h,
                          width: 50.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.brown,
                          ),
                          child: Image.asset(
                            "assets/ic_forwd.png",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                "assets/Information 5.png",
                fit: BoxFit.fill,
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 50.h,
                  left: 32.w,
                  right: 32.w,
                ),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          pageControl.animateToPage(0,
                              duration: const Duration(milliseconds: 10),
                              curve: Curves.easeIn);
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 14.h),
                          height: 50.h,
                          width: 50.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.brown,
                          ),
                          child: Image.asset(
                            "assets/ic_back.png",
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          pageControl.animateToPage(2,
                              duration: const Duration(milliseconds: 10),
                              curve: Curves.easeIn);
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 14.h),
                          height: 50.h,
                          width: 50.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.brown,
                          ),
                          child: Image.asset(
                            "assets/ic_forwd.png",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                "assets/Information 6.png",
                fit: BoxFit.fill,
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 50.h,
                  left: 32.w,
                  right: 32.w,
                ),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          pageControl.animateToPage(1,
                              duration: const Duration(milliseconds: 10),
                              curve: Curves.easeIn);
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 14.h),
                          height: 50.h,
                          width: 50.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.brown,
                          ),
                          child: Image.asset(
                            "assets/ic_back.png",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
