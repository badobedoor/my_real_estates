import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:my_real_estates/wight/appWight&Theme/app_widgets.dart';
import 'package:my_real_estates/wight/appWight&Theme/theme.dart';
import 'package:my_real_estates/wight/dilog/showDialog.dart';
import 'package:my_real_estates/wight/select_drop_list.dart';
import 'package:my_real_estates/wight/smallWight/drop_list_model.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class RentOrder extends StatefulWidget {
  const RentOrder({Key? key}) : super(key: key);
  @override
  _RentOrderState createState() => _RentOrderState();
}

class _RentOrderState extends State<RentOrder> {
  //fire base
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _countryController = TextEditingController();
  final _neighborhoodConttroller = TextEditingController();
  final _phoneNumberController = TextEditingController();

  final _notesConttroller = TextEditingController();

  OptionItem cityItemSelected = OptionItem(id: '16', title: 'جنوب سيناء');

  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  String startDateLable = 'من';
  String endDateLable = 'الي';
  String rentTypeValue = 'مفروش';
  String? citydropDownValue;
  bool neighborhoodEroorChek = false;
  bool isrentTypeEmpty = false;
  bool phoneEroorChek = false;
  bool nameEroorChek = false;
  bool cityEroorChek = false;
  bool dateEroor = false;
  bool isLoding = false;
  var res = 0;

