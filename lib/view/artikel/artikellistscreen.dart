import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sinden_tb_app/constan/color.dart';
import 'package:sinden_tb_app/controller/artikel_controller.dart';
import 'package:sinden_tb_app/view/artikel/detailartikel.dart';

class ListArtikelScreen extends StatefulWidget {
  const ListArtikelScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ListArtikelScreen> createState() => _ListArtikelScreenState();
}

class _ListArtikelScreenState extends State<ListArtikelScreen> {
  ArtikelController artikelController = Get.find<ArtikelController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.accentGreen,
      appBar: AppBar(
        backgroundColor: AppColor.accentGreen,
        elevation: 0,
        title: const Text(
          "List Artikel",
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
      body: ListView(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Column(
            children: List.generate(
              artikelController.getArtikel!.data!.length,
              (index) => InkWell(
                onTap: () {
                  Get.to(DetailArtikelScreen(
                    data: artikelController.getArtikel!.data![index],
                  ));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 32.w),
                  padding: EdgeInsets.all(10.w),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppColor.lightGreen),
                    ),
                  ),
                  child: Row(
                    children: [
                      // ClipRRect(
                      //   borderRadius: BorderRadius.circular(4.w),
                      //   child: SizedBox(
                      //     height: 80.h,
                      //     child: Image.network(
                      //       artikelController
                      //           .getArtikel!.data![index].bannerImage!,
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        width: 16.w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat(
                                "dd MMMM y",
                              ).format(
                                DateTime.parse(artikelController
                                    .getArtikel!.data![index].postDate!),
                              ),
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              artikelController
                                  .getArtikel!.data![index].blogTitle!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColor.brown,
                              ),
                              maxLines: 2,
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            const Text(
                              "read more...",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColor.green,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
