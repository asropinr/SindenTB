import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sinden_tb_app/constan/color.dart';
import 'package:sinden_tb_app/constan/shimmer.dart';
import 'package:sinden_tb_app/controller/register_controller.dart';

class RegistrasiScreen extends StatefulWidget {
  const RegistrasiScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<RegistrasiScreen> createState() => _RegistrasiScreenState();
}

class _RegistrasiScreenState extends State<RegistrasiScreen> {
  RegisterController registerController = Get.find<RegisterController>();

  bool isLoading = true;
  bool isKab = false;
  bool isKec = false;
  bool isKel = false;
  bool isPuskes = false;
  String? puskesmas;
  Map<String, dynamic> payload = {};

  selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1000),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        registerController.selectedDate = picked;
      });
    }
  }

  getDataProvinsi() async {
    setState(() {
      isLoading = true;
    });

    await registerController.getListProvinsi();

    setState(() {
      isLoading = false;
    });
  }

  postRegister(payload) async {
    setState(() {
      isLoading = true;
    });

    await registerController.postDataRegister(payload);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataProvinsi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.accentGreen,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.accentGreen,
        title: const Text(
          "Registrasi Akun",
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: const Text(
                    "Isikan data diri kamu sesuai dengan data di bawah ini :",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColor.brown,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 32.h,
                ),
                _buildTextFieldItem(
                    itemTitle: "Alamat email",
                    hintText: "Masukkan alamat email",
                    controller: registerController.email,
                    onChange: (val) {
                      registerController.email.text = val;
                    }),
                _buildTextFieldItem(
                    itemTitle: "Password",
                    hintText: "Masukkan Password",
                    controller: registerController.password,
                    onChange: (val) {
                      registerController.password.text = val;
                    }),
                _buildTextFieldItem(
                    itemTitle: "Nama Lengkap",
                    hintText: "Masukkan Nama Lengkap Sesuai KTP",
                    controller: registerController.namaLengkap,
                    onChange: (val) {
                      registerController.namaLengkap.text = val;
                    }),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Tanggal Lahir",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColor.brown,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          selectDate();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 16.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            border: Border.all(
                              color: AppColor.grey700,
                            ),
                          ),
                          child: Text(
                            registerController.selectedDate == null
                                ? "Pilih Tanggal Lahir Kamu"
                                : DateFormat(
                                    "dd MMMM y",
                                  ).format(
                                    // DateTime.parse(controller
                                    //     .articleRes!.data![index].dateCreate),
                                    registerController.selectedDate!,
                                  ),
                            style: const TextStyle(
                              color: AppColor.grey800,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Jenis Kelamin",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColor.brown,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                registerController.jenisKelamin = "laki-laki";
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: registerController.jenisKelamin ==
                                          "laki-laki"
                                      ? AppColor.green
                                      : AppColor.grey700,
                                ),
                                color: registerController.jenisKelamin ==
                                        "laki-laki"
                                    ? AppColor.green
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(4.w),
                              ),
                              width: 160.w,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "Laki - Laki",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: registerController.jenisKelamin ==
                                          "laki-laki"
                                      ? Colors.white
                                      : AppColor.grey700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                registerController.jenisKelamin = "perempuan";
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: registerController.jenisKelamin ==
                                          "perempuan"
                                      ? AppColor.green
                                      : AppColor.grey700,
                                ),
                                color: registerController.jenisKelamin ==
                                        "perempuan"
                                    ? AppColor.green
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(4.w),
                              ),
                              width: 160.w,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "Perempuan",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: registerController.jenisKelamin ==
                                          "perempuan"
                                      ? Colors.white
                                      : AppColor.grey700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                    ],
                  ),
                ),
                _buildTextFieldItem(
                    itemTitle: "Asal Sekolah / Universitas",
                    hintText: "Masukkan Asal Sekolah / Universitas",
                    controller: registerController.asalSekolah,
                    onChange: (val) {
                      registerController.asalSekolah.text = val;
                    }),
                _buildTextFieldItem(
                    itemTitle: "No WhatsApp",
                    hintText: "Masukkan No WhatsApp",
                    controller: registerController.noWa,
                    onChange: (val) {
                      registerController.noWa.text = val;
                    }),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Provinsi Domisili",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColor.brown,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          border: Border.all(
                            color: AppColor.grey700,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            icon: const Icon(Icons.keyboard_arrow_down),
                            isExpanded: true,
                            hint: const Text(
                              "Pilih Provinsi Kamu",
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColor.grey800,
                              ),
                            ),
                            items: registerController.getProvinsi == null
                                ? []
                                : registerController.getProvinsi!.data!
                                    .map((e) => DropdownMenuItem(
                                          value: e.idProv,
                                          child: Text(
                                            e.nama!,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.grey800,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                            value: registerController.idProv,
                            onChanged: (String? val) async {
                              registerController.idProv = val;

                              setState(() {
                                isKab = true;
                              });
                              await registerController.getListKabupaten(val!);
                              setState(() {
                                isKab = false;
                              });
                              // registrationController.payload.kelas = val;
                              // registrationController.setClassFK();
                              // setState(() {});
                              // validation();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                isKab == true
                    ? ShimmerHome(h: 20.h, w: MediaQuery.of(context).size.width)
                    : Container(
                        padding: EdgeInsets.symmetric(horizontal: 32.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Kabupaten Domisili",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColor.brown,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                                border: Border.all(
                                  color: AppColor.grey700,
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  isExpanded: true,
                                  hint: const Text(
                                    "Pilih Kabupaten Kamu",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColor.grey800,
                                    ),
                                  ),
                                  items: registerController.getKabupaten == null
                                      ? []
                                      : registerController.getKabupaten!.data!
                                          .map((e) => DropdownMenuItem(
                                                value: e.idKab,
                                                child: Text(
                                                  e.namaKab!,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColor.grey800,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                  value: registerController.idKab,
                                  onChanged: (String? val) async {
                                    registerController.idKab = val;
                                    registerController.setKabupaten();
                                    setState(() {
                                      isKec = true;
                                    });
                                    await registerController
                                        .getListKecamatan(val!);
                                    setState(() {
                                      isKec = false;
                                    });
                                    // registrationController.payload.kelas = val;
                                    // registrationController.setClassFK();
                                    // setState(() {});
                                    // validation();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                SizedBox(
                  height: 16.h,
                ),
                isKec == true
                    ? ShimmerHome(h: 20.h, w: MediaQuery.of(context).size.width)
                    : Container(
                        padding: EdgeInsets.symmetric(horizontal: 32.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Kecamatan Domisili",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColor.brown,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                                border: Border.all(
                                  color: AppColor.grey700,
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  isExpanded: true,
                                  hint: const Text(
                                    "Pilih Kecamatan Kamu",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColor.grey800,
                                    ),
                                  ),
                                  items: registerController.getKecamatan == null
                                      ? []
                                      : registerController.getKecamatan!.data!
                                          .map((e) => DropdownMenuItem(
                                                value: e.idKec,
                                                child: Text(
                                                  e.nama!,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColor.grey800,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                  value: registerController.idKec,
                                  onChanged: (String? val) async {
                                    registerController.idKec = val;

                                    setState(() {
                                      isKel = true;
                                    });
                                    await registerController
                                        .getListKelurahan(val!);
                                    setState(() {
                                      isKel = false;
                                    });
                                    // registrationController.payload.kelas = val;
                                    // registrationController.setClassFK();
                                    // setState(() {});
                                    // validation();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                SizedBox(
                  height: 16.h,
                ),
                isKel == true
                    ? ShimmerHome(h: 20.h, w: MediaQuery.of(context).size.width)
                    : Container(
                        padding: EdgeInsets.symmetric(horizontal: 32.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Kelurahan Domisili",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColor.brown,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                                border: Border.all(
                                  color: AppColor.grey700,
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  isExpanded: true,
                                  hint: const Text(
                                    "Pilih Kelurahan Kamu",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColor.grey800,
                                    ),
                                  ),
                                  items: registerController.getKelurahan == null
                                      ? []
                                      : registerController.getKelurahan!.data!
                                          .map((e) => DropdownMenuItem(
                                                value: e.idKel,
                                                child: Text(
                                                  e.nama!,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColor.grey800,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                  value: registerController.idKel,
                                  onChanged: (String? val) async {
                                    registerController.idKel = val;
                                    setState(() {
                                      isPuskes = true;
                                    });
                                    await registerController
                                        .getListPuskesmasByKota();

                                    setState(() {
                                      isPuskes = false;
                                    });
                                    // registrationController.payload.kelas = val;
                                    // registrationController.setClassFK();
                                    // setState(() {});
                                    // validation();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                SizedBox(
                  height: 16.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 32.h),
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                      color: AppColor.green,
                      borderRadius: BorderRadius.circular(4.w)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Informasi Domisili",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      const Text(
                        "Silahkan masukkan alamat lengkap anda sesuai dengan domisisili anda berada",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Alamat Lengkap",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                              height: 150.h,
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                                border: Border.all(
                                  color: AppColor.grey700,
                                ),
                              ),
                              child: TextField(
                                  maxLines: 5,
                                  cursorColor: AppColor.green,
                                  //enabled: enabled,
                                  //controller: registerController.alamatLengkap,
                                  decoration: const InputDecoration(
                                    disabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    hintText: "Masukkan Alamat Lengkap",
                                    hintStyle: TextStyle(
                                      color: AppColor.grey800,
                                      fontSize: 12,
                                    ),
                                  ),
                                  onChanged: (val) {
                                    registerController.alamatLengkap.text = val;
                                  })),
                          SizedBox(height: 16.h),
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                registerController.isLainnya = false;
                              });
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 20.h,
                                  width: 20.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: registerController.isLainnya == false
                                        ? AppColor.brown
                                        : Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                const Text(
                                  "Rekomendasi",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 30.w,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                registerController.isLainnya = true;
                              });
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 20.h,
                                  width: 20.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: registerController.isLainnya == true
                                        ? AppColor.brown
                                        : Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                const Text(
                                  "Lainnya",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Builder(builder: (_) {
                        if (registerController.isLainnya == false) {
                          return isPuskes == true
                              ? ShimmerHome(
                                  h: 20.h, w: MediaQuery.of(context).size.width)
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Alamat Puskesmas",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    registerController.getPuskesmas?.status == 0
                                        ? Text(
                                            "Silahkan Pilih Opsi lainnya Untuk menuliskan Data Puskesmas Anda")
                                        : Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.w),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Colors.white,
                                              border: Border.all(
                                                color: AppColor.grey700,
                                              ),
                                            ),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                icon: const Icon(
                                                    Icons.keyboard_arrow_down),
                                                isExpanded: true,
                                                hint: const Text(
                                                  "Pilih Puskesmas Kamu",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: AppColor.grey800,
                                                  ),
                                                ),
                                                items: registerController
                                                            .getPuskesmas ==
                                                        null
                                                    ? []
                                                    : registerController
                                                        .getPuskesmas!.data!
                                                        .map((e) =>
                                                            DropdownMenuItem(
                                                              value: e.nama,
                                                              child: Text(
                                                                e.nama!,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: AppColor
                                                                      .grey800,
                                                                ),
                                                              ),
                                                            ))
                                                        .toList(),
                                                value: registerController
                                                    .puskesmas,
                                                onChanged: (String? val) async {
                                                  registerController.puskesmas =
                                                      val;
                                                  setState(() {});

                                                  // registrationController.payload.kelas = val;
                                                  // registrationController.setClassFK();
                                                  // setState(() {});
                                                  // validation();
                                                },
                                              ),
                                            ),
                                          ),
                                  ],
                                );
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Alamat Puskesmas",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                height: 150.h,
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: AppColor.grey700,
                                  ),
                                ),
                                child: TextField(
                                    maxLines: 5,
                                    cursorColor: AppColor.green,
                                    //enabled: enabled,
                                    // controller:
                                    //     registerController.alamatPuskesmas,
                                    decoration: const InputDecoration(
                                      disabledBorder: InputBorder.none,
                                      border: InputBorder.none,
                                      hintText: "Masukkan Alamat Puskesmas",
                                      hintStyle: const TextStyle(
                                        color: AppColor.grey800,
                                        fontSize: 12,
                                      ),
                                    ),
                                    onChanged: (val) {
                                      registerController.alamatPuskesmas.text =
                                          val;
                                    }),
                              ),
                              SizedBox(height: 16.h),
                            ],
                          );
                        }
                      }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                InkWell(
                  onTap: () async {
                    //Get.to(BottomNavBarScreen());
                    if (registerController.isLainnya == false) {
                      puskesmas = registerController.puskesmas!;
                    } else {
                      puskesmas = registerController.alamatPuskesmas.text;
                    }
                    payload = {
                      "user_name": registerController.namaLengkap.text,
                      "user_email": registerController.email.text,
                      "user_phone": registerController.noWa.text,
                      "user_password": registerController.password.text,
                      "user_address": registerController.alamatLengkap.text,
                      "user_university": registerController.asalSekolah.text,
                      "dob": DateFormat(
                        "y-m-d",
                      ).format(
                        registerController.selectedDate!,
                      ),
                      "u_provinsi_id": registerController.idProv,
                      "u_kabupaten_id": registerController.idKab,
                      "u_kecamatan_id": registerController.idKec,
                      "u_kelurahan_id": registerController.idKel,
                      "user_puskesmas": puskesmas,
                      "gender": registerController.jenisKelamin,
                    };

                    await postRegister(payload);
                    if (registerController.postRegister!.status == 1) {
                      Get.back();
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    padding: EdgeInsets.symmetric(vertical: 18.h),
                    decoration: BoxDecoration(
                      color: AppColor.green,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Text(
                      "Daftar Akun",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Container _buildTextFieldItem({
    required String itemTitle,
    required String hintText,
    required TextEditingController controller,
    Function(String)? onChange,
    //bool enabled = true
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            itemTitle,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColor.brown,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              border: Border.all(
                color: AppColor.grey700,
              ),
            ),
            child: TextField(
                cursorColor: AppColor.green,
                //enabled: enabled,
                //controller: controller,
                decoration: InputDecoration(
                  disabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    color: AppColor.grey800,
                    fontSize: 12,
                  ),
                ),
                onChanged: onChange),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
