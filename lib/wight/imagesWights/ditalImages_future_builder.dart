import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_real_estates/wight/appWight&Theme/app_widgets.dart';
import 'package:my_real_estates/wight/appWight&Theme/theme.dart';
import 'package:my_real_estates/wight/dilog/Privacy_dilog.dart';
import 'package:provider/provider.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';

import '../../Provider/main_provider.dart';

class DitalImagesFutureBuilder extends StatefulWidget {
  const DitalImagesFutureBuilder({
    Key? key,
  }) : super(key: key);

  @override
  State<DitalImagesFutureBuilder> createState() =>
      _DitalImagesFutureBuilderState();
}

class _DitalImagesFutureBuilderState extends State<DitalImagesFutureBuilder> {
  CollectionReference sellRequest =
      FirebaseFirestore.instance.collection('sellRequest');
  late List<String> imagelist = [];
  String? documentId;
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final showReservationRequestDilog =
        Provider.of<MainProvider>(context, listen: true)
            .showReservationRequestDilog;
    documentId =
        Provider.of<MainProvider>(context, listen: true).sellRequestDocumentId;
    imagelist = Provider.of<MainProvider>(context, listen: true).imageList;
    return FutureBuilder<DocumentSnapshot>(
        future: sellRequest.doc(documentId).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          } else if (snapshot.hasData && !snapshot.data!.exists) {
            return const Center(child: Text('Document does not exist'));
          } else if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              width: 375.w,
              height: 812.h,
              color: AppColors.black.withOpacity(0.85),
              child: const Center(child: CircularProgressIndicator()),
            );
          }
          // if (snapshot.connectionState == ConnectionState.done)
          else {
            final Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Container(
              width: 375.w,
              height: 812.h,
              color: AppColors.white,
              child: Stack(
                children: [
                  //header image  Content
                  SizedBox(
                    width: 375.w,
                    height: 812.h,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            buildSwipeImageGallery(context).show();
                          },
                          child: Stack(
                            children: [
                              //images
                              SizedBox(
                                width: 375.w,
                                height: 300.h,
                                child: imagelist.isNotEmpty &&
                                        imagelist.isNotEmpty
                                    ? CarouselSlider(
                                        items: imagelist.map((i) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return SizedBox(
                                                width: 375.w,
                                                height: 300.h,
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl: i,
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              downloadProgress) =>
                                                          Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress),
                                                  ),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                ),
                                              );
                                            },
                                          );
                                        }).toList(),
                                        options: CarouselOptions(
                                          height: 320,
                                          viewportFraction: 1,
                                          autoPlayInterval:
                                              const Duration(seconds: 3),
                                          enlargeCenterPage: true,
                                          onPageChanged: (index, reason) {
                                            setState(() {
                                              currentIndex = index;
                                            });
                                          },
                                        ))
                                    : imageContainer(
                                        375,
                                        300,
                                        'assets/images/placeholder.png',
                                        BoxFit.fill),
                                // Center(
                              ),
                              //back BTN
                              Positioned(
                                top: 20.h,
                                right: 20.w,
                                child: IconButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  icon: Icon(
                                    Icons.arrow_forward_rounded,
                                    color: AppColors.white,
                                    size: 25.sp,
                                  ),
                                ),
                              ),
                              //Report BTN
                              Positioned(
                                top: 20.h,
                                left: 20.w,
                                child: IconButton(
                                  onPressed: () => reportInappropriateDialog(
                                      context: context,
                                      unitID: data['requestNumber'].toString()),
                                  icon: Icon(
                                    Icons.report,
                                    color: AppColors.pink.withOpacity(0.7),
                                    size: 25.sp,
                                  ),
                                ),
                              ),
                              //build Dots
                              Positioned.fill(
                                bottom: 60.h,
                                child: Align(
                                  alignment: Alignment.bottomCenter,

                                  // left: 102.w,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      imagelist.length,
                                      (index) => buildDot(index, context),
                                    ),
                                  ),
                                ),
                              ),
                              //ad title and ID
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  width: 375.w,
                                  height: 50.h,
                                  padding: EdgeInsets.only(
                                      top: 10.h, left: 30.w, right: 30.w),
                                  color: AppColors.black.withOpacity(0.35),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20.h,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: buildText(
                                            '${data['AdTitle']}',
                                            15.sp,
                                            AppColors.white,
                                            FontWeight.w700,
                                            TextAlign.start,
                                            textOverflow: TextOverflow.visible,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: buildText(
                                              'ID: ${data['requestNumber']}',
                                              17.sp,
                                              AppColors.grey4,
                                              FontWeight.w500,
                                              TextAlign.center,
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: buildText(
                                              data['orderStatus'] == 'محجوز'
                                                  ? '${data['orderStatus']}'
                                                  : '',
                                              17.sp,
                                              AppColors.red,
                                              FontWeight.w500,
                                              TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: showReservationRequestDilog == true
                              ? 185.h
                              : 400.h,
                          width: 375.w,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(height: 20.h),
                                textRowContainer(
                                    title: 'المحافظة :',
                                    value: '${data['city']}'),
                                SizedBox(height: 20.h),
                                textRowContainer(
                                    title: 'المدينه :',
                                    value: '${data['country']}'),
                                SizedBox(height: 20.h),
                                textRowContainer(
                                    title: 'الحى :',
                                    value: '${data['neighborhood']}'),
                                SizedBox(height: 20.h),
                                textBigContainer(
                                    title: 'التفاصيل :',
                                    value: '${data['AdDetails']}'),
                                SizedBox(height: 20.h),
                                textBigContainer(
                                    title: 'شرح الفرصه الاستثماريه :',
                                    value:
                                        '${data['investmentOpportunityDetails']}'),
                                SizedBox(height: 50.h),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //bouttom Bar
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: 375.w,
                      height: 120.h,
                      padding: EdgeInsets.only(
                          left: 30.w, right: 30.w, top: 25.h, bottom: 20.h),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.sp),
                            topRight: Radius.circular(30.sp)),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withOpacity(0.25),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Row(
                        textDirection: TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 250.w,
                            child: Column(
                              children: [
                                //Frist row اجماى الاستثمار
                                Row(
                                  textDirection: TextDirection.rtl,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildText(
                                      'اجمالى الاستثمار',
                                      15.sp,
                                      AppColors.blue100,
                                      FontWeight.w700,
                                      TextAlign.start,
                                    ),
                                    buildText(
                                      '${data['unitPrice']}',
                                      15.sp,
                                      AppColors.blue100,
                                      FontWeight.w700,
                                      TextAlign.start,
                                    ),
                                    buildText(
                                      'ج.م',
                                      12.sp,
                                      AppColors.blue100,
                                      FontWeight.w700,
                                      TextAlign.start,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                //thocnd row العائد السنوى والزياده السنوية
                                Row(
                                  textDirection: TextDirection.rtl,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                        textDirection: TextDirection.rtl,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          buildText(
                                            'عائد سنوي',
                                            11.sp,
                                            AppColors.blue100,
                                            FontWeight.w700,
                                            TextAlign.start,
                                          ),
                                          SizedBox(width: 10.w),
                                          buildText(
                                            '${data['annualReturnValue']}',
                                            13.sp,
                                            AppColors.green,
                                            FontWeight.w700,
                                            TextAlign.start,
                                          ),
                                          SizedBox(width: 5.w),
                                          buildText(
                                            'ج.م',
                                            12.sp,
                                            AppColors.blue100,
                                            FontWeight.w700,
                                            TextAlign.start,
                                          ),
                                        ]),
                                    Row(
                                        textDirection: TextDirection.rtl,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          buildText(
                                            'زيادة سنوية',
                                            11.sp,
                                            AppColors.blue100,
                                            FontWeight.w700,
                                            TextAlign.start,
                                          ),
                                          SizedBox(width: 15.w),
                                          buildText(
                                            //'99%',
                                            '${data['AnnualIncrementValue']}%',
                                            15.sp,
                                            AppColors.green,
                                            FontWeight.w700,
                                            TextAlign.start,
                                          ),
                                        ]),
                                  ],
                                ),

                                //third row اجمالى العائد السنوى
                                Row(
                                  textDirection: TextDirection.rtl,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildText(
                                      'اجمالى العائد السنوي :',
                                      11.sp,
                                      AppColors.blue100,
                                      FontWeight.w700,
                                      TextAlign.start,
                                    ),
                                    buildText(
                                        '${data['ExpectedAnnualIncome'].toInt()}',
                                        17.sp,
                                        AppColors.purple,
                                        FontWeight.w700,
                                        TextAlign.start,
                                        heightSize: 1.9),
                                    buildText(
                                      'ج.م',
                                      12.sp,
                                      AppColors.blue100,
                                      FontWeight.w700,
                                      TextAlign.start,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 50.w,
                            height: 50.h,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          // return Text('Loding ....');
        });
  }

  SwipeImageGallery buildSwipeImageGallery(BuildContext context) {
    return SwipeImageGallery(
      context: context,
      itemBuilder: (context, index) {
        return Stack(children: [
          Center(
            child: Image.network(
              imagelist[index],
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
          ),
          //back BTN
          Positioned(
            top: 50.h,
            right: 20.w,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Row(
                children: [
                  buildText('الصور', 20.sp, AppColors.white, FontWeight.w700,
                      TextAlign.center),
                  SizedBox(
                    width: 10.w,
                  ),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: AppColors.white,
                    size: 25.sp,
                  ),
                ],
              ),
            ),
          ),
        ]);
      },
      itemCount: imagelist.length,
    );
  }

  Container buildDot(int index, BuildContext context) {
    // Another Container returned
    return Container(
      height: 15.h,
      width: 15.h,

      // currentIndex == index ?
      margin: imagelist.length == index + 1
          ? EdgeInsets.only(right: 0.w)
          : EdgeInsets.only(right: 25.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.sp),
        border: Border.all(color: AppColors.white),
        color: currentIndex == index ? AppColors.white : AppColors.transparent,
      ),
    );
  }
}
