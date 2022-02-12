import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:my_real_estates/wight/appWight&Theme/app_widgets.dart';
import 'package:my_real_estates/wight/appWight&Theme/theme.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../Provider/main_provider.dart';
import '../wight/dilog/reservation_request_dilog.dart';
import '../wight/imagesWights/ditalImages_future_builder.dart';

class RealEstateDetails extends StatefulWidget {
  const RealEstateDetails({Key? key}) : super(key: key);

// sellRequest.doc(widget.documentId).get(),

  @override
  _RealEstateDetailsState createState() => _RealEstateDetailsState();
}

class _RealEstateDetailsState extends State<RealEstateDetails>
    with SingleTickerProviderStateMixin {
  // late AnimationController rotationController;

  int currentIndex = 0;
  bool showBtn = false;
  bool showReservationRequestDilog = false;
  late AnimationController expandController;
  late Animation<double> animation;

  @override
  void initState() {
    expandController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1250));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    // _runExpandCheck();
    //   rotationController = AnimationController(
    //       duration: const Duration(milliseconds: 500), vsync: this);
    super.initState();
  }

  // void _runExpandCheck() {
  //   if (showBtn) {
  //     expandController.forward();
  //   } else {
  //     expandController.reverse();
  //   }
  // }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    showReservationRequestDilog =
        Provider.of<MainProvider>(context, listen: true)
            .showReservationRequestDilog;
    return Scaffold(
      // body: SafeArea(
      //       child: SingleChildScrollView(
      body: SizedBox(
        width: 375.w,
        height: 812.h,
        child: Stack(children: [
          //البينات
          const DitalImagesFutureBuilder(),

          //background black
          if (showBtn)
            GestureDetector(
              onTap: () => setState(() {
                showBtn = !showBtn;
              }),
              child: Container(
                height: 812.h,
                width: 375.w,
                color: AppColors.black.withOpacity(.50),
              ),
            ),
          //whats app BTN
          if (showBtn)
            Positioned(
              left: 35.w,
              bottom: 150.h,
              // PositionedTransition(rect: rect, child: child)
              // child: SizeTransition(
              //   axisAlignment: 1.0,
              //   sizeFactor: animation,
              child: GestureDetector(
                onTap: () async {
                  await launchWhatsApp();
                },
                child: Row(
                  children: [
                    iconCircleGradientBTN(
                        childWidget: imageContainer(
                            18, 18, 'assets/images/whatsapp.png', BoxFit.fill),
                        heightSize: 40,
                        widthSize: 40,
                        borderRadiusSize: 20.sp),
                    SizedBox(width: 10.w),
                    gradientcontainer(
                      containerWidth: 97,
                      containerHeight: 30,
                      containerChild: buildText('رساله واتس', 15.sp,
                          AppColors.blue100, FontWeight.w500, TextAlign.center),
                    ),
                  ],
                ),
              ),
            ),
          // ),
          //Reservation Request
          if (showBtn)
            Positioned(
              left: 35.w,
              bottom: 100.h,
              child: GestureDetector(
                onTap: () {
                  Provider.of<MainProvider>(context, listen: false)
                      .changeShowReservationRequestDilog(true);
                },
                child: Row(
                  children: [
                    iconCircleGradientBTN(
                        childWidget: Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: imageContainer(
                              18, 18, 'assets/images/edit.png', BoxFit.fill),
                        ),
                        heightSize: 40,
                        widthSize: 40,
                        borderRadiusSize: 20.sp),
                    SizedBox(width: 10.w),
                    gradientcontainer(
                      containerWidth: 45,
                      containerHeight: 30,
                      containerChild: buildText('حجز', 15.sp, AppColors.blue100,
                          FontWeight.w500, TextAlign.center),
                    ),
                  ],
                ),
              ),
            ),
          //showBtn Contianer
          Positioned(
            left: 30.w,
            bottom: 40.h,
            child: GestureDetector(
              onTap: () => setState(() {
                showBtn = !showBtn;
                // showBtn == true
                // ? expandController.forward()
                // : expandController.reverse();
                // showBtn == true
                //     ? rotationController.forward(from: 0.0)
                //     : rotationController.reverse(from: 0.89);
              }),
              child: iconCircleGradientBTN(
                  childWidget: showBtn
                      ? imageContainer(
                          30, 12, 'assets/images/callend.png', BoxFit.fill)
                      : imageContainer(
                          22, 22, 'assets/images/callstart.png', BoxFit.fill),
                  heightSize: 50,
                  widthSize: 50,
                  borderRadiusSize: 25.sp),
              //  RotationTransition(
              //     turns: Tween(
              //             begin: showBtn == true ? 0.0 : 0.89,
              //             end: showBtn == true ? 0.89 : 0.00)
              //         .animate(rotationController),
              //     child:
              //   ),
            ),
          ),
          //show Reservation Request Dilog
          if (showReservationRequestDilog) const ReservationRequestDilog(),
        ]),
      ),
      // )
    );
  }

//fountion*/*/*/*/*/*/**/*/*/*/*/* */

  Future<void> launchWhatsApp() async {
    final String documentId =
        Provider.of<MainProvider>(context, listen: false).sellRequestDocumentId;
    final DocumentReference<Map<String, dynamic>> sellRequestDocument =
        FirebaseFirestore.instance.doc('sellRequest/$documentId');
    await sellRequestDocument.get().then((element) {
      String phone = '';
      final DocumentReference<Map<String, dynamic>> document =
          FirebaseFirestore.instance.doc('whatsappNumber/1');
      document.get().then((document) async {
        phone = document.data()!['number'];
        final String phoneNum = '+20$phone';
        final link = WhatsAppUnilink(
          phoneNumber: phoneNum,
          text: '''
السلام عليكم
اريد الاستفسار حول الوحدة رقم : ${element.data()!['requestNumber']}
فى محافظة : ${element.data()!['city']}
فى مدينه : ${element.data()!['country']}
''',
        );
        await launch('$link');
      });
    });
  }
}
//اجيب الارور واطبعه
// .then((_) {

// }).catchError((onError) {
//   Scaffold.of(context).showSnackBar(SnackBar(content: Text(onError)));
// });
