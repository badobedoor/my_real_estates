import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_real_estates/screens/home.dart';

import 'package:my_real_estates/wight/appWight&Theme/app_widgets.dart';
import 'package:my_real_estates/wight/appWight&Theme/theme.dart';
import 'package:my_real_estates/wight/select_drop_list.dart';
import 'package:my_real_estates/wight/smallWight/drop_list_model.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../Provider/main_provider.dart';
import '../wight/dilog/showDialog.dart';
import '../wight/imagesWights/addImage_contaner.dart';

class SellOrder extends StatefulWidget {
  const SellOrder({Key? key}) : super(key: key);
  @override
  _SellOrderState createState() => _SellOrderState();
}

class _SellOrderState extends State<SellOrder> {
  //fire base
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _countryController = TextEditingController();
  final _neighborhoodConttroller = TextEditingController();
  final _phoneNumberController = TextEditingController();

  final _secondPhoneNumberController = TextEditingController();

  final _notesConttroller = TextEditingController();
  final _addressDetailsConttroller = TextEditingController();
  final _unitPriceConttroller = TextEditingController();

  OptionItem cityItemSelected = OptionItem(id: '16', title: 'جنوب سيناء');
  OptionItem realEstatesTypeItemSelected = OptionItem(id: '1', title: 'شقه');

  final ImagePicker imagePicker = ImagePicker();
  final picker = ImagePicker();
  // List<XFile>? imageFileList = [];

  bool neighborhoodEroorChek = false;
  bool secondphoneEroorChek = false;
  bool unitPriceEroor = false;
  bool phoneEroorChek = false;
  bool nameEroorChek = false;
  bool cityEroorChek = false;
  bool isLoding = false;
  var lastId = 0;

  //قائمة المسارات

