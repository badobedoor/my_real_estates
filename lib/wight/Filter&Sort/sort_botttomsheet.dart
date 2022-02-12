import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_real_estates/wight/appWight&Theme/app_widgets.dart';
import 'package:my_real_estates/wight/appWight&Theme/theme.dart';
import 'package:my_real_estates/wight/smallWight/costom_radio.dart';

class SortBotttomsheet extends StatefulWidget {
  const SortBotttomsheet({Key? key}) : super(key: key);

  @override
  _SortBotttomsheet createState() => _SortBotttomsheet();
}

enum UpandDowen { up, dowen, non }

class _SortBotttomsheet extends State<SortBotttomsheet> {
  bool isOpen = false;
  int _value = 0;
  var groupValuew = false;
  // UpandDowen _site = UpandDowen.non;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isOpen = !isOpen;
        });

        if (isOpen) {
          showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0.sp),
                topRight: Radius.circular(10.0.sp),
              )),
              builder: (builder) {
                return StatefulBuilder(builder: (BuildContext context,
                    StateSetter setState /*You can rename this!*/) {
                  return Stack(
                    children: [
                      // BottomSheet Contaner
                      Container(
                        height: 220.h,
                        width: 375.w,
                        color: Colors.black.withOpacity(0.01),
                        child: Stack(
                          children: [
                            Positioned(
                                bottom: 0,
                                left: 0,
                                // BottomSheet Contaner*************
                                child: Container(
                                  height: 206.h,
                                  width: 375.w,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0.sp),
                                        topRight: Radius.circular(10.0.sp),
                                      )),
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerRight,
                                        padding: EdgeInsets.all(30.sp),
                                        child: buildText(
                                          'ترتيب حسب ...',
                                          20.sp,
                                          AppColors.blue100,
                                          FontWeight.w700,
                                          TextAlign.center,
                                        ),
                                      ),
                                      MyRadioListTile<int>(
                                        value: 1,
                                        groupValue: _value,
                                        leading: 'A',
                                        title: Container(
                                          padding: EdgeInsets.only(right: 40.w),
                                          alignment: Alignment.centerRight,
                                          // color: AppColors.bluePurple,
                                          width: 319.w,
                                          child: buildText(
                                            'السعر من الاقل الى الاعلى',
                                            16.sp,
                                            AppColors.blue100,
                                            FontWeight.w500,
                                            TextAlign.center,
                                          ),
                                        ),
                                        onChanged: (value) =>
                                            setState(() => _value = value!),
                                      ),
                                      SizedBox(height: 20.h),
                                      MyRadioListTile<int>(
                                        value: 2,
                                        groupValue: _value,
                                        leading: 'B',
                                        title: Container(
                                          padding: EdgeInsets.only(right: 40.w),
                                          alignment: Alignment.centerRight,
                                          // color: AppColors.bluePurple,
                                          width: 319.w,
                                          child: buildText(
                                            'السعر من الاعلى الى الاقل',
                                            16.sp,
                                            AppColors.blue100,
                                            FontWeight.w500,
                                            TextAlign.center,
                                          ),
                                        ),
                                        onChanged: (value) =>
                                            setState(() => _value = value!),
                                      ),
                                    ],
                                  ),
                                  //  buildRadioColumn(),
                                  //  Column(
                                  //   children: [
                                  //     RadioListTile(
                                  //       contentPadding: EdgeInsets.all(0),
                                  //       activeColor: Colors.black,
                                  //       groupValue: groupValuew,
                                  //       value: true,
                                  //       onChanged: (value) {
                                  //         setState(() {
                                  //           groupValuew = true;
                                  //         });
                                  //       },
                                  //       // controlAffinity:ListTileControlAffinity.trailing,
                                  //       title: buildText(
                                  //           'السعر من الاعلى الى الاقل',
                                  //           16.sp,
                                  //           AppColors.blue100),
                                  //     ),
                                  // RadioListTile(

                                  //   contentPadding: EdgeInsets.all(0),
                                  //   activeColor: Colors.black,
                                  //   groupValue: groupValuew,
                                  //   value: true,
                                  //   onChanged: (value) {
                                  //     setState(() {
                                  //       groupValuew = true;
                                  //     });
                                  //   },
                                  //   // controlAffinity:ListTileControlAffinity.trailing,
                                  //   title: buildText(
                                  //       'السعر من الاقل الى الاعلى',
                                  //       16.sp,
                                  //       AppColors.blue100),
                                  // ),
                                  // ],
                                )),

                            //Close Button
                            Positioned(
                              left: 28,
                              top: 0,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  width: 30.h,
                                  height: 30.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.pink,
                                    borderRadius: BorderRadius.circular(25.sp),
                                  ),
                                  child: Icon(
                                    Icons.close_rounded,
                                    size: 25.sp,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                });
              }).whenComplete(() {
            setState(() {
              isOpen = !isOpen;
            });
          });
        }
      },
      child: Container(
        width: 170.w,
        height: 40.h,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  if (isOpen)
                    const Color(0xff52A0F8)
                  else
                    AppColors.white.withOpacity(0.01),
                  if (isOpen)
                    const Color(0xff6E52FC)
                  else
                    AppColors.white.withOpacity(0.01),
                ],
                stops: const [
                  0.0,
                  1.0
                ],
                begin: FractionalOffset.centerLeft,
                end: FractionalOffset.centerRight,
                tileMode: TileMode.repeated),
            borderRadius: BorderRadius.circular(5.sp),
            border: Border.all(color: Colors.white, width: 1.5.sp)),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildText(
              'ترتيب',
              20.sp,
              AppColors.white,
              FontWeight.w700,
              TextAlign.center,
            ),
            SizedBox(width: 10.w),
            imageContainer(18, 18, 'assets/images/sort.png', BoxFit.fill),
          ],
        ),
      ),
    );
  }

  // Container buildRadioColumn() {
  //   return Container(
  //     // color: AppColors.blue,
  //     // margin: EdgeInsets.all(20.0.sp),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       children: <Widget>[
  //         GestureDetector(
  //           onTap: () {
  //             setState(() {
  //               _site = UpandDowen.up;
  //             });
  //           },
  //           child: ListTile(
  //             title: buildText(
  //                 'السعر من الاقل الى الاعلى', 16.sp, AppColors.blue100,FontWeight.w700,),
  //             horizontalTitleGap: 100.w,
  //             leading: Radio(
  //               value: UpandDowen.up,
  //               groupValue: _site,
  //               onChanged: (UpandDowen? value) {
  //                 setState(() {
  //                   _site = value!;
  //                 });
  //               },
  //             ),
  //           ),
  //         ),
  //         GestureDetector(
  //           onTap: () {
  //             setState(() {
  //               _site = UpandDowen.dowen;
  //             });
  //           },
  //           child: ListTile(
  //             title: buildText(
  //                 'السعر من الاعلى الى الاقل', 16.sp, AppColors.blue100,FontWeight.w700,),
  //             horizontalTitleGap: 100.w,
  //             leading: Radio(
  //               value: UpandDowen.dowen,
  //               groupValue: _site,
  //               onChanged: (UpandDowen? value) {
  //                 setState(() {
  //                   _site = value!;
  //                 });
  //               },
  //             ),
  //           ),
  //         ),
  //         // ListTile(
  //         //   title: const Text('www.tutorialandexample.com'),
  //         //   leading: Radio(
  //         //     value: UpandDowen.tutorialandexample,
  //         //     groupValue: _site,
  //         //     onChanged: (UpandDowen? value) {
  //         //       setState(() {
  //         //         _site = value!;
  //         //       });
  //         //     },
  //         //   ),
  //         // ),
  //       ],
  //     ),
  //   );
  // }

}
