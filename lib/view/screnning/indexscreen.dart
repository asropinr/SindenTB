import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sinden_tb_app/constan/color.dart';
import 'package:sinden_tb_app/controller/skrining_controller.dart';
import 'package:sinden_tb_app/view/screnning/doingsrenning.dart';
import 'package:sinden_tb_app/view/screnning/historyscreen.dart';

class IndexScrenningScreen extends StatefulWidget {
  const IndexScrenningScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<IndexScrenningScreen> createState() => _IndexScrenningScreenState();
}

class _IndexScrenningScreenState extends State<IndexScrenningScreen> {
  SkriningController skriningController = Get.put(SkriningController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.accentGreen,
      appBar: AppBar(
        backgroundColor: AppColor.accentGreen,
        elevation: 0,
        title: const Text(
          "Skrining",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColor.brown,
          ),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: EdgeInsets.only(left: 32.w),
            child: Image.asset(
              "assets/ic_back_arrow.png",
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset("assets/bg_blur_bottom.png"),
          ),
          Column(
            children: [
              SizedBox(
                height: 100.h,
              ),
              InkWell(
                onTap: () {
                  Get.to(DoingScreen());
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 32.w),
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage("assets/bg_card.png"),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(8.w),
                    border: Border.all(
                      color: AppColor.green,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Mulai",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: AppColor.brown,
                              ),
                            ),
                            const Text(
                              "Skrining",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: AppColor.brown,
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            SizedBox(
                              width: 190.w,
                              child: const Text(
                                "Mengetahui Tanda dan Gejala Penyakit TBC untuk Diagnosis yang Tepat",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.brown,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        "assets/ic_card_scanning.png",
                        height: 70.h,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              InkWell(
                onTap: () {
                  Get.to(HistoryScreen());
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 32.w),
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage("assets/bg_card.png"),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(8.w),
                    border: Border.all(
                      color: AppColor.green,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Histori",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: AppColor.brown,
                              ),
                            ),
                            const Text(
                              "Skrining",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: AppColor.brown,
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            SizedBox(
                              width: 190.w,
                              child: const Text(
                                "lihat Riwayat Hasil Skrining Kamu untuk Melakukan Pengecekan Ulang",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.brown,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        "assets/ic_history.png",
                        height: 90.h,
                      )
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
