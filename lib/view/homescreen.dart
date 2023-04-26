import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sinden_tb_app/constan/color.dart';
import 'package:sinden_tb_app/constan/preference.dart';
import 'package:sinden_tb_app/controller/artikel_controller.dart';
import 'package:sinden_tb_app/model/register/postlogin_model.dart';
import 'package:sinden_tb_app/view/artikel/artikellistscreen.dart';
import 'package:sinden_tb_app/view/artikel/detailartikel.dart';
import 'package:sinden_tb_app/view/detailedukasiscreen.dart';
import 'package:sinden_tb_app/view/puskesmas/puskesmasscreen.dart';
import 'package:sinden_tb_app/view/screnning/indexscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ArtikelController artikelController = Get.put(ArtikelController());
  PostLogin? postLogin;
  bool isLoading = true;

  Future getData() async {
    postLogin = await Prefence().getDataLogin();
    setState(() {});
  }

  getDataArtikel() async {
    setState(() {
      isLoading = true;
    });

    await getData();
    await artikelController.getListArtikel();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataArtikel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Builder(builder: (_) {
      if (isLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return ListView(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).viewPadding.top,
            bottom: 50.h,
          ),
          children: [
            Container(
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColor.grey600))),
              margin: EdgeInsets.symmetric(horizontal: 42.w),
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 14.h),
              child: Row(
                children: [
                  Container(
                    height: 60.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.w),
                      border: Border.all(
                        color: AppColor.green,
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14.w),
                      child: Image.network(
                        postLogin!.data!.userFoto!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, url, error) => ClipRRect(
                          borderRadius: BorderRadius.circular(14.w),
                          child: Image.asset(
                            "assets/user_image.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 14.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Selamat Datang",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        postLogin!.data!.userName!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            InkWell(
              onTap: () {
                Get.to(IndexScrenningScreen());
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
                            "Skrining",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: AppColor.brown,
                            ),
                          ),
                          const Text(
                            "TB",
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
                              "Skrining mandiri deteksi dini penyakit tuberkulosis",
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
              height: 16.h,
            ),
            InkWell(
              onTap: () {
                Get.to(DetailEdukasiTBScreen());
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
                            "Edukasi",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: AppColor.brown,
                            ),
                          ),
                          const Text(
                            "TB",
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
                              "Edukasi Penting tentang Penyakit, Pencegahan, dan Pengobatan TB",
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
                      "assets/ic_card_edukasi.png",
                      height: 80.h,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            InkWell(
              onTap: () {
                Get.to(PuskesmasListScreen());
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
                            "Info",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: AppColor.brown,
                            ),
                          ),
                          const Text(
                            "Puskesmas",
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
                              "Temukan puskesmas terdekat di kota Anda",
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
                      "assets/ic_card_puskesmas.png",
                      height: 80.h,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 32.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Artikel Terkait",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColor.brown,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(ListArtikelScreen());
                    },
                    child: Row(
                      children: [
                        const Text(
                          "Lihat Semua",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColor.green,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Image.asset(
                          "assets/ic_forward_arrow.png",
                          color: AppColor.green,
                          height: 10.h,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 16.h,
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
                          data: artikelController.getArtikel!.data![index]));
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        left: index == 0 ? 32 : 8,
                        right: index == 0 ? 0 : 32,
                      ),
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
          ],
        );
      }
    }));
  }
}
