import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sinden_tb_app/constan/color.dart';
import 'package:sinden_tb_app/model/artikel/getartikel_model.dart';

class DetailArtikelScreen extends StatefulWidget {
  final DataArtikel data;
  const DetailArtikelScreen({super.key, required this.data});

  @override
  State<DetailArtikelScreen> createState() => _DetailArtikelScreenState();
}

class _DetailArtikelScreenState extends State<DetailArtikelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.accentGreen,
      appBar: AppBar(
        backgroundColor: AppColor.accentGreen,
        elevation: 0,
        title: const Text(
          "Detail Artikel",
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
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4.w),
            child: SizedBox(
              height: 200.h,
              child: Image.network(
                widget.data.bannerImage!,
              ),
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            DateFormat(
              "dd MMMM y",
            ).format(
              DateTime.parse(widget.data.postDate!),
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
            widget.data.blogTitle!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColor.brown,
            ),
            maxLines: 2,
          ),
          Html(
            data: widget.data.blog,
          ),
          SizedBox(
            height: 30.h,
          ),
        ],
      ),
    );
  }
}
