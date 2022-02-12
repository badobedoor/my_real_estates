import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_real_estates/wight/appWight&Theme/app_widgets.dart';
import 'package:my_real_estates/wight/appWight&Theme/theme.dart';
import 'package:provider/provider.dart';

import '../Provider/main_provider.dart';
import 'home.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  int currentIndex = 0;

  Future<void> puase() async {
    if (currentIndex == 0) {
      await Future<dynamic>.delayed(const Duration(seconds: 3));
    }
    if (currentIndex == 0) {
      setState(() {
        currentIndex = 1;
      });
    }
    if (currentIndex == 1) {
      await Future<dynamic>.delayed(const Duration(seconds: 3));
    }

    if (currentIndex == 1 && mounted == true) {
      await Provider.of<MainProvider>(context, listen: false)
          .changeFristTime(false);
      await Navigator.pushReplacement(
          // ignore: inference_failure_on_instance_creation
          context,
          MaterialPageRoute(builder: (context) => const Home()));
    }
  }

  // @override
  // void dispose() {

  //   puase().ignore();
  //   super.dispose();
  // }

  // @override
  // void didChangeDependencies() {

  //   super.didChangeDependencies();
  //   puase();
  // }

  @override
  void initState() {
    puase();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Color defaultColor = Theme.of(context).brightness == Brightness.light
    //     ? AppColors.white
    //     : AppColors.black;
    final List<dynamic> slides = [
      [
        'assets/images/HelpSliderOne.png',
        'اشتري واجر عقارك',
        'وانت ف مكانك',
      ],
      [
        'assets/images/HelpSliderTwo.png',
        'عقاراتى',
        'استثمار فى المضمون',
      ],
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
          child: Container(
        child:
            // FutureBuilder(
            //     future: puase(),
            //     builder: (context, AsyncSnapshot snapshot) {
            //       return
            currentIndex == 0
                ? Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            currentIndex = 1;
                          });
                        },
                        child: SizedBox(
                          width: 375.w,
                          height: 775.h,
                          // color: AppColors.blue,
                          child: Column(children: [
                            SizedBox(height: 185.h),
                            SizedBox(
                              width: 332.w,
                              height: 332.h,
                              child: Image.asset(
                                '${slides[0][0]}',
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(height: 75.h),
                            buildText(
                              '${slides[0][1]}',
                              25.sp,
                              const Color(0xff1B222E),
                              FontWeight.w500,
                              TextAlign.center,
                            ),
                            SizedBox(height: 5.h),
                            SizedBox(
                              width: 200.w,
                              child: Row(
                                textDirection: TextDirection.rtl,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  buildText(
                                    'وانت ف',
                                    25.sp,
                                    const Color(0xff1B222E),
                                    FontWeight.w500,
                                    TextAlign.center,
                                  ),
                                  imageContainer(
                                      33,
                                      40,
                                      'assets/images/location.png',
                                      BoxFit.fill),
                                  buildText(
                                    'مكانك',
                                    25.sp,
                                    const Color(0xff1B222E),
                                    FontWeight.w500,
                                    TextAlign.center,
                                  )
                                ],
                              ),
                            )
                          ]),
                        ),
                      ),

                      // Container created for dots
                      Positioned(
                        bottom: 56.h,
                        left: 155.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            slides.length,
                            (index) => buildDot(index, context),
                          ),
                        ),
                      ),
                    ],
                  )
                : Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Provider.of<MainProvider>(context, listen: false)
                              .changeFristTime(false);
                          Navigator.pushReplacement(
                              context,
                              // ignore: inference_failure_on_instance_creation
                              MaterialPageRoute(
                                  builder: (context) => const Home()));
                          setState(() {});
                        },
                        child: SizedBox(
                          width: 375.w,
                          height: 775.h,
                          // color: AppColors.blue,
                          child: Column(children: [
                            SizedBox(height: 60.h),
                            SizedBox(
                              width: 411.w,
                              height: 450.h,
                              child: Image.asset(
                                '${slides[1][0]}',
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(height: 97.h),
                            buildText(
                              '${slides[1][1]}',
                              25.sp,
                              const Color(0xff1B222E),
                              FontWeight.w700,
                              TextAlign.center,
                            ),
                            SizedBox(height: 5.h),
                            buildText(
                              '${slides[1][2]}',
                              25.sp,
                              const Color(0xff1B222E),
                              FontWeight.w500,
                              TextAlign.center,
                            ),
                          ]),
                        ),
                      ),

                      // Container created for dots
                      Positioned(
                        bottom: 56.h,
                        left: 155.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            slides.length,
                            (index) => buildDot(index, context),
                          ),
                        ),
                      ),
                    ],
                    // );
                    // }),
                  ),
      )),
    );
  }

  // GestureDetector(
  //               onTap: () {
  //                 if (currentIndex == 1) {
  //                   Navigator.pushReplacement(
  //                     context,
  //                     MaterialPageRoute(builder: (context) => Home()),
  //                   );
  //                 }
  //               },

  Container buildDot(int index, BuildContext context) {
    // Another Container returned
    return Container(
      height: 15.h,
      width: currentIndex != index ? 40.h : 15.h,
      margin: index == 5
          ? EdgeInsets.only(right: 0.w)
          : EdgeInsets.only(right: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.sp),
        color: currentIndex == index ? AppColors.black : AppColors.black,
      ),
    );
  }
}

class NormaText extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const NormaText(this.text, this.size);
  final String text;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: size, color: AppColors.black),
    );
  }
}

//  Positioned(
//                 bottom: 94.h,
//                 right: 95.w,
//                 child: GestureDetector(
//                   onTap: () {
//                     // Navigator.pushReplacement(
//                     // context,
//                     // MaterialPageRoute(builder: (context) => AnimationPage()), الانتقال الى صفحه المسارات
//                     // );
//                   },
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.of(context).pushReplacement(
//                         MaterialPageRoute<void>(
//                             builder: (BuildContext context) => Home()),
//                       );
//                     },
//                     child: Container(
//                       height: 44.h,
//                       width: 185.w,
//                       alignment: Alignment.center,
//                       child: Text(
//                         'التالى',
//                         style: TextStyle(
//                           color: AppColors.black,
//                           fontSize: 22.sp,
//                           // fontWeight: FontWeight.bold,
//                           decoration: TextDecoration.none,
//                           // fontFamily: 'Aljazeera',
//                         ),
//                         // textDirection: TextDirection.rtl,
//                       ),
//                       padding: EdgeInsets.only(
//                         left: 19.w,
//                         right: 19.w,
//                       ),
//                       decoration: BoxDecoration(
//                         color: AppColors.orange,
//                         borderRadius: BorderRadius.circular(10.sp),
//                         boxShadow: [
//                           BoxShadow(
//                             color: AppColors.white,
//                             spreadRadius: 0,
//                             blurRadius: 8,
//                             offset: Offset(0, 0),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