  @override
  void initState() {
    selectedStartDate = DateTime.now();
    selectedEndDate = selectedStartDate.add(const Duration(days: 1));
    // countDocuments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                    color: AppColors.white,
                    padding: EdgeInsets.only(
                        top: 30.sp, left: 30.sp, right: 30.sp, bottom: 20.sp),
                    child: Column(
                      children: [
                        //header Container (Title and the image)
                        SizedBox(
                          height: 97.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //image
                              Align(
                                alignment: Alignment.topCenter,
                                child: imageContainer(
                                    39,
                                    76,
                                    'assets/images/gradientRentOrder.png',
                                    BoxFit.fill),
                              ),
                              //Title Text
                              Column(
                                children: [
                                  SizedBox(height: 10.h),
                                  //Gradient Text Row
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GradientText(
                                        ':',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 22.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        colors: const [
                                          Color(0xff52A0F8),
                                          Color(0xff6E52FC)
                                        ],
                                      ),
                                      GradientText(
                                        '   ادخل البيانات التالية:',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 22.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        colors: const [
                                          Color(0xff52A0F8),
                                          Color(0xff6E52FC)
                                        ],
                                      ),
                                    ],
                                  ),
                                  //Split Text Row
                                  Row(
                                      // mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        buildText(
                                          'ضرورية',
                                          17.sp,
                                          AppColors.grey4,
                                          FontWeight.w400,
                                          TextAlign.center,
                                        ),
                                        buildText(
                                          '*',
                                          17.sp,
                                          AppColors.red,
                                          FontWeight.w400,
                                          TextAlign.center,
                                        ),
                                        buildText(
                                          'البيانات المـميزة بـ',
                                          17.sp,
                                          AppColors.grey4,
                                          FontWeight.w400,
                                          TextAlign.start,
                                        ),
                                      ]),
                                ],
                              )
                            ],
                          ),
                        ),
                        //Content Container
                        SizedBox(
                          height: 615.h,
                          child: SingleChildScrollView(
                            child: Column(
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

                                //Contry input

                                SelectDropList(
                                  cityItemSelected,
                                  citydropListModel,
                                  (cityItem) {
                                    FocusScope.of(context).unfocus();
                                    cityItemSelected = cityItem;
                                    setState(() {});
                                  },
                                  'المحافظة',
                                ),

                                //City input
                                textField(
                                  width: 315.w,
                                  context: context,
                                  controller: _countryController,
                                  inputType: TextInputType.name,
                                  hintText: 'مثلا(الغردقة او شرم الشيخ)',
                                  lableText: 'المدينه',
                                  eroorChek: cityEroorChek,
                                  keyText: 'City',
                                  validatorValue: (val) {
                                    if (val == null || val.isNotEmpty) {
                                      setState(() {
                                        cityEroorChek = false;
                                      });
                                      return null;
                                    } else if (val.isEmpty) {
                                      setState(() {
                                        cityEroorChek = false;
                                      });
                                      return null;
                                    }
                                  },
                                ),
                                //neighborhood input
                                textField(
                                  width: 315.w,
                                  context: context,
                                  controller: _neighborhoodConttroller,
                                  inputType: TextInputType.name,
                                  hintText: 'الحي او المنطقة التى تفضلها',
                                  lableText: 'الحي او المنطقة',
                                  eroorChek: neighborhoodEroorChek,
                                  keyText: 'neighborhood',
                                  validatorValue: (val) {
                                    if (val == null || val.isNotEmpty) {
                                      setState(() {
                                        neighborhoodEroorChek = false;
                                      });
                                      return null;
                                    } else if (val.isEmpty) {
                                      setState(() {
                                        neighborhoodEroorChek = false;
                                      });
                                      return null;
                                    }
                                  },
                                ),
                                //phone number input
                                textPhoneField(
                                  width: 315,
                                  context: context,
                                  controller: _phoneNumberController,

                                  inputType: TextInputType.phone,
                                  important: true,
                                  wightMargin: EdgeInsets.only(bottom: 25.h),
                                  hintText: '010100200300',

                                  lableText: 'رقم الهاتف',
                                  // validatorValue: ,
                                  validatorValue: (val) {
                                    final List<String> values = [
                                      '0',
                                      '1',
                                      '2',
                                      '5'
                                    ];
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

                                //Rent Date time input
                                Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(bottom: 10.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          buildText(
                                            'مده الايجار',
                                            20.sp,
                                            AppColors.blue100,
                                            FontWeight.w700,
                                            TextAlign.end,
                                          ),
                                        ],
                                      ),
                                    ),

                                    //
//مده الايجار
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (startDateLable != 'من') {
                                              _selectEndDate(context);
                                              setState(() {
                                                dateEroor = false;
                                              });
                                            } else {
                                              setState(() {
                                                dateEroor = true;
                                              });
                                            }
                                          },
                                          child: Container(
                                            width: 150.w,
                                            height: 40.h,
                                            decoration: BoxDecoration(
                                                color: AppColors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5.sp),
                                                border: Border.all(
                                                    width: 1.2,
                                                    color: AppColors.blue100)),
                                            alignment: Alignment.centerRight,
                                            padding:
                                                EdgeInsets.only(right: 20.w),
                                            child: buildText(
                                                endDateLable,
                                                20.sp,
                                                endDateLable == 'الي'
                                                    ? AppColors.grey4
                                                    : AppColors.blue100,
                                                FontWeight.w400,
                                                TextAlign.end,
                                                heightSize: 1.5),
                                          ),
                                        ),
                                        SizedBox(width: 15.w),
                                        GestureDetector(
                                          onTap: () =>
                                              _selectStartDate(context),
                                          child: Container(
                                            width: 150.w,
                                            height: 40.h,
                                            decoration: BoxDecoration(
                                              color: AppColors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5.sp),
                                              border: Border.all(
                                                color: AppColors.blue100,
                                                width: 1.2,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColors.blue100
                                                      .withOpacity(0.25),
                                                  blurRadius: 3,
                                                ),
                                              ],
                                            ),
                                            alignment: Alignment.centerRight,
                                            padding:
                                                EdgeInsets.only(right: 20.w),
                                            child: buildText(
                                                startDateLable,
                                                20.sp,
                                                startDateLable == 'من'
                                                    ? AppColors.grey4
                                                    : AppColors.blue100,
                                                FontWeight.w400,
                                                TextAlign.end,
                                                heightSize: 1.5),
                                          ),
                                        )
                                      ],
                                    ),
                                    if (dateEroor) SizedBox(height: 5.h),
                                    if (dateEroor)
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'ادخل تاريخ بدايه الايجار',
                                          textDirection: ui.TextDirection.rtl,
                                          style: TextStyle(
                                            fontFamily: 'Tajawal',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15.sp,
                                            color: AppColors.red,
                                          ),
                                        ),
                                      ),
                                    if (dateEroor) SizedBox(height: 10.h),
                                    if (!dateEroor) SizedBox(height: 25.h),
                                  ],
                                ),

                                //Rent Type (Emety or not) input
                                Container(
                                  padding: EdgeInsets.only(bottom: 10.h),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            '* ',
                                            style: TextStyle(
                                                color: AppColors.red,
                                                fontSize: 22.sp),
                                          ),
                                          buildText(
                                            'مستوي التجهيز',
                                            20.sp,
                                            AppColors.blue100,
                                            FontWeight.w700,
                                            TextAlign.end,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                rentTypeValue = 'فاضى';
                                                isrentTypeEmpty = true;
                                              });
                                            },
                                            child: Container(
                                              width: 150.w,
                                              height: 40.h,
                                              decoration: BoxDecoration(
                                                color: isrentTypeEmpty
                                                    ? AppColors.blue100
                                                    : AppColors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5.sp),
                                                border: Border.all(
                                                  color: AppColors.grey4,
                                                  width:
                                                      isrentTypeEmpty ? 0 : 1,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: isrentTypeEmpty
                                                        ? AppColors.blue100
                                                            .withOpacity(0.25)
                                                        : AppColors.white,
                                                    blurRadius: 3,
                                                  ),
                                                ],
                                              ),
                                              alignment: Alignment.center,
                                              child: buildText(
                                                  'فاضى',
                                                  20.sp,
                                                  isrentTypeEmpty
                                                      ? AppColors.white
                                                      : AppColors.grey4,
                                                  FontWeight.w500,
                                                  TextAlign.end,
                                                  heightSize: 1.5),
                                            ),
                                          ),
                                          SizedBox(width: 15.w),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                rentTypeValue = 'مفروش';
                                                isrentTypeEmpty = false;
                                              });
                                            },
                                            child: Container(
                                              width: 150.w,
                                              height: 40.h,
                                              decoration: BoxDecoration(
                                                color: isrentTypeEmpty
                                                    ? AppColors.white
                                                    : AppColors.blue100,
                                                borderRadius:
                                                    BorderRadius.circular(5.sp),
                                                border: Border.all(
                                                  color: AppColors.grey4,
                                                  width:
                                                      isrentTypeEmpty ? 1 : 0,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: isrentTypeEmpty
                                                        ? AppColors.white
                                                        : AppColors.blue100
                                                            .withOpacity(0.25),
                                                    blurRadius: 3,
                                                  ),
                                                ],
                                              ),
                                              alignment: Alignment.center,
                                              child: buildText(
                                                  'مفروش',
                                                  20.sp,
                                                  isrentTypeEmpty
                                                      ? AppColors.grey4
                                                      : AppColors.white,
                                                  FontWeight.w500,
                                                  TextAlign.end,
                                                  heightSize: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 20.h)
                                    ],
                                  ),
                                ),
                                //Nots input
                                multilineTextField(
                                    width: 315.w,
                                    height: 160.h,
                                    context: context,
                                    rowCount: 10,
                                    controller: _notesConttroller,
                                    inputType: TextInputType.multiline,
                                    hintText: '''
ثال (مستوى راقي وبها تكييفات ... الخ) -
مثال (قريبة من موقف او مدرسة كذا ... الخ) -
مثال (بحري او دور ارضي فقط ... الخ) -
مثال (عدد الغرف لا تقل عن 3 ... الخ) -
مثال (رجاء التواصل بعد الواحدة ظهرا ... الخ) -
مثال (احتاج مده طويلة ... الخ) -
''',
                                    lableText: 'طلبات خاصه'),

                                //Save and back Buttons

                                buildGradentRow(
                                    context: context,
                                    backBTNWight: 55,
                                    backBTNhight: 40,
                                    backBtnTextSize: 15,
                                    backBtnTextWeight: FontWeight.w400,
                                    wightWight: 250,
                                    wighthight: 40,
                                    btnTextSize: 20,
                                    btnTextWeight: FontWeight.w400,
                                    btnText: 'قدم',
                                    btnText2: 'الطلب    ',
                                    backBtnFun: () {
                                      FocusScope.of(context).unfocus();
                                      Navigator.of(context).pop();
                                    },
                                    ontapBtnFun: () {
                                      final isValid =
                                          _formKey.currentState!.validate();
                                      FocusScope.of(context).unfocus();
                                      if (isValid) {
                                        _formKey.currentState!.save();

                                        addRentRequest(context);
                                      }
                                    }),

                                SizedBox(height: 12.h),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Loding Screen
              if (isLoding) lodingContainer()
            ],
          ),
        ),
      ),
    );
  }

  //Start
  Future<void> getlastid() async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('rentRequest')
          .orderBy('requestNumber', descending: true)
          .limit(1)
          .get();

      for (final doc in querySnapshot.docs) {
        if (doc.exists) {
          res = doc['requestNumber'];
        } else {
          res = 100;
        }
      }
    } catch (error) {
      // print(error);
    }
  }

  // add new Rent Request Documents to Collection
  Future<void> addRentRequest(BuildContext ctx) async {
    setState(() {
      isLoding = true;
    });
    final CollectionReference rentRequestREF =
        FirebaseFirestore.instance.collection('rentRequest');

    final int startSelectedDT = selectedStartDate.millisecondsSinceEpoch;
    final int endSelectedDT = selectedEndDate.millisecondsSinceEpoch;
    final int requestCreatedDateSelectedDT =
        DateTime.now().millisecondsSinceEpoch;
    await getlastid();
    await rentRequestREF.add({
      'name': _nameController.text,
      'city': cityItemSelected.title,
      'country': _countryController.text,
      'neighborhood': _neighborhoodConttroller.text,
      'notes': _notesConttroller.text,
      'phoneNumber': _phoneNumberController.text,
      'rentType': rentTypeValue,
      'requestNumber': res + 1,
      'rentalStartDate': endSelectedDT,
      'rentalEndDate': startSelectedDT,
      'requestCreatedDate': requestCreatedDateSelectedDT,
    }).then((value) {
      setState(() {
        isLoding = false;
      });
      // Provider.of<MainProvider>(ctx, listen: false).changeimageFileList([]);
      // Provider.of<MainProvider>(ctx, listen: false).changeSearchResult(
      //     FirebaseFirestore.instance.collection('sellRequest').snapshots());
      showDialogFUN(
        context: context,
        title: 'تم استلام طلبكم ...',
        orderNumber: '${res + 1}',
        page: 'RentOrder',
        // btnFunction: () {
        //   //  Provider.of<MainProvider>(ctx, listen: false)
        //   //     .changeimageFileList([]);
        //   // Provider.of<MainProvider>(ctx, listen: false).changeSearchResult(
        //   //     FirebaseFirestore.instance
        //   //         .collection('sellRequest')
        //   //         .snapshots());
        //   // Navigator.of(context).push(MaterialPageRoute<void>(
        //   //     builder: (BuildContext context) => Home()));
        //   Provider.of<MainProvider>(context, listen: false)
        //       .changesellansRentOrderShowBTN(false);
        //   Navigator.of(context).pop();
        //   Navigator.of(context).pop();
        // }
      );
    }).catchError((error) {
      setState(() {
        isLoding = false;
      });
      //Error
    });
  }

