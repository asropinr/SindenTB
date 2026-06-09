import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sinden_tb_app/constan/color.dart';
import 'package:sinden_tb_app/constan/preference.dart';
import 'package:sinden_tb_app/controller/skrining_controller.dart';
import 'package:sinden_tb_app/model/register/postlogin_model.dart';
import 'package:sinden_tb_app/view/screnning/detailhistoryscreen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  SkriningController skriningController = Get.find<SkriningController>();
  bool isLoading = true;
  PostLogin? postLogin;

  Future getUserId() async {
    postLogin = await Prefence().getDataLogin();
    return postLogin!.data!.userId;
  }

  getData() async {
    setState(() {
      isLoading = true;
    });

    final idUser = await getUserId();
    await skriningController.getHistoryy(idUser);

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
              "History Skrining",
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
            } else if (skriningController.getHistory!.data!.isEmpty) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/ic_no_data.png",
                      height: 280.h,
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    const Text(
                      "Belum Ada Data History. Silahkan Melakukan Skrining Terlebih Dahulu",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColor.brown,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              );
            } else {
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                children: [
                  SizedBox(
                    height: 16.h,
                  ),
                  Column(
                    children: List.generate(
                      skriningController.getHistory!.data!.length,
                      (index) => InkWell(
                        onTap: () async {
                          Get.to(DetailHistoryScreen(
                            idUser: skriningController
                                .getHistory!.data![index].userFk!,
                            idHistory: skriningController
                                .getHistory!.data![index].skriningId!
                                .toString(),
                          ));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom: index ==
                                      skriningController
                                              .getHistory!.data!.length -
                                          1
                                  ? 30.h
                                  : 14.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 12.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.w),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.green.withOpacity(0.2),
                                blurRadius: 5,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat(
                                  "dd MMMM y",
                                ).format(
                                  DateTime.parse(skriningController
                                      .getHistory!.data![index].dateCreate!),
                                ),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.brown,
                                ),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              const Text(
                                "Hasil Pemeriksaan : ",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.brown,
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                skriningController
                                    .getHistory!.data![index].resultText!,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.brown,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Status : ",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.brown,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8.w),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4.w),
                                        color: getColorLabel(skriningController
                                            .getHistory!
                                            .data![index]
                                            .resultTextColor!)),
                                    child: Text(
                                      skriningController.getHistory!
                                          .data![index].statusResponden!
                                          .toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.brown,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
          })),
    );
  }

  getColorLabel(String val) {
    if (val == "hijau") {
      return AppColor.greenWhite;
    } else if (val == "merah") {
      return AppColor.redWhite;
    } else if (val == "kuning") {
      return AppColor.yellowWhite;
    } else {
      return Colors.white;
    }
  }
}
