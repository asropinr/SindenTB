import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sinden_tb_app/constan/color.dart';
import 'package:sinden_tb_app/controller/skrining_controller.dart';
import 'package:sinden_tb_app/view/bottomnavbar.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  SkriningController skriningController = Get.find<SkriningController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.accentGreen,
      body: ListView(
        padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
        children: [
          SizedBox(
            height: 16.h,
          ),
          Column(
            children: [
              const Text(
                "Hasil Skrining",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColor.brown),
              ),
              SizedBox(
                height: 70.h,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Image.network(
                        skriningController
                            .postJawabanSkrining!.data!.resultImage!,
                        height: 240.h,
                      ),
                    ),
                    Image.asset(
                      "assets/ic_iicSinden.png",
                      height: 70.h,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Column(
                  children: [
                    const Text(
                      "Hasil Pemeriksaan Kamu",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: AppColor.brown),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.w),
                        border: Border.all(
                            width: 5,
                            color: setTextColor(skriningController
                                .postJawabanSkrining!.data!.resultTextColor)),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Status Hasil : ${skriningController.postJawabanSkrining!.data!.statusResponden!.toUpperCase()}",
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColor.brown),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                            skriningController
                                .postJawabanSkrining!.data!.resultText!,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColor.brown),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 130.h,
                    ),
                    InkWell(
                      onTap: () {
                        Get.off(BottomNavBarScreen());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.w),
                          border: Border.all(color: AppColor.green),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/ic_home.png",
                              color: AppColor.green,
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            const Text(
                              "Kembali Ke Home",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: AppColor.green,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  setTextColor(color) {
    if (color == "merah") {
      return AppColor.redWhite;
    } else if (color == "kuning") {
      //return const Color(0XFFF9F9C5);
      return AppColor.yellowWhite;
    } else {
      return AppColor.greenWhite;
    }
  }
}