//Datepiker (Start Date)
  Future<void> _selectStartDate(BuildContext context) async {
    FocusScope.of(context).unfocus();
    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: selectedStartDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 10));
    if (selected != null && selected != selectedStartDate) {
      setState(() {
        selectedStartDate = selected;
        selectedEndDate = selectedStartDate.add(const Duration(days: 1));
        startDateLable =
            '${selectedStartDate.day}/${selectedStartDate.month}/${selectedStartDate.year}';
      });
    }
  }

  //Datepiker (End Date)
  Future<void> _selectEndDate(BuildContext context) async {
    FocusScope.of(context).unfocus();
    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: selectedEndDate,
        firstDate: selectedStartDate,
        lastDate: DateTime(DateTime.now().year + 10));
    if (selected != null && selected != selectedEndDate) {
      setState(() {
        selectedEndDate = selected;
        endDateLable =
            '${selectedEndDate.day}/${selectedEndDate.month}/${selectedEndDate.year}';
      });
    }
  }

  //List of Contry
  DropListModel citydropListModel = DropListModel([
    OptionItem(id: '1', title: 'الإسكندرية'),
    OptionItem(id: '2', title: 'الإسماعيلية'),
    OptionItem(id: '3', title: 'أسوان'),
    OptionItem(id: '4', title: 'أسيوط'),
    OptionItem(id: '5', title: 'الأقصر'),
    OptionItem(id: '6', title: 'البحر الأحمر'),
    OptionItem(id: '7', title: 'البحيرة'),
    OptionItem(id: '8', title: 'بني سويف'),
    OptionItem(id: '9', title: 'بورسعيد'),
    OptionItem(id: '10', title: 'الجيزة'),
    OptionItem(id: '11', title: 'الدقهلية'),
    OptionItem(id: '12', title: 'دمياط'),
    OptionItem(id: '13', title: 'سوهاج'),
    OptionItem(id: '14', title: 'السويس'),
    OptionItem(id: '15', title: 'الشرقية'),
    OptionItem(id: '16', title: 'جنوب سيناء'),
    OptionItem(id: '17', title: 'شمال سيناء'),
    OptionItem(id: '18', title: 'الغربية'),
    OptionItem(id: '19', title: 'الفيوم'),
    OptionItem(id: '20', title: 'القاهرة'),
    OptionItem(id: '21', title: 'القليوبية'),
    OptionItem(id: '22', title: 'قنا'),
    OptionItem(id: '23', title: 'كفر الشيخ '),
    OptionItem(id: '24', title: 'مطروح'),
    OptionItem(id: '25', title: 'المنوفية'),
    OptionItem(id: '26', title: 'الوادي الجديد'),
    OptionItem(id: '27', title: 'المنيا'),
  ]);
}

//******************** */
//   getData() async {
//     // Read date time
// //     String timeString = '2019-04-16 12:18:06.018950';
// // DateTime date = DateTime.parse(timeString);
// // print(DateFormat('yyyy-MM-dd').format(date)); // prints 2019-04-16

//     CollectionReference rentRequestREF =
//         FirebaseFirestore.instance.collection('rentRequest');
//     await rentRequestREF.get().then((value) => value.docs.forEach((element) {
//           print('=======================================');
//           print(element.data());
//           print('=======================================');
//         }));
//   }
