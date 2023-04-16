import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sinden_tb_app/constan/color.dart';
import 'package:sinden_tb_app/controller/skrining_controller.dart';
import 'package:sinden_tb_app/view/screnning/doingscrenningscreen.dart';

class DoingScreen extends StatefulWidget {
  const DoingScreen({
    Key? key,
  }) : super(key: key);

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
            return Stack(
              children: [
                ListView(
                  padding: EdgeInsets.only(
                    left: 32.w,
                    right: 32.w,
                    top: 20.h,
                    bottom: MediaQuery.of(context).size.height * .5,
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
                    Html(data: skriningController.getPsp!.data!.psp)
                  ],
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 16.h,
                      horizontal: 32.w,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.green.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              isChekced = !isChekced;
                            });
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                width: 10.w,
                              ),
                              Expanded(
                                  child: Html(
                                      data: skriningController
                                          .getPersetujuan!.data)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        InkWell(
                          onTap: isChekced == true
                              ? () {
                                  Get.to(DoingScrenningScrenn());
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
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        }));
  }
}
