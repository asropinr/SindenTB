import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sinden_tb_app/constan/color.dart';
import 'package:sinden_tb_app/controller/artikel_controller.dart';

class DetailEdukasiTBScreen extends StatefulWidget {
  const DetailEdukasiTBScreen({super.key});

  @override
  State<DetailEdukasiTBScreen> createState() => _DetailEdukasiTBScreenState();
}

class _DetailEdukasiTBScreenState extends State<DetailEdukasiTBScreen> {
  ArtikelController artikelController = Get.find<ArtikelController>();

  bool isLoading = true;

  getData() async {
    setState(() {
      isLoading = true;
    });

    await artikelController.getEdukasi();

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
            "Edukasi TB",
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
                Text(
                  artikelController.getEdukasiTb!.data!.eduTbTitle!,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColor.brown,
                  ),
                  textAlign: TextAlign.center,
                ),
                Html(
                  data: artikelController.getEdukasiTb!.data!.eduTbText!,
                ),
                SizedBox(
                  height: 30.h,
                ),
              ],
            );
          }
        }));
  }
}
