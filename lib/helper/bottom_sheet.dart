import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sinden_tb_app/constan/color.dart';

class BottomSheetCard extends StatefulWidget {
  final String image;
  final String message;
  const BottomSheetCard({
    Key? key,
    required this.image,
    required this.message,
  }) : super(key: key);

  @override
  State<BottomSheetCard> createState() => _BottomSheetCardState();
}

class _BottomSheetCardState extends State<BottomSheetCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.w),
          topRight: Radius.circular(16.w),
        ),
      ),
      height: MediaQuery.of(context).size.height * .6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            widget.image,
            height: 100.h,
            color: Colors.red,
          ),
          SizedBox(
            height: 40.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              widget.message,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          // InkWell(
          //   onTap: () async {
          //     Get.back();
          //   },
          //   child: Container(
          //     margin: const EdgeInsets.symmetric(horizontal: 32),
          //     padding: EdgeInsets.symmetric(vertical: 12.h),
          //     width: MediaQuery.of(context).size.width,
          //     decoration: BoxDecoration(
          //       color: AppColor.green,
          //       borderRadius: BorderRadius.circular(100),
          //     ),
          //     child: const Text(
          //       "Kembali",
          //       style: TextStyle(
          //         fontSize: 18,
          //         fontWeight: FontWeight.w400,
          //         color: Colors.white,
          //       ),
          //       textAlign: TextAlign.center,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
