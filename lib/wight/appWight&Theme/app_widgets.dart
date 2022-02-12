import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'theme.dart';

Container lodingContainer() {
  return Container(
    width: 375.w,
    height: 812.h,
    color: AppColors.black.withOpacity(0.80),
    alignment: Alignment.center,
    child: SizedBox(
      width: 50.w,
      height: 50.w,
      child: CircularProgressIndicator(
        color: AppColors.white,
      ),
    ),
  );
}

SizedBox imageContainer(double wi, double hi, String path, BoxFit fiT) {
  return SizedBox(
    width: wi.w,
    height: hi.h,
    // color: Colors.amber,
    child: Image.asset(
      path,
      fit: fiT,
    ),
  );
}

Container iconCircleGradientBTN({
  double? heightSize,
  double? widthSize,
  Widget? childWidget,
  double? iconSize,
  @required double? borderRadiusSize,
}) {
  return Container(
      width: widthSize!.h,
      height: heightSize!.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [Color(0xff52A0F8), Color(0xff6E52FC)],
            stops: [0.0, 1.0],
            begin: FractionalOffset.centerLeft,
            end: FractionalOffset.centerRight,
            tileMode: TileMode.repeated),
        borderRadius: BorderRadius.circular(borderRadiusSize!),
      ),
      child: childWidget);
}

Text buildText(
  String text,
  double size,
  Color textcolor,
  FontWeight fw,
  TextAlign textAlign, {
  double? heightSize,
}) {
  return Text(
    text,
    textDirection: TextDirection.rtl,
    // overflow: TextOverflow.clip,
    textAlign: textAlign,
    style: TextStyle(
      fontFamily: 'Tajawal',
      fontWeight: fw,
      fontSize: size.sp,
      color: textcolor,
      height: heightSize ?? 1.0,
      // shadows: <Shadow>[
      //   Shadow(
      //     offset: Offset(0, 4.0),
      //     blurRadius: 4.0,
      //     color: Color.fromARGB(100, 0, 0, 0),
      //   ),
      // ]
    ),
  );
}

// AppWidgets.textField(
//                         width: 153.w,
//                         context: context,
//                         controller: new TextEditingController(),
//                         inputType: TextInputType.name,
// )

