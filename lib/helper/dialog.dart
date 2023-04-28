import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sinden_tb_app/constan/color.dart';

class DialogError extends StatefulWidget {
  final String title;
  final String message;
  final bool? puskesmas;
  const DialogError({
    Key? key,
    required this.title,
    required this.message,
    this.puskesmas,
  }) : super(key: key);

  @override
  State<DialogError> createState() => _DialogErrorState();
}

class _DialogErrorState extends State<DialogError> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 300.h,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 40),
        child: Column(
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontFamily: "Calibri",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.message,
              style: const TextStyle(
                fontFamily: "Calibri",
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                if (widget.puskesmas == true) {
                  Get.back();
                  Get.back();
                } else {
                  Get.back();
                }
              },
              child: Container(
                color: AppColor.green,
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 40,
                ),
                child: const Text(
                  "Ok",
                  style: TextStyle(
                    fontFamily: "Calibri",
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SnacbarDialog extends StatefulWidget {
  final String message;
  const SnacbarDialog({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  State<SnacbarDialog> createState() => _SnacbarDialogState();
}

class _SnacbarDialogState extends State<SnacbarDialog> {
  @override
  Widget build(BuildContext context) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50))),
      margin: const EdgeInsets.only(left: 50, right: 50, bottom: 120),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.beenhere_outlined,
            size: 20,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            widget.message,
            style: const TextStyle(
              fontFamily: "Calibri",
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
