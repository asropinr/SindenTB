import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sinden_tb_app/constan/color.dart';
import 'package:sinden_tb_app/controller/artikel_controller.dart';
import 'package:sinden_tb_app/view/artikel/detailartikel.dart';
import 'package:url_launcher/url_launcher.dart';

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
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      const Text(
                        "Sumber : ",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColor.brown,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await launchUrl(Uri.parse(
                              "https://sindentb.com/blog/post/edukasi-tbpost0030.html"));
                        },
                        child: const Text(
                          "https://sindentb.com/blog/post/edukasi-tbpost0030.html",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      const Text(
                        "Artikel Terkait",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColor.brown,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      artikelController.getArtikel!.data!.length,
                      (index) => InkWell(
                        onTap: () {
                          Get.to(DetailArtikelScreen(
                              data:
                                  artikelController.getArtikel!.data![index]));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: index == 0 ? 32 : 8,
                              right: index == 0 ? 0 : 32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 150.h,
                                width: 200.w,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4.w),
                                  child: Image.network(
                                    artikelController
                                        .getArtikel!.data![index].bannerImage!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                DateFormat(
                                  "dd MMMM y",
                                ).format(
                                  DateTime.parse(artikelController
                                      .getArtikel!.data![index].postDate!),
                                ),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.brown,
                                ),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              SizedBox(
                                width: 200.w,
                                child: Text(
                                  artikelController
                                      .getArtikel!.data![index].blogTitle!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.brown,
                                  ),
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
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
