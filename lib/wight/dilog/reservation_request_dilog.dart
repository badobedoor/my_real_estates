import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_real_estates/wight/dilog/showDialog.dart';
import 'package:provider/Provider.dart';

import '../../Provider/main_provider.dart';
import '../appWight&Theme/app_widgets.dart';
import '../appWight&Theme/theme.dart';

class ReservationRequestDilog extends StatefulWidget {
  const ReservationRequestDilog({Key? key}) : super(key: key);

  @override
  State<ReservationRequestDilog> createState() =>
      _ReservationRequestDilogState();
}

class _ReservationRequestDilogState extends State<ReservationRequestDilog> {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();

  // final _phoneNumberTitleController = TextEditingController();
  final _nameController = TextEditingController();

  bool phoneEroorChek = false;
  bool nameEroorChek = false;
  bool isLoding = false;
  String unitNumber = '';
  int res = 0;
  @override
  Widget build(BuildContext context) {
    return
        // ClipPath(
        //   // clipper: CustomBTNClipper(),
        //   child:
        //   new BackdropFilter(
        // filter: new ui.ImageFilter.blur(sigmaX: 1.3, sigmaY: 1.3),
        // child:
        GestureDetector(
      onTap: () {
        Provider.of<MainProvider>(context, listen: false)
            .changeShowReservationRequestDilog(false);
      },
      child: Container(
        width: 375.w,
        height: 812.h,
        alignment: Alignment.center,
        // color: AppColors.grey5.withOpacity(0.45),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.grey5.withOpacity(0.50),
            ),
          ],
        ),
        child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: <Widget>[
              SizedBox(
                height: nameEroorChek == false || phoneEroorChek == false
                    ? 365.h
                    : 415.h,
                // color: AppColors.blue,
                child: AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.sp))),
                  content: Form(
                    key: _formKey,
                    child: SizedBox(
                      // height: 230.h,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //name input
                          textField(
                            width: 315.w,
                            context: context,
                            eroorChek: nameEroorChek,
                            hintText: 'اكتب اسمك هنا',
                            controller: _nameController,
                            inputType: TextInputType.name,
                            important: true,
                            lableText: 'الاسم',
                            keyText: 'name',
                            validatorValue: (val) {
                              if (val == null || val.isNotEmpty) {
                                setState(() {
                                  nameEroorChek = false;
                                });
                                return null;
                              } else if (val.isEmpty) {
                                setState(() {
                                  nameEroorChek = true;
                                });
                                return 'من فضلك ادخل اسمك';
                              }
                            },
                          ),
                          //phone number input
                          textPhoneField(
                            width: 250,
                            context: context,
                            controller: _phoneNumberController,

                            inputType: TextInputType.phone,
                            important: true,
                            wightMargin: EdgeInsets.only(bottom: 25.h),
                            hintText: '010100200300',

                            lableText: 'رقم الهاتف',
                            // validatorValue: ,
                            validatorValue: (val) {
                              final List<String> values = ['0', '1', '2', '5'];
                              if (val == null ||
                                  val.isEmpty ||
                                  val.length < 11 ||
                                  val[0] != '0' ||
                                  val[1] != '1') {
                                setState(() {
                                  phoneEroorChek = true;
                                });
                                return 'من فضلك ادخل رقم هاتف صحيح';
                              } else if (values.contains(val[2])) {
                                // true no error
                                setState(() {
                                  phoneEroorChek = false;
                                });
                                return null;
                              } else {
// false error
                                setState(() {
                                  phoneEroorChek = true;
                                });
                                return 'من فضلك ادخل رقم هاتف صحيح';
                              }
                            },

                            keyText: 'Phone',
                            eroorChek: phoneEroorChek,
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      textDirection: TextDirection.rtl,
                      children: [
                        GestureDetector(
                          onTap: () {
                            final isValid = _formKey.currentState!.validate();
                            FocusScope.of(context).unfocus();
                            if (isValid) {
                              _formKey.currentState!.save();

                              addInvestorRequest(context);
                            }
                          },
                          child: Container(
                            width: 120.w,
                            height: 40.h,
                            margin: EdgeInsets.only(bottom: 10.h),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  colors: [
                                    Color(0xff52A0F8),
                                    Color(0xff6E52FC)
                                  ],
                                  stops: [
                                    0.0,
                                    1.0
                                  ],
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
                              'حجز',
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
                ),
              ),
              Positioned(
                top: 10.h,
                left: 60.w,
                // top: 122.h,
                child: GestureDetector(
                  onTap: () {
                    Provider.of<MainProvider>(context, listen: false)
                        .changeShowReservationRequestDilog(false);
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
              ),
              // Loding Screen
              if (isLoding) lodingContainer()
            ]),
      ),
    );
  }

  Future<void> getlastid() async {
    try {
      final CollectionReference<Map<String, dynamic>> ref =
          FirebaseFirestore.instance.collection('InvestorRequest');
      final QuerySnapshot<Map<String, dynamic>> refchek =
          await FirebaseFirestore.instance.collection('InvestorRequest').get();
      if (refchek.docs.isEmpty) {
        setState(() {
          res = 100;
        });
      } else {
        final QuerySnapshot querySnapshot =
            await ref.orderBy('requestNumber', descending: true).limit(1).get();

        for (final doc in querySnapshot.docs) {
          if (doc.exists) {
            setState(() {
              res = doc['requestNumber'];
            });
          } else {
            setState(() {
              res = 100;
            });
          }
        }
      }
    } catch (error) {
      showEroorDialogFUN(
          context: context,
          title: 'خطأ',
          eroorText:
              'خطا فى ارسال البيانات الرجاء التاكد من الانترنت ومحاوده المحاوله');
    }
  }

  Future<void> addInvestorRequest(BuildContext ctx) async {
    unitNumber = Provider.of<MainProvider>(ctx, listen: false).unitNumber;
    setState(() {
      isLoding = true;
    });
    await getlastid();
    final CollectionReference investorRequestREF =
        FirebaseFirestore.instance.collection('InvestorRequest');
    final int requestCreatedDateSelectedDT =
        DateTime.now().millisecondsSinceEpoch;
    await investorRequestREF.add({
      'name': _nameController.text,
      'phoneNumber': _phoneNumberController.text,
      'requestNumber': res + 1,
      'unitNumber': unitNumber,
      'requestCreatedDate': requestCreatedDateSelectedDT,
    }).then((value) {
      setState(() {
        isLoding = false;
      });
      Provider.of<MainProvider>(ctx, listen: false)
          .changeShowReservationRequestDilog(false);
      showDialogFUN(
        context: ctx,
        title: 'تم استلام طلبكم ...',
        orderNumber: '${res + 1}',
        page: 'ReservationRequestDilog',
        // btnFunction: () => Navigator.of(ctx).pop()
      );
    }).catchError((error) {
      setState(() {
        isLoding = false;
      });
      //Error
    });
  }
}

// Center(
//         child: Stack(

//          overflow: Overflow.visible,
//           alignment: Alignment.center,
//           children: <Widget>[
//             Container(height: 150, width: 300, color: Colors.red),
//             Positioned(
//               top: -50,
//               child: Container(height: 100, width: 150, color: Colors.green),
//             ),
//           ],
//         ),
//       ),
