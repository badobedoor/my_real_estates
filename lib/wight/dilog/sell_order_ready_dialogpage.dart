import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_real_estates/screens/sell_order_page.dart';
import 'package:my_real_estates/wight/appWight&Theme/app_widgets.dart';
import 'package:my_real_estates/wight/appWight&Theme/theme.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

void sellOrderReadyDialog({
  @required BuildContext? context,
}) {
  showDialog(
      context: context!,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.sp))),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: imageContainer(50, 100,
                    'assets/images/gradientSellOrder.png', BoxFit.fill),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GradientText(
                        ':',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        colors: const [Color(0xff52A0F8), Color(0xff6E52FC)],
                      ),
                      GradientText(
                        '   ادخل البيانات التالية:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        colors: const[Color(0xff52A0F8), Color(0xff6E52FC)],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50.h,
                  )
                ],
              )
            ],
          ),
          content: SizedBox(
            height: 175.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                buildText(
                  '- تحضير 6 صور واضحه للعقار من الداخل .',
                  15.sp,
                  AppColors.blue100,
                  FontWeight.w400,
                  TextAlign.start,
                ),
                SizedBox(height: 10.h),
                buildText(
                  '- يفضل ان تكون الصور بالعرض.',
                  15.sp,
                  AppColors.blue100,
                  FontWeight.w400,
                  TextAlign.start,
                ),
                SizedBox(height: 10.h),
                buildText(
                  '- تاكد من رقم العقار الصحيح .',
                  15.sp,
                  AppColors.blue100,
                  FontWeight.w400,
                  TextAlign.start,
                ),
                SizedBox(height: 10.h),
                buildText(
                  '- حضر وصفا تفصيليا لمكان العقار.',
                  15.sp,
                  AppColors.blue100,
                  FontWeight.w400,
                  TextAlign.start,
                ),
                SizedBox(height: 10.h),
                buildText(
                  '- فى حال كنت غير متاكد من اتصال هاتفك جهز رقم اخرر يمكننا التواصل معك من خلاله',
                  15.sp,
                  AppColors.blue100,
                  FontWeight.w400,
                  TextAlign.start,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            buildGradentRow(
              context: context,
              backBTNWight: 60,
              backBTNhight: 40,
              backBtnTextSize: 15,
              backBtnTextWeight: FontWeight.w400,
              wightWight: 190,
              wighthight: 40,
              btnTextSize: 20,
              btnTextWeight: FontWeight.w400,
              btnText: '  انا    ',
              btnText2: '    مستعد',
              backBtnFun: () => Navigator.of(context).pop(),
              ontapBtnFun: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => const SellOrder()),
              ),
            ),
            SizedBox(
              height: 10.h,
            )
          ],
        );
      });
}