Widget textField({
  required BuildContext context,
  required TextEditingController controller,
  required TextInputType inputType,
  String? Function(String?)? validatorValue,
  bool? eroorChek,
  String? keyText,
  String? hintText,
  String lableText = '',
  double? width,
  double? height,
  Widget? prefixIcon,
  bool obscureText = false,
  bool important = false,
}) {
  // var focused = Provider.of<MainProvider>(context, listen: true).focused;
  return Column(
    children: [
      if (lableText != '')
        Container(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (important != false)
                Text(
                  '* ',
                  style: TextStyle(color: AppColors.red, fontSize: 22.sp),
                ),
              buildText(
                lableText,
                20.sp,
                AppColors.blue100,
                FontWeight.w700,
                TextAlign.end,
              ),
            ],
          ),
        ),
      SizedBox(
        height: eroorChek == false ? 65.h : 90.h,
        child: Container(
          height: height ?? 40.h,
          width: width,
          margin: EdgeInsets.only(bottom: 25.h),
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(7.0),
            // border: Border.all(width: 1, color: AppColors.blue100),
            // focused == true
            boxShadow: [
              BoxShadow(
                color: validatorValue == null
                    ? AppColors.blue100.withOpacity(0.25)
                    : AppColors.white,
                blurRadius: 3,
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(5.sp),
            ),
            child: TextFormField(
              key: ValueKey(keyText),
              validator: validatorValue,
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Tajawal',
                  color: AppColors.blue100,
                  height: 0.9),

              controller: controller,
              keyboardType: inputType,
              obscureText: obscureText,
              textAlign: TextAlign.end,
              cursorColor: AppColors.lightblue,
              // cursorHeight: 30.h,

              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1.2.w, color: AppColors.blue100),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1.2.w, color: AppColors.blue100),
                  borderRadius: BorderRadius.circular(5),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1.2.w, color: AppColors.blue100),
                  borderRadius: BorderRadius.circular(5),
                ),
                errorStyle: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Tajawal',
                    color: AppColors.red,
                    height: 0.9),
                prefixIcon: prefixIcon,
                hintText: hintText,
                hintStyle: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Tajawal',
                    color: AppColors.grey4,
                    height: 0.3),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1.2.w, color: AppColors.blue100),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1.2.w, color: AppColors.lightblue),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget multilineTextField({
  required BuildContext context,
  required TextEditingController controller,
  required TextInputType inputType,
  required int? rowCount,
  String? hintText,
  String lableText = '',
  double? width,
  double? height,
  Widget? prefixIcon,
  bool obscureText = false,
  bool important = false,
}) {
  return Column(
    children: [
      if (lableText != '')
        Container(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (important != false)
                Text(
                  '* ',
                  style: TextStyle(color: AppColors.red, fontSize: 22.sp),
                ),
              buildText(
                lableText,
                20.sp,
                AppColors.blue100,
                FontWeight.w700,
                TextAlign.end,
              ),
            ],
          ),
        ),
      Container(
        // height: height == null ? 40.h : height,
        width: width,
        margin: EdgeInsets.only(bottom: 25.h),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.blue100.withOpacity(0.25),
              blurRadius: 3,
            ),
          ],
        ),
        //شادو
        //البادنج
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(5.sp),
          ),
          child: TextFormField(
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                fontFamily: 'Tajawal',
                color: AppColors.blue100,
                height: 0.9),
            controller: controller,
            keyboardType: inputType,
            obscureText: obscureText,
            textAlign: TextAlign.end,
            minLines: rowCount,
            maxLines: rowCount,
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              hintText: hintText,
              hintStyle: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Tajawal',
                  color: AppColors.grey4,
                  height: 1.45),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1.2.w, color: AppColors.blue100),
                borderRadius: BorderRadius.circular(5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(width: 1.2.w, color: AppColors.lightblue),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget textPhoneField({
  required BuildContext context,
  required TextEditingController controller,
  required TextInputType inputType,
  String? Function(String?)? validatorValue,
  bool? eroorChek,
  String? keyText,
  String? hintText,
  String lableText = '',
  double? width,
  Widget? prefixIcon,
  bool obscureText = false,
  bool important = false,
  EdgeInsetsGeometry? wightMargin,
}) {
  return SizedBox(
    child: Column(
      children: [
        if (lableText != '')
          Container(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (important != false)
                  Text(
                    '* ',
                    style: TextStyle(color: AppColors.red, fontSize: 22.sp),
                  ),
                buildText(
                  lableText,
                  20.sp,
                  AppColors.blue100,
                  FontWeight.w700,
                  TextAlign.end,
                ),
              ],
            ),
          ),
        Row(
          children: [
            //010 * 011 * 012

            //0101234567
            SizedBox(
              height: eroorChek == false ? 65.h : 90.h,
              child: Container(
                height: 40.h,
                width: width!.w,
                margin: wightMargin,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: eroorChek == false
                          ? AppColors.blue100.withOpacity(0.25)
                          : AppColors.white,
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(5.sp),
                  ),
                  child: TextFormField(
                    key: ValueKey(keyText),
                    validator: validatorValue,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(11),
                    ],
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Tajawal',
                        color: AppColors.blue100,
                        height: 0.9),
                    controller: controller,
                    keyboardType: inputType,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      prefixIcon: prefixIcon,
                      hintText: hintText,
                      hintStyle: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Tajawal',
                          color: AppColors.grey4,
                          height: 0.3),
                      errorStyle: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Tajawal',
                          color: AppColors.red,
                          height: 0.9),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1.2.w, color: AppColors.blue100),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1.2.w, color: AppColors.blue100),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1.2.w, color: AppColors.blue100),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1.2.w, color: AppColors.blue100),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1.2.w, color: AppColors.blue100),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Row buildFilterGradentRow(
    String backBTNtext, String btnText, Function backBtnTap, Function btnTap) {
  return Row(
    children: [
      SizedBox(width: 8.w),
      GestureDetector(
        onTap: () => backBtnTap,
        child: Container(
          width: 60.w,
          height: 40.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.sp),
              border: Border.all(color: AppColors.pink, width: 1.5.sp)),
          alignment: Alignment.center,
          child: buildText(
            backBTNtext,
            20.sp,
            AppColors.pink,
            FontWeight.w400,
            TextAlign.right,
          ),
        ),
      ),
      SizedBox(width: 10.w),
      GestureDetector(
        onTap: () => btnTap,
        child: Container(
          width: 230.w,
          height: 40.h,
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [Color(0xff52A0F8), Color(0xff6E52FC)],
                  stops: [0.0, 1.0],
                  begin: FractionalOffset.centerLeft,
                  end: FractionalOffset.centerRight,
                  tileMode: TileMode.repeated),
              borderRadius: BorderRadius.circular(5.sp),
              border: Border.all(
                  color: Colors.transparent, // Colors.white,
                  width: 1.5.sp)),
          alignment: Alignment.center,
          child: Container(
            width: 228.w,
            height: 38.h,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.sp),
                border: Border.all(
                    color: Colors.transparent, // Colors.white,
                    width: 1.5.sp)),
            alignment: Alignment.center,
            child:
                //  isOpen?
                GradientText(
              btnText,
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Tajawal'),
              colors: const [Color(0xff52A0F8), Color(0xff6E52FC)],
            ),
          ),
        ),
      ),
    ],
  );
}

