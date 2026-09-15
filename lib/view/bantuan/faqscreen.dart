import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sinden_tb_app/constan/color.dart';
import 'package:sinden_tb_app/constan/preference.dart';
import 'package:sinden_tb_app/controller/faq_controller.dart';
import 'package:sinden_tb_app/view/auth/loginscreen.dart';
import 'package:sinden_tb_app/view/bantuan/detailfaqtopikscreen.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  FaqController faqController = Get.find<FaqController>();

  bool isloading = true;

  Future<void> getData(bool refresh) async {
    var status = await Prefence().getStatusLogin();
    if (status == true) {
      final hasData = faqController.getListFaq?.data?.isNotEmpty ?? false;
      if (refresh == false) {
        if (hasData) {
          isloading = false;
          return;
        }
      }

      setState(() {
        isloading = true;
      });

      await faqController.getFaqList();

      setState(() {
        isloading = false;
      });
    } else {
      isloading = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getData(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Pusat Bantuan',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return getData(true);
          },
          child: Builder(
            builder: (context) {
              if (isloading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (faqController.getListFaq == null) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 32),
                  padding: EdgeInsets.all(32),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0XFFBFC9BF)),
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.green.withValues(alpha: 0.2)),
                        child: Icon(
                          Icons.lock_outline_rounded,
                          size: 30,
                          color: AppColor.green,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      const Text(
                        "Akses Terbatas",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const Text(
                        "Masuk ke akun Anda untuk mengakses fitur Skrining mandiri dan Chatbox",
                        style:
                            TextStyle(fontSize: 14, color: Color(0XFF404941)),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return LoginScreen();
                              },
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                              color: AppColor.green,
                              borderRadius: BorderRadius.circular(100)),
                          child: Text(
                            "Login / Masuk",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      _popularQuestions(faqController),
                      //_customerSupport(),
                      // _footerLinks(),
                      SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                );
              }
            },
          ),
        ));
  }

  // Widget _searchSection() {
  Widget _popularQuestions(FaqController controller) {
    // final questions = [
    //   "Apa itu TB dan bagaimana penularannya?",
    //   "Apa gejala umum penyakit TB?",
    //   "Bagaimana cara minum obat TB yang benar?",
    //   "Apakah TB dapat disembuhkan?",
    //   "Apa yang harus dilakukan jika lupa minum obat?",
    // ];

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Jelajahi Kategori FAQ",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),
          ...controller.getListFaq!.data!.map(
            (e) => Container(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e.category!,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ...e.faqs!.map(
                    (ee) => InkWell(
                      onTap: () {
                        Get.to(Detailfaqtopikscreen(
                          answer: ee.answer ?? "Tidak ada data",
                        ));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                ee.question!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right,
                            color: Colors.pink,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _customerSupport() {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF7F4FA),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Hubungi Customer Support",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Kami siap membantu Anda.",
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _supportButton(
                Icons.chat,
                "Chat Sekarang",
              ),
              _supportButton(
                Icons.email,
                "Kirim Email",
              ),
              _supportButton(
                Icons.call,
                "Telepon",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _supportButton(
    IconData icon,
    String label,
  ) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.pink,
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _footerLinks() {
    final links = [
      "Ketentuan Penggunaan",
      "Kebijakan Privasi",
    ];

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: links.map((e) {
          return ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(e),
            trailing: const Icon(
              Icons.chevron_right,
            ),
            onTap: () {},
          );
        }).toList(),
      ),
    );
  }
}
