import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sinden_tb_app/constan/color.dart';
import 'package:sinden_tb_app/constan/preference.dart';
import 'package:sinden_tb_app/constan/shimmer.dart';
import 'package:sinden_tb_app/controller/register_controller.dart';
import 'package:sinden_tb_app/model/register/postlogin_model.dart';

class EditProfileScreen extends StatefulWidget {
  final PostLogin postLogin;
  const EditProfileScreen({
    Key? key,
    required this.postLogin,
  }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  RegisterController registerController = Get.put(RegisterController());

  TextEditingController email = TextEditingController();
  TextEditingController namaLengkap = TextEditingController();
  TextEditingController asalSekolah = TextEditingController();
  TextEditingController noWa = TextEditingController();
  TextEditingController alamatLengkap = TextEditingController();
  TextEditingController alamatPuskesmas = TextEditingController();

  bool isLoading = true;
  bool isKab = false;
  bool isKec = false;
  bool isKel = false;
  bool isPuskes = false;
  String? puskesmas;
  Map<String, dynamic> payload = {};
  String? photo;

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

  setData() async {
    email.text = widget.postLogin.data!.userEmail!;
    namaLengkap.text = widget.postLogin.data!.userName!;
    asalSekolah.text = widget.postLogin.data!.userUniversity!;
    noWa.text = widget.postLogin.data!.userPhone!;
    alamatLengkap.text = widget.postLogin.data!.userAddress!;
    alamatPuskesmas.text = widget.postLogin.data!.userPuskesmas!;
    registerController.email.text = widget.postLogin.data!.userEmail!;
    registerController.namaLengkap.text = widget.postLogin.data!.userName!;
    registerController.asalSekolah.text =
        widget.postLogin.data!.userUniversity!;
    registerController.noWa.text = widget.postLogin.data!.userPhone!;
    registerController.alamatLengkap.text = widget.postLogin.data!.userAddress!;
    registerController.alamatPuskesmas.text =
        widget.postLogin.data!.userPuskesmas!;
    registerController.selectedDate =
        DateTime.parse(widget.postLogin.data!.dob!);
    registerController.idProv = widget.postLogin.data!.uProvinsiId;
    await registerController
        .getListKabupaten(registerController.idProv!)
        .then((value) {
      registerController.getKabupaten?.data?.forEach((element) {
        if (element.idKab == widget.postLogin.data!.uKabupatenId) {
          registerController.idKab = element.idKab;
        }
      });
    });

    await registerController
        .getListKecamatan(registerController.idKab!)
        .then((value) {
      registerController.getKecamatan?.data?.forEach((element) {
        if (element.idKec == widget.postLogin.data!.uKecamatanId) {
          registerController.idKec = element.idKec;
        }
      });
    });

    await registerController
        .getListKelurahan(widget.postLogin.data!.uKecamatanId!)
        .then((value) {
      registerController.getKelurahan?.data?.forEach((element) {
        if (element.idKel == widget.postLogin.data!.uKelurahanId) {
          registerController.idKel = element.idKel;
        }
      });
    });
  }

  getDataProvinsi() async {
    setState(() {
      isLoading = true;
    });

    await setData();
    await registerController.getListProvinsi();

    setState(() {
      isLoading = false;
    });
  }

  postUpdate() async {
    setState(() {
      isLoading = true;
    });

    await registerController.postUpdate();

    setState(() {
      isLoading = false;
    });
  }

  pickImage() async {
    setState(() {
      isLoading = true;
    });

    await registerController.pickImage();

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
            "Update Profile",
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
        body: Builder(builder: (_) {
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
                InkWell(
                  onTap: () {
                    pickImage();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      registerController.pathImage?.path != null
                          ? Stack(
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
                                    child: Image.file(
                                      File(registerController.pathImage!.path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColor.green,
                                      borderRadius: BorderRadius.circular(4.w),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w, vertical: 4.h),
                                    child: const Text(
                                      "Edit",
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Stack(
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
                                      widget.postLogin.data!.userFoto!,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, url, error) =>
                                          ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(14.w),
                                        child: Image.asset(
                                          "assets/user_image.png",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColor.green,
                                      borderRadius: BorderRadius.circular(4.w),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w, vertical: 4.h),
                                    child: const Text(
                                      "Edit",
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                //Text(registerController.formData?.files.toString() ?? "no"),
                _buildTextFieldItem(
                    itemTitle: "Alamat email",
                    hintText: "Masukkan alamat email",
                    controller: email,
                    enabled: false,
                    onChange: (val) {
                      registerController.email.text = val;
                    }),
                _buildTextFieldItem(
                    itemTitle: "Nama Lengkap",
                    hintText: "Masukkan Nama Lengkap Sesuai KTP",
                    controller: namaLengkap,
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
                    controller: asalSekolah,
                    onChange: (val) {
                      registerController.asalSekolah.text = val;
                    }),
                _buildTextFieldItem(
                    itemTitle: "No WhatsApp",
                    hintText: "Masukkan No WhatsApp",
                    controller: noWa,
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
                              registerController.idProv = null;
                              registerController.idKab = null;
                              registerController.idKec = null;
                              registerController.idKel = null;
                              registerController.idProv = val;

                              setState(() {
                                isKab = true;
                              });
                              await registerController
                                  .getListKabupaten(registerController.idProv!);
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
                                    registerController.idKab = null;
                                    registerController.idKec = null;
                                    registerController.idKel = null;
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
                                    registerController.idKel = null;
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
                                  controller: alamatLengkap,
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
                      Column(
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
                                controller: alamatPuskesmas,
                                decoration: const InputDecoration(
                                  disabledBorder: InputBorder.none,
                                  border: InputBorder.none,
                                  hintText: "Masukkan Alamat Puskesmas",
                                  hintStyle: TextStyle(
                                    color: AppColor.grey800,
                                    fontSize: 12,
                                  ),
                                ),
                                onChanged: (val) {
                                  registerController.alamatPuskesmas.text = val;
                                }),
                          ),
                          SizedBox(height: 16.h),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                InkWell(
                  onTap: () async {
                    //Get.to(BottomNavBarScreen());
                    // if (registerController.pathImage == null) {
                    //   photo = widget.postLogin.data!.userFoto!;
                    // } else {
                    //   photo = registerController.pathImage!.path;
                    // }
                    // payload = {
                    //   "user_name": registerController.namaLengkap.text,
                    //   "user_email": registerController.email.text,
                    //   "user_phone": registerController.noWa.text,
                    //   "user_address": registerController.alamatLengkap.text,
                    //   "user_university": registerController.asalSekolah.text,
                    //   "dob": DateFormat(
                    //     "y-m-d",
                    //   ).format(
                    //     registerController.selectedDate!,
                    //   ),
                    //   "u_provinsi_id": registerController.idProv,
                    //   "u_kabupaten_id": registerController.idKab,
                    //   "u_kecamatan_id": registerController.idKec,
                    //   "u_kelurahan_id": registerController.idKel,
                    //   "foto": await dio.MultipartFile.fromFile(
                    //       registerController.pic!.path,
                    //       filename:
                    //           registerController.pic!.path.split("/").last),
                    //   "user_puskesmas": registerController.alamatPuskesmas.text,
                    //   "gender": registerController.jenisKelamin,
                    // };

                    await postUpdate();
                    if (registerController.postLogin!.status == 1) {
                      await Prefence()
                          .saveDataLogin(registerController.postLogin!);
                      setState(() {
                        registerController.pathImage = null;
                      });
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
                      "Update Akun",
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
        }));
  }

  Container _buildTextFieldItem(
      {required String itemTitle,
      required String hintText,
      required TextEditingController controller,
      Function(String)? onChange,
      bool enabled = true}) {
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
                enabled: enabled,
                controller: controller,
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