Row buildGradentRow({
  @required double? backBTNWight, //55,
  @required double? backBTNhight, //40
  @required double? backBtnTextSize, //15
  @required FontWeight? backBtnTextWeight, //w400
  @required double? wightWight, //250.w,
  @required double? wighthight, //40
  @required double? btnTextSize, //20
  @required FontWeight? btnTextWeight, //w700
  @required String? btnText, //  قدم
  @required String? btnText2, //الطلب
  String? backBtnText, //تراجع
  required BuildContext context,
  required Function backBtnFun,
  required Function ontapBtnFun,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      // SizedBox(width: 8.w),
      GestureDetector(
        onTap: () {
          backBtnFun();
        },
        child: Container(
          width: backBTNWight!.w,
          height: backBTNhight!.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.sp),
            border: Border.all(color: AppColors.pink, width: 1.5.sp),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.25),
                blurRadius: 10,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Container(
            width: backBTNWight.w,
            height: backBTNhight.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.sp),
              color: AppColors.white,
            ),
            alignment: Alignment.center,
            child: buildText(
              backBtnText ?? 'تراجع',
              backBtnTextSize!.sp,
              AppColors.pink,
              backBtnTextWeight!,
              TextAlign.center,
            ),
          ),
        ),
      ),
      SizedBox(width: 10.w),

      GestureDetector(
        onTap: () {
          ontapBtnFun();
        },
        child: Container(
          width: wightWight!.w,
          height: wighthight!.h,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [Color(0xff52A0F8), Color(0xff6E52FC)],
                stops: [0.0, 1.0],
                begin: FractionalOffset.centerLeft,
                end: FractionalOffset.centerRight,
                tileMode: TileMode.repeated),
            borderRadius: BorderRadius.circular(5.sp),
            border: Border.all(
                color: Colors.transparent, // Colors.white,
                width: 1.sp),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.25),
                blurRadius: 10,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Container(
            width: wightWight.w,
            height: wighthight.h,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.sp),
                border: Border.all(
                    color: Colors.transparent, // Colors.white,
                    width: 1.5.sp)),
            alignment: Alignment.center,
            child:
                //  isOpen?
                Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GradientText(
                  btnText2!,
                  style: TextStyle(
                      fontSize: btnTextSize!.sp,
                      fontWeight: btnTextWeight!,
                      fontFamily: 'Tajawal'),
                  colors: const [Color(0xff52A0F8), Color(0xff6E52FC)],
                ),
                GradientText(
                  btnText!,
                  style: TextStyle(
                      fontSize: btnTextSize.sp,
                      fontWeight: btnTextWeight,
                      fontFamily: 'Tajawal'),
                  colors: const [Color(0xff52A0F8), Color(0xff6E52FC)],
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

Widget dropDownButton({
  required BuildContext context,
  required String value,
  required Map<String, dynamic> items,
  required ValueChanged<String?>? onSelected,
}) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: AppColors.blue100,
      ),
      borderRadius: BorderRadius.circular(5),
      // color: AppColors.orange,
    ),
    width: 315.w,
    height: 40.h,
    // color: AppColors.orange,
    child: PopupMenuButton(
      color: AppColors.orange, //..**

      offset: Offset.fromDirection(1.5, 40),
      onSelected: onSelected,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.arrow_drop_down,
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 12, color: AppColors.black),
              textAlign: TextAlign.center,
            ),
          ),
          //SizedBox(width: 1),
        ],
      ),
      itemBuilder: (BuildContext context) =>
          List<PopupMenuEntry<String>>.generate(
        items.length,
        (index) {
          return PopupMenuItem(
            padding: const EdgeInsets.symmetric(horizontal: 90),
            value: items.keys.elementAt(index),
            child: Container(
              padding: const EdgeInsets.all(50),
              width: 375.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColors.black.withOpacity(0.25),
              ),
              child: SizedBox(
                width: 315.w,
                height: 20,
                child: Text(
                  items.keys.elementAt(index),
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}

Widget textPriceField({
  required BuildContext context,
  required TextEditingController controller,
  required TextInputType inputType,
  String? Function(String?)? validatorValue,
  bool? eroorChek,
  String? keyText,
  String? hintText,
  String lableText = '',
  double? width,
  double? height,
  Widget? prefixIcon,
  bool obscureText = false,
  bool important = false,
}) {
  return Column(
    children: [
      if (lableText != '')
        Container(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (important != false)
                Text(
                  '* ',
                  style: TextStyle(color: AppColors.red, fontSize: 22.sp),
                ),
              buildText(
                lableText,
                20.sp,
                AppColors.blue100,
                FontWeight.w700,
                TextAlign.end,
              ),
            ],
          ),
        ),
      //input contaner
      SizedBox(
        height: eroorChek == false ? 65.h : 90.h,
        child: Row(
          children: [
            Container(
              width: 65.w,
              height: 45.h,
              margin: EdgeInsets.only(bottom: eroorChek == false ? 25.h : 46.h),
              decoration: BoxDecoration(
                color: AppColors.blue100,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.sp),
                    bottomLeft: Radius.circular(5.sp)),
              ),
              alignment: Alignment.center,
              child: buildText('ج . م', 20.sp, AppColors.white, FontWeight.w400,
                  TextAlign.center,
                  heightSize: 0.3),
            ),
            Container(
              // height: eroorChek == false ? 65.h : 20.h,
              width: 250.w,
              margin: EdgeInsets.only(bottom: 25.h),
              decoration: BoxDecoration(
                boxShadow: [
                  if (eroorChek == false)
                    BoxShadow(
                      color: AppColors.blue100.withOpacity(0.25),
                      blurRadius: 3,
                    ),
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5.sp),
                      bottomRight: Radius.circular(5.sp)),
                ),
                child: TextFormField(
                  key: ValueKey(keyText),
                  validator: validatorValue,
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Tajawal',
                      color: AppColors.blue100,
                      height: 0.9),
                  controller: controller,
                  keyboardType: inputType,
                  obscureText: obscureText,
                  decoration: InputDecoration(
                    prefixIcon: prefixIcon,
                    hintText: hintText,
                    hintStyle: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Tajawal',
                        color: AppColors.grey4,
                        height: 0.5),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1.2.w,
                        color: AppColors.blue100,
                      ),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5.sp),
                          bottomRight: Radius.circular(5.sp)),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1.2.w,
                        color: AppColors.blue100,
                      ),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5.sp),
                          bottomRight: Radius.circular(5.sp)),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1.2.w,
                        color: AppColors.blue100,
                      ),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5.sp),
                          bottomRight: Radius.circular(5.sp)),
                    ),
                    errorStyle: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Tajawal',
                        color: AppColors.red,
                        height: 0.9),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1.2.w,
                        color: AppColors.blue100,
                      ),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5.sp),
                          bottomRight: Radius.circular(5.sp)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1.5.w, color: AppColors.blue100),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5.sp),
                          bottomRight: Radius.circular(5.sp)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Container buildCardContainer(
  double cardWidth,
  double cardHeight,
  double caedBlurRadius,
  Widget cardChild,
) {
  return Container(
    width: cardWidth.w,
    height: cardHeight.h,
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(7.sp),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          blurRadius: caedBlurRadius,
        ),
      ],
    ),
    child: cardChild,
  );
}

