import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_real_estates/wight/appWight&Theme/app_widgets.dart';
import 'package:my_real_estates/wight/appWight&Theme/theme.dart';
import 'package:provider/provider.dart';

import '../../Provider/main_provider.dart';

void showDialogFUN({
  @required BuildContext? context,
  @required String? title,
  @required String? orderNumber,
  Function? btnFunction,
  @required String? page,
  // btnFunction: () => Navigator.of(ctx).pop()
}) {
  showDialog(
      context: context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.sp))),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            textDirection: TextDirection.rtl,
            children: [
              buildText(title!, 20.sp, AppColors.blue100, FontWeight.w700,
                  TextAlign.center),
              SizedBox(width: 5.w),
              imageContainer(
                  25, 25, 'assets/images/chekBoxDon.png', BoxFit.fill)
            ],
          ),
          content: SizedBox(
            height: 70.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  textDirection: TextDirection.rtl,
                  children: [
                    buildText('رقم', 15.sp, AppColors.blue100, FontWeight.w700,
                        TextAlign.center),
                    SizedBox(width: 5.w),
                    buildText(orderNumber!, 15.sp, AppColors.green,
                        FontWeight.w700, TextAlign.center),
                  ],
                ),
                SizedBox(height: 5.h),
                buildText('وسيتم التواصل معكم فى اقرب وقت', 15.sp,
                    AppColors.blue100, FontWeight.w700, TextAlign.center),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              textDirection: TextDirection.rtl,
              children: [
                GestureDetector(
                  onTap: () {
                    if (page == 'ReservationRequestDilog') {
                      Navigator.of(context).pop();
                    }
                    if (page == 'RentOrder') {
                      Provider.of<MainProvider>(context, listen: false)
                          .changesellansRentOrderShowBTN(false);
                      Navigator.of(context).pop();

                      Navigator.of(context).pop();
                    }
                    if (page == 'SellOrder') {
                      Provider.of<MainProvider>(context, listen: false)
                          .changeimageFileList([]);
                      Provider.of<MainProvider>(context, listen: false)
                          .changesellansRentOrderShowBTN(false);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                    width: 160.w,
                    height: 40.h,
                    margin: EdgeInsets.only(bottom: 20.h),
                    padding: EdgeInsets.only(top: 5.h),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xff52A0F8), Color(0xff6E52FC)],
                          stops: [0.0, 1.0],
                          begin: FractionalOffset.centerLeft,
                          end: FractionalOffset.centerRight,
                          tileMode: TileMode.repeated),
                      borderRadius: BorderRadius.circular(5.sp),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 6.sp,
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: buildText(
                      'موافق',
                      20.sp,
                      AppColors.white,
                      FontWeight.w700,
                      TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      });
}

// Navigator.of(context, rootNavigator: true).pop(result) to close the dialog rather than just Navigator.pop(context, result).

void showEroorDialogFUN({
  @required BuildContext? context,
  @required String? title,
  @required String? eroorText,
}) {
  showDialog(
      context: context!,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.sp))),
          title: buildText(
              title!, 20.sp, AppColors.pink, FontWeight.w700, TextAlign.center,
              heightSize: 1.5),
          content: Container(
            height: 30.h,
            alignment: Alignment.center,
            // margin: EdgeInsets.only(top: 5.h, bottom: 15.h),
            child: buildText(
              eroorText!,
              15.sp,
              AppColors.blue100,
              FontWeight.w700,
              TextAlign.center,
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              textDirection: TextDirection.rtl,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 160.w,
                    height: 40.h,
                    margin: EdgeInsets.only(bottom: 20.h),
                    padding: EdgeInsets.only(top: 5.h),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xff52A0F8), Color(0xff6E52FC)],
                          stops: [0.0, 1.0],
                          begin: FractionalOffset.centerLeft,
                          end: FractionalOffset.centerRight,
                          tileMode: TileMode.repeated),
                      borderRadius: BorderRadius.circular(5.sp),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 6.sp,
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: buildText(
                      'موافق',
                      20.sp,
                      AppColors.white,
                      FontWeight.w700,
                      TextAlign.center,
                      // heightSize: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      });
}
