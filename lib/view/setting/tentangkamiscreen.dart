import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sinden_tb_app/constan/color.dart';
import 'package:sinden_tb_app/controller/artikel_controller.dart';

class TentangKamiScreen extends StatefulWidget {
  const TentangKamiScreen({super.key});

  @override
  State<TentangKamiScreen> createState() => _TentangKamiScreenState();
}

class _TentangKamiScreenState extends State<TentangKamiScreen> {
  ArtikelController artikelController = Get.find<ArtikelController>();

  bool isLoading = true;

  getData() async {
    setState(() {
      isLoading = true;
    });

    await artikelController.getTentang();

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
    return SafeArea(
      top: false,
      child: Scaffold(
          backgroundColor: AppColor.accentGreen,
          appBar: AppBar(
            backgroundColor: AppColor.accentGreen,
            elevation: 0,
            title: const Text(
              "Tentang Kami",
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
                padding: const EdgeInsets.only(left: 32),
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
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                children: [
                  SizedBox(
                    height: 16.h,
                  ),
                  Html(
                    data: artikelController.getTentangKami!.data!.aboutText,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                ],
              );
            }
          })),
    );
  }
}
