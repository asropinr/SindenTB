import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:sinden_tb_app/constan/color.dart';
import 'package:sinden_tb_app/constan/preference.dart';
import 'package:sinden_tb_app/constan/shimmer.dart';
import 'package:sinden_tb_app/controller/register_controller.dart';
import 'package:sinden_tb_app/view/auth/registrasiscreen.dart';
import 'package:sinden_tb_app/view/bottomnavbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  RegisterController registerController = Get.put(RegisterController());

  showBottomSheetLogin() {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          ),
        ),
        context: context,
        builder: (context) => BottomSheetLogin(
              registerController: registerController,
            ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.accentGreen,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset("assets/bg_blur_bottom.png"),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              SizedBox(
                height: 40.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Image.asset("assets/ic_iconApps.png"),
              ),
              SizedBox(
                height: 32.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 36.w),
                child: const Text(
                  "Pelajari bagaimana cara mencegah dan mengobati tuberkulosis dengan tepat",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 91.h,
              ),
              InkWell(
                onTap: () {
                  showBottomSheetLogin();
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.w, vertical: 18.h),
                  decoration: BoxDecoration(
                    color: AppColor.brown,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.green.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
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
            ],
          ),
        ],
      ),
    );
  }
}

class BottomSheetLogin extends StatefulWidget {
  final RegisterController registerController;
  const BottomSheetLogin({
    Key? key,
    required this.registerController,
  }) : super(key: key);

  @override
  State<BottomSheetLogin> createState() => _BottomSheetLoginState();
}

class _BottomSheetLoginState extends State<BottomSheetLogin> {
  bool isEmail = false;
  bool isPassword = false;
  bool isLoading = false;

  postLogin() async {
    setState(() {
      isLoading = true;
    });

    await widget.registerController.postDataLogin();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400.h,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 16.h),
            height: 4.h,
            width: 50.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: const Color(0XFFE8E8E8),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          const Text(
            "Silahkan Login Terlebih Dahulu",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 45.w),
            child: const Text(
              "Pastikan untuk memasukkan email dan password yang sudah terdaftar dengan benar.",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 45.w),
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              border: Border.all(
                color: isEmail == true ? AppColor.green : AppColor.grey800,
              ),
            ),
            child: TextField(
              onTap: () {
                setState(() {
                  isEmail = true;
                  isPassword = false;
                });
              },
              decoration: InputDecoration(
                disabledBorder: InputBorder.none,
                border: InputBorder.none,
                hintText: "Alamat Email",
                hintStyle: const TextStyle(
                  color: Color(0XFFE8E8E8),
                  fontSize: 12,
                ),
                prefixIcon: Image.asset(
                  "assets/ic_email.png",
                  color: isEmail == true ? AppColor.green : AppColor.grey800,
                ),
              ),
              onChanged: (val) {
                widget.registerController.emailLogin.text = val;
              },
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 45.w),
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              border: Border.all(
                color: isPassword == true ? AppColor.green : AppColor.grey800,
              ),
            ),
            child: TextField(
              onTap: () {
                setState(() {
                  isPassword = true;
                  isEmail = false;
                });
              },
              decoration: InputDecoration(
                disabledBorder: InputBorder.none,
                border: InputBorder.none,
                hintText: "Password",
                hintStyle: const TextStyle(
                  color: Color(0XFFE8E8E8),
                  fontSize: 12,
                ),
                prefixIcon: Image.asset(
                  "assets/ic_password.png",
                  height: 10.h,
                  color: isPassword == true ? AppColor.green : AppColor.grey800,
                ),
              ),
              onChanged: (val) {
                widget.registerController.passwordLogin.text = val;
              },
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          InkWell(
            onTap: () {
              Get.to(const RegistrasiScreen());
            },
            child: RichText(
              text: const TextSpan(
                text: "Belum Punya Akun ? ",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: "Daftar",
                      style: TextStyle(
                          color: AppColor.green, fontWeight: FontWeight.bold))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 32.h,
          ),
          Builder(builder: (_) {
            if (isLoading == true) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child:
                    ShimmerHome(h: 60.h, w: MediaQuery.of(context).size.width),
              );
            } else {
              return InkWell(
                onTap: () async {
                  await postLogin();
                  if (widget.registerController.postLogin!.status != 0) {
                    await Prefence().setStatusLogin();
                    await Prefence()
                        .saveDataLogin(widget.registerController.postLogin!);
                    Get.to(BottomNavBarScreen());
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 45),
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.w, vertical: 18.h),
                  decoration: BoxDecoration(
                    color: AppColor.green,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Masuk",
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
              );
            }
          })
        ],
      ),
    );
  }
}