///  Big text Container
Container textBigContainer({String? title, String? value}) {
  return Container(
    width: 315.w,
    padding: EdgeInsets.only(right: 20.w, top: 15.h, left: 10.w),
    decoration: BoxDecoration(
      color: AppColors.white,
      // border: Border.all(width: 1, color: AppColors.blue100),
      borderRadius: BorderRadius.all(Radius.circular(7.sp)),
      boxShadow: [
        BoxShadow(
          color: AppColors.black.withOpacity(0.25),
          blurRadius: 6,
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            buildText(
              title!,
              15.sp,
              AppColors.blue100,
              FontWeight.w500,
              TextAlign.start,
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        value == null
            ? Padding(
                padding: EdgeInsets.only(top: 20.0.sp),
                child: Align(
                  child: buildText(
                    'لا يوجد بينات ',
                    15.sp,
                    AppColors.blue100,
                    FontWeight.w400,
                    TextAlign.justify,
                  ),
                ),
              )
            : Align(
                alignment: Alignment.centerRight,
                child: buildText(value, 13.sp, AppColors.blue100,
                    FontWeight.w400, TextAlign.justify,
                    heightSize: 1.5),
              ),
        SizedBox(height: 20.h),
      ],
    ),
  );
}

Container gradientcontainer({
  double? containerWidth,
  double? containerHeight,
  Widget? containerChild,
}) {
  return Container(
    width: containerWidth!.w,
    height: containerHeight!.h,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
          colors: [Color(0xff52A0F8), Color(0xff6E52FC)],
          stops: [0.0, 1.0],
          begin: FractionalOffset.centerLeft,
          end: FractionalOffset.centerRight,
          tileMode: TileMode.repeated),
      borderRadius: BorderRadius.circular(5.sp),
      border: Border.all(
          color: Colors.transparent, // Colors.white,
          width: 1.sp),
      boxShadow: [
        BoxShadow(
          color: AppColors.black.withOpacity(0.25),
          blurRadius: 10,
        ),
      ],
    ),
    alignment: Alignment.center,
    child: Container(
      width: containerWidth.w,
      height: containerHeight.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.sp),
      ),
      alignment: Alignment.center,
      child: containerChild,
    ),
  );
}

Container textRowContainer({
  String? title,
  String? value,
}) {
  return Container(
    width: 315.w,
    height: 40.h,
    decoration: BoxDecoration(
      color: AppColors.white,
      // border: Border.all(width: 1, color: AppColors.blue100),
      borderRadius: BorderRadius.all(Radius.circular(7.sp)),
      boxShadow: [
        BoxShadow(
          color: AppColors.black.withOpacity(0.25),
          blurRadius: 6,
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        buildText(
          value!,
          15.sp,
          AppColors.blue100,
          FontWeight.w500,
          TextAlign.start,
        ),
        SizedBox(
          width: 85.w,
          child: buildText(
            title!,
            15.sp,
            AppColors.blue100,
            FontWeight.w700,
            TextAlign.start,
          ),
        ),
        SizedBox(width: 20.w),
      ],
    ),
  );
}
