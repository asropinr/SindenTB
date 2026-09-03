import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sinden_tb_app/constan/color.dart';
import 'package:sinden_tb_app/controller/skrining_controller.dart';
import 'package:sinden_tb_app/view/screnning/perviewdatadiriscreen.dart';

class DoingScreen extends StatefulWidget {
  const DoingScreen({
    super.key,
  });

  @override
  State<DoingScreen> createState() => _DoingScreenState();
}

class _DoingScreenState extends State<DoingScreen> {
  SkriningController skriningController = Get.find<SkriningController>();
  bool isChekced = false;
  bool isLoading = true;

  getData() async {
    setState(() {
      isLoading = true;
    });

    await skriningController.getPspp();
    await skriningController.getPersetujuann();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
          backgroundColor: AppColor.accentGreen,
          appBar: AppBar(
            backgroundColor: AppColor.accentGreen,
            elevation: 0,
            title: const Text(
              "Persetujuan Skrining",
              style: TextStyle(
                fontSize: 20,
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
          body: Builder(builder: (_) {
            if (isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView(
                padding: EdgeInsets.only(
                  left: 32.w,
                  right: 32.w,
                  top: 20.h,
                  bottom: 20,
                ),
                children: [
                  Text(
                    skriningController.getPsp!.data!.pspTitle!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColor.brown,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  Html(data: skriningController.getPsp!.data!.psp),
                  Expanded(
                      child:
                          Html(data: skriningController.getPersetujuan!.data)),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isChekced = !isChekced;
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: isChekced == true
                                ? AppColor.green
                                : Colors.white,
                            border: Border.all(
                              color: isChekced == true
                                  ? AppColor.green
                                  : AppColor.grey700,
                            ),
                            borderRadius: BorderRadius.circular(4.w),
                          ),
                          height: 20,
                          width: 20,
                          child: isChekced == true
                              ? Image.asset(
                                  "assets/ic_checked.png",
                                )
                              : Container(),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Saya Setuju")
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  InkWell(
                    onTap: isChekced == true
                        ? () {
                            Get.dialog(
                                Dialog(
                                  child: Container(
                                    height: 350.h,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18, vertical: 40),
                                    child: Column(
                                      children: [
                                        const Text(
                                          "Pengumuman",
                                          style: TextStyle(
                                            fontFamily: "Calibri",
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          "Hasil yang Anda dapatkan merupakan hasil skrining mandiri berdasarkan gejala yang dilaporkan, dan BUKAN merupakan diagnosis medis. Untuk hasil yang lebih akurat, mohon periksakan diri ke puskesmas terdekat atau ke dokter terkait",
                                          style: TextStyle(
                                            fontFamily: "Calibri",
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Get.to(PreviewDataDiriScreen());
                                          },
                                          child: Container(
                                            color: AppColor.green,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 14,
                                              horizontal: 40,
                                            ),
                                            child: const Text(
                                              "Lanjutkan",
                                              style: TextStyle(
                                                fontFamily: "Calibri",
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: AppColor.green)),
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 14,
                                              horizontal: 40,
                                            ),
                                            child: const Text(
                                              "Kembali",
                                              style: TextStyle(
                                                fontFamily: "Calibri",
                                                fontSize: 14,
                                                color: AppColor.green,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                barrierDismissible: false);
                          }
                        : () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 32.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: isChekced == true
                            ? AppColor.green
                            : AppColor.grey600,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Mulai",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          Image.asset(
                            "assets/ic_forward_arrow.png",
                            height: 14.h,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          })),
    );
  }
}
