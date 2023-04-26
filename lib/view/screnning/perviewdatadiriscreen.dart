import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sinden_tb_app/constan/color.dart';
import 'package:sinden_tb_app/constan/preference.dart';
import 'package:sinden_tb_app/model/register/postlogin_model.dart';
import 'package:sinden_tb_app/view/screnning/doingscrenningscreen.dart';
import 'package:sinden_tb_app/view/setting/editprofilescreen.dart';

class PreviewDataDiriScreen extends StatefulWidget {
  const PreviewDataDiriScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PreviewDataDiriScreen> createState() => _PreviewDataDiriScreenState();
}

class _PreviewDataDiriScreenState extends State<PreviewDataDiriScreen> {
  PostLogin? postLogin;

  bool isLoading = true;

  Future getData() async {
    postLogin = await Prefence().getDataLogin();
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
    return Scaffold(
      backgroundColor: AppColor.accentGreen,
      appBar: AppBar(
        backgroundColor: AppColor.accentGreen,
        elevation: 0,
        title: const Text(
          "Preview Data Diri",
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
      body: Builder(
        builder: (_) {
          if (isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              children: [
                SizedBox(
                  height: 20.h,
                ),
                const Text(
                  "Berikut Preview Data Diri Kamu : ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 18.h,
                ),
                Text(
                  "Nama : ${postLogin!.data!.userName!}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "Tanggal Lahir : ${DateFormat(
                    "dd MMMM y",
                  ).format(
                    DateTime.parse(postLogin!.data!.dob!),
                  )}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "Jenis Kelamin : ${postLogin!.data!.gender!}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "No HP : ${postLogin!.data!.userPhone!}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "Asal Sekolah : ${postLogin!.data!.userUniversity!}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "Asal Provinsi : ${postLogin!.data!.uProvinsi!}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "Asal Kabupaten : ${postLogin!.data!.uKabupaten!}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "Asal Kecamatan : ${postLogin!.data!.uKecamatan!}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "Asal Kelurahan : ${postLogin!.data!.uKelurahan!}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "Alamat : ${postLogin!.data!.userAddress!}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "Puskesmas : ${postLogin!.data!.userPuskesmas!}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 80.h,
                ),
                InkWell(
                  onTap: () async {
                    await Get.to(EditProfileScreen(
                      postLogin: postLogin!,
                    ));
                    getData();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.w),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.green.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: const Text(
                      "Update Profile",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColor.green),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                InkWell(
                  onTap: () {
                    Get.to(DoingScrenningScrenn());
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppColor.green,
                      borderRadius: BorderRadius.circular(4.w),
                    ),
                    child: const Text(
                      "Lanjut Skrinig",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
