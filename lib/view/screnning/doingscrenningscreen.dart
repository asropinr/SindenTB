import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sinden_tb_app/constan/color.dart';
import 'package:sinden_tb_app/constan/preference.dart';
import 'package:sinden_tb_app/controller/skrining_controller.dart';
import 'package:sinden_tb_app/model/register/postlogin_model.dart';
import 'package:sinden_tb_app/view/screnning/resultscreen.dart';

class DoingScrenningScrenn extends StatefulWidget {
  const DoingScrenningScrenn({super.key});

  @override
  State<DoingScrenningScrenn> createState() => _DoingScrenningScrennState();
}

class _DoingScrenningScrennState extends State<DoingScrenningScrenn>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  SkriningController skriningController = Get.find<SkriningController>();
  PostLogin? postLogin;
  bool isLoading = true;
  TabController? controller;
  List<String> questionId = [];
  List<String> answer = [];

  //String? isSelected;

  Future getUserId() async {
    postLogin = await Prefence().getDataLogin();
    return postLogin!.data!.userId;
  }

  getData() async {
    setState(() {
      isLoading = true;
    });

    await skriningController.getSoal();

    setState(() {
      isLoading = false;
    });
  }

  setDataAnswer() async {
    questionId.clear();
    answer.clear();
    for (var element in skriningController.getSoalSkrining!.data!) {
      questionId.add(element.questionId!);
      answer.add(element.jawaban!);
    }
  }

  postJawaban() async {
    setState(() {
      isLoading = true;
    });

    final userId = await getUserId();
    await skriningController.postJawaban(userId, questionId, answer);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getData();
      controller = TabController(
          length: skriningController.getSoalSkrining!.data!.length,
          vsync: this);
      controller?.addListener(() {
        if (controller!.indexIsChanging) {
          // print(
          //     "tab is animating. from active (getting the index) to inactive(getting the index) ");
        } else {
          setState(() {});
          // print('payload');
          // print(jsonEncode(payload));
          // if (willSend) tryout.postTryInputJawaban(payload);
          // if (willSend) print("Masuk nih");

        }
      });
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.accentGreen,
        appBar: AppBar(
          backgroundColor: AppColor.accentGreen,
          elevation: 0,
          title: const Text(
            "Screning",
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
            return Stack(
              children: [
                Column(
                  children: [
                    TabBar(
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: Colors.transparent,
                        controller: controller,
                        labelPadding: EdgeInsets.symmetric(horizontal: 8.w),
                        isScrollable: true,
                        tabs: List.generate(
                            skriningController.getSoalSkrining!.data!.length,
                            (index) {
                          final jawaban = skriningController
                              .getSoalSkrining!.data![index].jawaban;
                          return Container(
                            margin: EdgeInsets.only(
                                left: index == 0 ? 24.w : 0,
                                right: index ==
                                        skriningController
                                                .getSoalSkrining!.data!.length -
                                            1
                                    ? 24.w
                                    : 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.w),
                              color: jawaban == "X"
                                  ? index == controller!.index
                                      ? AppColor.grey500
                                      : Colors.transparent
                                  : AppColor.green,
                            ),
                            width: 50.w,
                            height: 50.h,
                            child: Center(
                              child: Text(
                                "${index + 1}",
                                style: TextStyle(
                                    color: jawaban == "X"
                                        ? Colors.black
                                        : Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }).toList()),
                    Expanded(
                      child: SafeArea(
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: controller,
                          children: List.generate(
                            skriningController.getSoalSkrining!.data!.length,
                            (indexx) => SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 32.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 18.h,
                                    ),
                                    Text("Soal ${indexx + 1}"),
                                    // SizedBox(
                                    //   height: 18.h,
                                    // ),
                                    // ClipRRect(
                                    //   borderRadius: BorderRadius.circular(4.w),
                                    //   child: SizedBox(
                                    //     height: 170.h,
                                    //     width:
                                    //         MediaQuery.of(context).size.width,
                                    //     child: Image.network(
                                    //       'https://s3-alpha-sig.figma.com/img/09bb/4f2f/d5eccb23e96160045e863a869476c8e8?Expires=1681689600&Signature=N-D-U3pePlFqoEvp-WlrnOIHKKYDvso027Wcy8NNlKcNvAIX3PrQ09id~O71FziAPvEvuLOwV-UeM0fqthvDw-BaTU463JhoCpiKtxYSa8wEV28sWG1UNmMs9OmyEhfQPusAiu3NzeKZyv4nuil20InsjWyVR1Mp2apTIHHiGbzJStB8GZFNWuyrAljK3aqJ2MvHk8FlMbPRZ4LIGztBTm3ov7tgG8hfxZ9PV1vso2wKvSXfFtvhdykuB47xtPGzBek~PZj~ZNOV46oTPYxa9lzJthFL3-XmsRFCoIKlwPlehgtw~6f7h0rK8pTdySSScJ37PwnS-HxXSi~Z2CnLig__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4',
                                    //       fit: BoxFit.fill,
                                    //     ),
                                    //   ),
                                    // ),
                                    SizedBox(
                                      height: 24.h,
                                    ),
                                    Text(
                                      "${indexx + 1}. ${skriningController.getSoalSkrining!.data![indexx].question}",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.brown,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 65.h,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          skriningController
                                              .getSoalSkrining!
                                              .data![indexx]
                                              .jawaban = "option_1";
                                        });
                                        setDataAnswer();
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.only(bottom: 16.w),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.w, vertical: 16.h),
                                        decoration: BoxDecoration(
                                          color: skriningController
                                                      .getSoalSkrining!
                                                      .data![indexx]
                                                      .jawaban ==
                                                  "option_1"
                                              ? AppColor.green
                                              : AppColor.lightGreen,
                                          border:
                                              Border.all(color: AppColor.green),
                                          borderRadius:
                                              BorderRadius.circular(4.w),
                                        ),
                                        child: Text(
                                          skriningController.getSoalSkrining!
                                              .data![indexx].option1!,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: skriningController
                                                        .getSoalSkrining!
                                                        .data![indexx]
                                                        .jawaban ==
                                                    "option_1"
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          skriningController
                                              .getSoalSkrining!
                                              .data![indexx]
                                              .jawaban = "option_2";
                                        });
                                        setDataAnswer();
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.only(bottom: 16.w),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.w, vertical: 16.h),
                                        decoration: BoxDecoration(
                                          color: skriningController
                                                      .getSoalSkrining!
                                                      .data![indexx]
                                                      .jawaban ==
                                                  "option_2"
                                              ? AppColor.green
                                              : AppColor.lightGreen,
                                          border:
                                              Border.all(color: AppColor.green),
                                          borderRadius:
                                              BorderRadius.circular(4.w),
                                        ),
                                        child: Text(
                                          skriningController.getSoalSkrining!
                                              .data![indexx].option2!,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: skriningController
                                                        .getSoalSkrining!
                                                        .data![indexx]
                                                        .jawaban ==
                                                    "option_2"
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    skriningController.getSoalSkrining!
                                                .data![indexx].option3! ==
                                            ""
                                        ? Container()
                                        : InkWell(
                                            onTap: () {
                                              setState(() {
                                                skriningController
                                                    .getSoalSkrining!
                                                    .data![indexx]
                                                    .jawaban = "option_3";
                                              });
                                              setDataAnswer();
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin:
                                                  EdgeInsets.only(bottom: 16.w),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.w,
                                                  vertical: 16.h),
                                              decoration: BoxDecoration(
                                                color: skriningController
                                                            .getSoalSkrining!
                                                            .data![indexx]
                                                            .jawaban ==
                                                        "option_3"
                                                    ? AppColor.green
                                                    : AppColor.lightGreen,
                                                border: Border.all(
                                                    color: AppColor.green),
                                                borderRadius:
                                                    BorderRadius.circular(4.w),
                                              ),
                                              child: Text(
                                                skriningController
                                                    .getSoalSkrining!
                                                    .data![indexx]
                                                    .option3!,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: skriningController
                                                              .getSoalSkrining!
                                                              .data![indexx]
                                                              .jawaban ==
                                                          "option_3"
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                    // Column(
                                    //   children: List.generate(
                                    //     choice.length,
                                    //     (index) => InkWell(
                                    //       onTap: () {
                                    //         setState(() {
                                    //           isSelected = index;
                                    //         });
                                    //       },
                                    //       child: Container(
                                    //         width: MediaQuery.of(context)
                                    //             .size
                                    //             .width,
                                    //         margin:
                                    //             EdgeInsets.only(bottom: 16.w),
                                    //         padding: EdgeInsets.symmetric(
                                    //             horizontal: 20.w,
                                    //             vertical: 16.h),
                                    //         decoration: BoxDecoration(
                                    //           color: isSelected == index
                                    //               ? AppColor.green
                                    //               : AppColor.lightGreen,
                                    //           border: Border.all(
                                    //               color: AppColor.green),
                                    //           borderRadius:
                                    //               BorderRadius.circular(4.w),
                                    //         ),
                                    //         child: Text(
                                    //           choice[index]["label"],
                                    //           style: TextStyle(
                                    //             fontSize: 14,
                                    //             fontWeight: FontWeight.w600,
                                    //             color: isSelected == index
                                    //                 ? Colors.white
                                    //                 : Colors.black,
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // )
                                  ],
                                ),
                              ),
                            ),
                          ).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 30.h,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.h, horizontal: 32.w),
                    width: MediaQuery.of(context).size.width,
                    color: AppColor.accentGreen,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        controller!.index == 0
                            ? Container()
                            : InkWell(
                                onTap: () {
                                  controller!.animateTo(controller!.index - 1);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.w),
                                    color: AppColor.grey400,
                                  ),
                                  width: 150.w,
                                  padding: EdgeInsets.symmetric(vertical: 16.h),
                                  child: const Text(
                                    "Sebelumnya",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.grey700,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                        InkWell(
                          onTap: () async {
                            if (controller!.index ==
                                skriningController
                                        .getSoalSkrining!.data!.length -
                                    1) {
                              await postJawaban();
                              if (skriningController
                                      .postJawabanSkrining!.status ==
                                  1) {
                                Get.to(ResultScreen());
                              }
                            } else {
                              controller!.animateTo(controller!.index + 1);
                            }

                            print("questionid : $questionId");
                            print("answer : $answer");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.w),
                              color: AppColor.brown,
                            ),
                            width: 150.w,
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: Text(
                              controller!.index ==
                                      skriningController
                                              .getSoalSkrining!.data!.length -
                                          1
                                  ? "Submit"
                                  : "Selanjutnya",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
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
