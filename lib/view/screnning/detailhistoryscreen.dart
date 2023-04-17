import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sinden_tb_app/constan/color.dart';
import 'package:sinden_tb_app/controller/skrining_controller.dart';

class DetailHistoryScreen extends StatefulWidget {
  final String idUser;
  final String idHistory;
  const DetailHistoryScreen({
    super.key,
    required this.idUser,
    required this.idHistory,
  });

  @override
  State<DetailHistoryScreen> createState() => _DetailHistoryScreenState();
}

class _DetailHistoryScreenState extends State<DetailHistoryScreen> {
  SkriningController skriningController = Get.find<SkriningController>();
  bool isloading = true;

  getData() async {
    setState(() {
      isloading = true;
    });

    await skriningController.getDetail(widget.idUser, widget.idHistory);

    setState(() {
      isloading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.accentGreen,
        appBar: AppBar(
          backgroundColor: AppColor.accentGreen,
          elevation: 0,
          title: const Text(
            "Detail History Skrining",
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
          if (isloading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
              children: [
                SizedBox(
                  height: 16.h,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Image.network(
                              skriningController
                                  .getDetailHistory!.data!.resultImage!,
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
                                  color: setTextColor(skriningController
                                      .getDetailHistory!.data!.resultTextColor),
                                  width: 5),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Status Hasil : ${skriningController.getDetailHistory!.data!.statusResponden!.toUpperCase()}",
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
                                      .getDetailHistory!.data!.resultText!,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.brown),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            );
          }
        }));
  }

  setTextColor(color) {
    if (color == "merah") {
      return AppColor.redWhite;
    } else if (color == "kuning") {
      return AppColor.yellowWhite;
    } else {
      return AppColor.greenWhite;
    }
  }
}
