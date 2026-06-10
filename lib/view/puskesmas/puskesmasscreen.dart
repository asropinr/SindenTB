import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:sinden_tb_app/constan/color.dart';
import 'package:sinden_tb_app/controller/artikel_controller.dart';
import 'package:sinden_tb_app/view/puskesmas/bottom_sheet_puskesmas.dart';

class PuskesmasListScreen extends StatefulWidget {
  const PuskesmasListScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PuskesmasListScreen> createState() => _PuskesmasListScreenState();
}

class _PuskesmasListScreenState extends State<PuskesmasListScreen>
    with WidgetsBindingObserver {
  ArtikelController artikelController = Get.find<ArtikelController>();
  bool isLoading = true;
  Position? position;
  String? lat;
  String? long;
  LocationPermission? permission;
  bool _fromSetting = false;

  getData() async {
    setState(() {
      isLoading = true;
    });

    await getLocation();

    if (lat == null || long == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    await artikelController.getListPusLongLat(
      lat!,
      long!,
    );

    setState(() {
      isLoading = false;
    });
  }

  getLocation() async {
    Position? position = await _determinePosition();

    if (position == null) return;

    setState(() {
      position = position;
      lat = position!.latitude.toString();
      long = position!.longitude.toString();
    });
  }

  Future<Position?> _determinePosition() async {
    // Cek permission dulu
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          _showPermissionBottomSheet();
          return null;
        }
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showPermissionBottomSheet();
      return null;
    }

    // Baru cek GPS
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      _showGpsBottomSheet();
      return null;
    }

    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
    );

    return await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );
  }

  void _showPermissionBottomSheet() {
    Get.bottomSheet(
      BottomSheetPuskesmas(
        title: "Izin Lokasi Dibutuhkan",
        message:
            "Aktifkan izin lokasi agar kami dapat menampilkan puskesmas terdekat.",
        onTap: () async {
          _fromSetting = true;

          Get.back();

          await Geolocator.openAppSettings();
        },
      ),
      isDismissible: false,
      enableDrag: false,
    );
  }

  void _showGpsBottomSheet() {
    Get.bottomSheet(
      BottomSheetPuskesmas(
        title: "GPS Belum Aktif",
        message: "Aktifkan GPS untuk membantu mendapatkan puskesmas terdekat.",
        onTap: () async {
          _fromSetting = true;

          Get.back();

          await Geolocator.openLocationSettings();
        },
      ),
      isDismissible: false,
      enableDrag: false,
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    getData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _fromSetting) {
      _fromSetting = false;

      getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColor.accentGreen,
        appBar: AppBar(
          backgroundColor: AppColor.accentGreen,
          elevation: 0,
          title: const Text(
            "List Puskesmas",
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
                children: [
                  SizedBox(
                    height: 32.h,
                  ),
                  ...List.generate(
                    artikelController.getListPuskesmaslonglat!.data!.length,
                    (index) => InkWell(
                      onTap: () {
                        MapsLauncher.launchCoordinates(
                          double.parse(artikelController
                              .getListPuskesmaslonglat!.data![index].latitude!),
                          double.parse(artikelController
                              .getListPuskesmaslonglat!
                              .data![index]
                              .longitude!),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.green.withValues(alpha: 0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12)),
                                  child: Image.asset(
                                    "assets/image 16.png",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColor.lightGreen,
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(2.w),
                                        topLeft: Radius.circular(4.w),
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(4),
                                    child: Text(
                                      artikelController.getListPuskesmaslonglat!
                                          .data![index].distance!,
                                      style: const TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    artikelController.getListPuskesmaslonglat!
                                        .data![index].nama!,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Text(
                                    artikelController.getListPuskesmaslonglat!
                                        .data![index].alamat!,
                                    style: const TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.grey700,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5.h, horizontal: 8.w),
                                    decoration: BoxDecoration(
                                      color: AppColor.lightGreen,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.map_outlined,
                                              color: AppColor.green,
                                            ),
                                            SizedBox(
                                              width: 4.w,
                                            ),
                                            const Text(
                                              "Lihat di Maps",
                                              style: TextStyle(
                                                fontSize: 8,
                                                fontWeight: FontWeight.w400,
                                                color: AppColor.green,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Image.asset(
                                          "assets/ic_arrow_for.png",
                                          height: 10.h,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