  @override
  Widget build(BuildContext context) {
    final List<XFile>? imageFileList =
        Provider.of<MainProvider>(context, listen: true).imageFileList;
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
                                    'assets/images/gradientSellOrder.png',
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
                                          TextAlign.end,
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
                                      return 'من فضلك ادخل اسمك ';
                                    }
                                  },
                                ),

                                //Contry input
                                SelectDropList(
                                  cityItemSelected,
                                  citydropListModel,
                                  (cityItem) {
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
                                  important: true,
                                  validatorValue: (val) {
                                    if (val == null || val.isNotEmpty) {
                                      setState(() {
                                        cityEroorChek = false;
                                      });
                                      return null;
                                    } else if (val.isEmpty) {
                                      setState(() {
                                        cityEroorChek = true;
                                      });
                                      return '  من فضلك اكمل البيانات ';
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
                                  important: true,
                                  validatorValue: (val) {
                                    if (val == null || val.isNotEmpty) {
                                      setState(() {
                                        neighborhoodEroorChek = false;
                                      });
                                      return null;
                                    } else if (val.isEmpty) {
                                      setState(() {
                                        neighborhoodEroorChek = true;
                                      });
                                      return '  من فضلك اكمل البيانات';
                                    }
                                  },
                                ),
                                //Address details input
                                multilineTextField(
                                    width: 315.w,
                                    height: 160.h,
                                    context: context,
                                    rowCount: 3,
                                    controller: _addressDetailsConttroller,
                                    inputType: TextInputType.multiline,
                                    hintText: '''
مثال (رقم العقار او الشقه) -
مثال (بجوار كذا او امام كذا) -
مثال (يطل على كذه مباشرة) -
''',
                                    lableText: 'العنوان التفصيلى'),

                                //unit type input
                                SelectDropList(
                                  realEstatesTypeItemSelected,
                                  realEstatesTypeModel,
                                  (realEstatesType) {
                                    realEstatesTypeItemSelected =
                                        realEstatesType;
                                    setState(() {});
                                  },
                                  'نوع العقار',
                                ),

                                //add photo
                                AddimageContainer(imageFileList: imageFileList),

                                //add unit price input
                                textPriceField(
                                  width: 315.w,
                                  context: context,
                                  controller: _unitPriceConttroller,
                                  inputType: TextInputType.number,
                                  hintText: '20000000',
                                  lableText: 'السعر المطلوب',
                                  eroorChek: unitPriceEroor,
                                  keyText: 'unitPrice',
                                  important: true,
                                  validatorValue: (val) {
                                    if (val!.isEmpty || val[0] == '0') {
                                      setState(() {
                                        unitPriceEroor = true;
                                      });
                                      return 'من فضلك ادخل رقم صحيح';
                                    } else if (val.isNotEmpty) {
                                      setState(() {
                                        unitPriceEroor = false;
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

                                //phone another number input
                                textPhoneField(
                                  width: 315,
                                  context: context,
                                  controller: _secondPhoneNumberController,
                                  inputType: TextInputType.phone,

                                  wightMargin: EdgeInsets.only(bottom: 25.h),
                                  hintText: '010100200300',
                                  lableText: 'رقم هاتف اضافي',
                                  // validatorValue: ,

                                  validatorValue: (val) {
                                    final List<String> values = [
                                      '0',
                                      '1',
                                      '2',
                                      '5'
                                    ];
                                    if (val == null || val.isEmpty) {
//no Error
                                      setState(() {
                                        secondphoneEroorChek = false;
                                      });
                                      return null;
                                    } else if (val.length < 11 ||
                                        val[0] != '0' ||
                                        val[1] != '1') {
                                      //Error
                                      setState(() {
                                        secondphoneEroorChek = true;
                                      });
                                      return 'من فضلك ادخل رقم هاتف صحيح';
                                    } else if (values.contains(val[2])) {
                                      // true no error
                                      setState(() {
                                        secondphoneEroorChek = false;
                                      });
                                      return null;
                                    } else {
// false error
                                      setState(() {
                                        secondphoneEroorChek = true;
                                      });
                                      return 'من فضلك ادخل رقم هاتف صحيح';
                                    }
                                  },

                                  keyText: 'Phone',
                                  eroorChek: secondphoneEroorChek,
                                ),
                                //add nots
                                multilineTextField(
                                    width: 315.w,
                                    height: 160.h,
                                    context: context,
                                    rowCount: 8,
                                    controller: _notesConttroller,
                                    inputType: TextInputType.multiline,
                                    hintText: '''
مثال (مستوى راقي وبها تكييفات ... الخ) -
مثال (قريبة من موقف او مدرسة كذا ... الخ) -
مثال (بحري او دور ارضي فقط ... الخ) -
مثال (عدد الغرف لا تقل عن 3 ... الخ) -
مثال (رجاء التواصل بعد الواحدة ظهرا ... الخ) -
مثال (احتاج مده طويلة ... الخ) -
''',
                                    lableText: 'ملاحظات'),
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
                                    ontapBtnFun: () {
                                      FocusScope.of(context).unfocus();
                                      final isValid =
                                          _formKey.currentState!.validate();
                                      FocusScope.of(context).unfocus();
                                      if (isValid) {
                                        _formKey.currentState!.save();
                                        addSellRequest(context);
                                      }
                                    },
                                    backBtnFun: () {
                                      FocusScope.of(context).unfocus();
                                      Provider.of<MainProvider>(context,
                                              listen: false)
                                          .changeimageFileList([]);
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                const Home()),
                                      );
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
              if (isLoding)
                Container(
                  width: 375.w,
                  height: 812.h,
                  color: AppColors.black.withOpacity(0.80),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(height: 0.h),
                      SizedBox(height: 0.h),
                      SizedBox(height: 0.h),
                      SizedBox(height: 20.h),
                      Column(children: [
                        SizedBox(
                          width: 50.w,
                          height: 50.w,
                          child: CircularProgressIndicator(
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(height: 40.h),
                        buildText('جاري العمل على تنفيذ طلبكم ...', 20.sp,
                            AppColors.white, FontWeight.w700, TextAlign.center),
                      ]),
                      SizedBox(height: 90.h),
                      Column(children: [
                        buildText('تستغرق هذه العمليه بعض الوقت', 20.sp,
                            AppColors.white, FontWeight.w500, TextAlign.center),
                        SizedBox(height: 10.h),
                        buildText('شكرا لتفهمكم', 20.sp, AppColors.white,
                            FontWeight.w500, TextAlign.center),
                      ]),
                      SizedBox(height: 0.h),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  //get the last id
  Future<int> getlastid() async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('sellRequest')
          .orderBy('requestNumber', descending: true)
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final QueryDocumentSnapshot<Object?> doc = querySnapshot.docs.first;
        // setState(() {
        //   lastId = doc['requestNumber'];
        // });
        final int res = doc['requestNumber'];

        return res;
      } else {
        const int res = 100;
        return res;
      }
    } catch (error) {
      const int res = 100;
      return res;
    }
  }

  Future<void> addSellRequest(BuildContext ctx) async {
    setState(() {
      isLoding = true;
    });
    lastId = await getlastid();
    await uploudSellRequestImages(ctx);

    final List<XFile>? imageFileList =
        Provider.of<MainProvider>(ctx, listen: false).imageFileList;

    if (imageFileList!.isEmpty) {
      return;
    }
  }

//upload images
  Future<void> uploudSellRequestImages(BuildContext ctx) async {
    Provider.of<MainProvider>(ctx, listen: false).clearImageList();
    final List<XFile>? imageFileList =
        Provider.of<MainProvider>(ctx, listen: false).imageFileList;
    if (imageFileList!.isNotEmpty) {
      try {
        final List<dynamic> testList = [];
        for (final XFile i in imageFileList) {
          final File file = File(i.path);
          var nameImage = i.name;
          final int random = Random().nextInt(100000000);
          nameImage = '$random$nameImage';
          testList.add(nameImage);
          final Reference ref = FirebaseStorage.instance.ref().child(nameImage);
          await ref.putFile(file);

          final String res = await FirebaseStorage.instance
              .ref()
              .child(nameImage)
              .getDownloadURL();
          await Provider.of<MainProvider>(ctx, listen: false)
              .addToImageList(res);
        }
        await add(ctx);
      } on FirebaseException catch (_) {
        setState(() {
          isLoding = false;
        });
        showEroorDialogFUN(
            context: ctx,
            title: 'خطأ',
            eroorText:
                'خطا فى ارسال البيانات الرجاء التاكد من الانترنت ومحاوده المحاوله');

        return;
      }
    } else {
      setState(() {
        isLoding = false;
      });
      showEroorDialogFUN(
          context: ctx,
          title: 'تنبيه',
          eroorText: 'برجاء رفع صور للعقار حتى يتم تاكيد الطلب');
    }
  }

  Future<void> add(BuildContext ctx) async {
    final CollectionReference sellRequestREF =
        FirebaseFirestore.instance.collection('sellRequest');
    final List<String> imageList =
        Provider.of<MainProvider>(ctx, listen: false).imageList;
    final int requestCreatedDateSelectedDT =
        DateTime.now().millisecondsSinceEpoch;
    await sellRequestREF.add({
      'requestNumber': lastId + 1,
      'name': _nameController.text,
      'city': cityItemSelected.title,
      'country': _countryController.text,
      'neighborhood': _neighborhoodConttroller.text,
      'notes': _notesConttroller.text,
      'addressDetails': _addressDetailsConttroller.text,
      'unitPrice': int.parse(_unitPriceConttroller.text),
      'orderStatus': 'جديد',
      'phoneNumber': _phoneNumberController.text,
      'secondPhoneNumber': _secondPhoneNumberController.text,
      'requestCreatedDate': requestCreatedDateSelectedDT,
      'imageList': imageList,
    }).then((value) {
      setState(() {
        isLoding = false;
      });
      showDialogFUN(
          context: ctx,
          title: 'تم استلام طلبكم ...',
          orderNumber: '${lastId + 1}',
          page: 'SellOrder',
          btnFunction: () {
            // Provider.of<MainProvider>(ctx, listen: false)
            //     .changeimageFileList([]);
            // Provider.of<MainProvider>(ctx, listen: false).changeSearchResult(
            // FirebaseFirestore.instance
            //     .collection('sellRequest')
            //     .snapshots());
            // Navigator.of(ctx).pushReplacement(
            //   MaterialPageRoute<void>(
            //       builder: (BuildContext context) => Home()),
            // );
            // Provider.of<MainProvider>(context, listen: false)
            //     .changeimageFileList([]);
            // Provider.of<MainProvider>(ctx, listen: false)
            //     .changesellansRentOrderShowBTN(false);
            // Navigator.of(ctx).pop();
            // Navigator.of(ctx).pop();
            // Navigator.of(ctx).pop();
          });
    }).catchError((error) {
      setState(() {
        isLoding = false;
      });
      showEroorDialogFUN(
          context: ctx,
          title: 'خطأ',
          eroorText:
              'خطا فى ارسال البيانات الرجاء التاكد من الانترنت ومحاوده المحاوله');
    });
  }

  // add new Sell Request Documents to Collection

  //city drop List
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
//realEstates Type drop List
  DropListModel realEstatesTypeModel = DropListModel([
    OptionItem(id: '1', title: 'شقه'),
    OptionItem(id: '2', title: 'استديو'),
    OptionItem(id: '3', title: 'بيت'),
    OptionItem(id: '4', title: 'محل'),
  ]);
}
