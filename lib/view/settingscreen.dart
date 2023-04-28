import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sinden_tb_app/constan/color.dart';
import 'package:sinden_tb_app/constan/preference.dart';
import 'package:sinden_tb_app/model/register/postlogin_model.dart';
import 'package:sinden_tb_app/view/auth/loginscreen.dart';
import 'package:sinden_tb_app/view/setting/editprofilescreen.dart';
import 'package:sinden_tb_app/view/setting/tentangkamiscreen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
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
    // TODO: implement initState
    super.initState();
    getData();
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
            top: MediaQuery.of(context).viewPadding.top * 1.5,
            bottom: 50.h,
          ),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 85.h,
                  width: 85.w,
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
              ],
            ),
            SizedBox(
              height: 24.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              margin: EdgeInsets.symmetric(horizontal: 32.w),
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.grey500),
                borderRadius: BorderRadius.circular(8.w),
              ),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Text(
                    postLogin!.data!.userName!,
                    style: const TextStyle(
                        fontSize: 24,
                        color: AppColor.brown,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    postLogin!.data!.userEmail!,
                    style: const TextStyle(
                        fontSize: 14,
                        color: AppColor.green,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              margin: EdgeInsets.symmetric(horizontal: 32.w),
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.grey500),
                borderRadius: BorderRadius.circular(8.w),
              ),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      Get.to(TentangKamiScreen());
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      margin: EdgeInsets.symmetric(horizontal: 22.w),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: AppColor.grey500))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/ic_tentang_kami.png",
                                height: 20.h,
                              ),
                              SizedBox(
                                width: 16.w,
                              ),
                              const Text(
                                "Tentang Kami",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.brown,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Image.asset(
                            "assets/ic_forw.png",
                            height: 20.h,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  InkWell(
                    onTap: () async {
                      await Get.to(EditProfileScreen(
                        postLogin: postLogin!,
                      ));
                      getData();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      margin: EdgeInsets.symmetric(horizontal: 22.w),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: AppColor.grey500))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/ic_kontak_kami.png",
                                height: 20.h,
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              const Text(
                                "Update Profile",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.brown,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Image.asset(
                            "assets/ic_forw.png",
                            height: 20.h,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  // Container(
                  //   padding: EdgeInsets.symmetric(vertical: 12.h),
                  //   margin: EdgeInsets.symmetric(horizontal: 22.w),
                  //   decoration: const BoxDecoration(
                  //       border: Border(
                  //           bottom: BorderSide(color: AppColor.grey500))),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Row(
                  //         children: [
                  //           Image.asset(
                  //             "assets/ic_tandc.png",
                  //             height: 20.h,
                  //           ),
                  //           SizedBox(
                  //             width: 20.w,
                  //           ),
                  //           const Text(
                  //             "Syarat dan Ketentuan",
                  //             style: TextStyle(
                  //                 fontSize: 16,
                  //                 color: AppColor.brown,
                  //                 fontWeight: FontWeight.w400),
                  //           ),
                  //         ],
                  //       ),
                  //       Image.asset(
                  //         "assets/ic_forw.png",
                  //         height: 20.h,
                  //       )
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            GestureDetector(
              onTap: () async {
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                await sharedPreferences.clear();
                Get.offAll(const LoginScreen());
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 32.w),
                padding: EdgeInsets.symmetric(vertical: 10.h),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColor.errorColor,
                  borderRadius: BorderRadius.circular(100.w),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Keluar",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      width: 24.w,
                    ),
                    Image.asset(
                      "assets/ic_logout.png",
                      height: 15.h,
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      }
    }));
  }
}
