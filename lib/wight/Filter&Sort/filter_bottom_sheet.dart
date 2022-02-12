import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_real_estates/wight/appWight&Theme/app_widgets.dart';
import 'package:my_real_estates/wight/appWight&Theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../Provider/main_provider.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({Key? key}) : super(key: key);

  @override
  _FilterBottomSheet createState() => _FilterBottomSheet();
}

// changeFilterBottomSheetIsOpen
class _FilterBottomSheet extends State<FilterBottomSheet>
    with SingleTickerProviderStateMixin {
  TextEditingController smalTextController = TextEditingController();
  TextEditingController bigTextController = TextEditingController();
  late AnimationController expandController;
  late Animation<double> animation;
  // late AnimationController _controller;
  // late Animation _moveAnimation;

  final FocusNode _smalestFocusNode = FocusNode();
  final FocusNode _bigestFocusNode = FocusNode();
  bool dropdownlistIsOpen = false;
  List<String> selectedCtiy = [];
  var smalestUnitPrice = 0;
  var bigestUnitPrice = 0;
  List<dynamic> townList = [];
  //get the last id
  Future<int> getbigestUnitPrice() async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('sellRequest')
          .where('orderStatus', whereIn: ['مقبول', 'محجوز'])
          .orderBy('unitPrice', descending: true)
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final QueryDocumentSnapshot<Object?> doc = querySnapshot.docs.first;
        // setState(() {
        //   lastId = doc['requestNumber'];
        // });
        final int res = doc['unitPrice'];
        setState(() {
          bigestUnitPrice = doc['unitPrice'] ?? 0;
          // bigTextController.text = bigestUnitPrice.toString();
        });
        // bigestUnitPrice = doc['unitPrice'];

        return res;
      } else {
        const int res = 0;
        return res;
      }
    } catch (error) {
      // int res = 500;
      return 0;
    }
  }

  Future<int> getsmalestUnitPrice() async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('sellRequest')
          .where('orderStatus', whereIn: ['مقبول', 'محجوز'])
          .orderBy('unitPrice', descending: false)
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final QueryDocumentSnapshot<Object?> doc = querySnapshot.docs.first;
        // setState(() {
        //   lastId = doc['requestNumber'];
        // });
        final int res = doc['unitPrice'];
        setState(() {
          smalestUnitPrice = doc['unitPrice'] ?? 0;
          // smalTextController.text = smalestUnitPrice.toString();
        });
        smalestUnitPrice = doc['unitPrice'];

        return res;
      } else {
        const int res = 0;
        return res;
      }
    } catch (error) {
      // int res = 500;
      return 0;
    }
  }

  @override
  void initState() {
    super.initState();
    getbigestUnitPrice();
    getsmalestUnitPrice();

    expandController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 550));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    // _controller =
    //     AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    // _moveAnimation = Tween(begin: 300.0, end: 50.0).animate(_controller)
    // ..addListener(() {
    // setState(() {});
    // });

    // _focusNode.addListener(() {
    // if (_focusNode.hasFocus) {
    // _controller.forward();
    // } else {
    // _controller.reverse();
    // }
    // });
  }

  @override
  void dispose() {
    expandController.dispose();
    // _controller.dispose();
    // _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<MainProvider>(context, listen: true)
    //     .filterBottomSheetDropdownlistIsOpen;
    //List of Contry

    bool filterBottomSheetIsOpen =
        Provider.of<MainProvider>(context, listen: true)
            .filterBottomSheetIsOpen;
    final List<dynamic> towns = [
      ['الإسكندرية', false],
      ['الإسماعيلية', false],
      ['أسوان', false],
      ['أسيوط', false],
      ['الأقصر', false],
      ['البحر الأحمر', false],
      ['البحيرة', false],
      ['بني سويف', false],
      ['بورسعيد', false],
      ['الجيزة', false],
      ['الدقهلية', false],
      ['دمياط', false],
      ['سوهاج', false],
      ['السويس', false],
      ['الشرقية', false],
      ['جنوب سيناء', false],
      ['شمال سيناء', false],
      ['الغربية', false],
      ['الفيوم', false],
      ['القاهرة', false],
      ['القليوبية', false],
      ['قنا', false],
      ['كفر الشيخ ', false],
      ['مطروح', false],
      ['المنوفية', false],
      ['المنوفية', false],
      ['الوادي الجديد', false],
      ['المنيا', false],
    ];
    return GestureDetector(
      onTap: () {
        Provider.of<MainProvider>(context, listen: false)
            .changeFilterBottomSheetIsOpen(true);
        filterBottomSheetIsOpen =
            Provider.of<MainProvider>(context, listen: false)
                .filterBottomSheetIsOpen;
        getbigestUnitPrice();
        getsmalestUnitPrice();
        if (filterBottomSheetIsOpen) {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0.sp),
                topRight: Radius.circular(10.0.sp),
              )),
              builder: (builder) {
                return StatefulBuilder(builder: (BuildContext context,
                    StateSetter setState /*You can rename this!*/) {
                  return GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: Stack(
                      children: [
                        // BottomSheet Contaner
                        // _focusNode.addListener(() {
                        // if (_focusNode.hasFocus) {
                        // _controller.forward();
                        // } else {
                        // _controller.reverse();
                        // }
                        // });
                        Container(
                          height: dropdownlistIsOpen
                              ? 653.h
                              : _smalestFocusNode.hasFocus ||
                                      _bigestFocusNode.hasFocus
                                  ? 583.h
                                  : 368.h,
                          width: 375.w,
                          color: Colors.black.withOpacity(0.01),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 0,
                                left: 0,
                                // BottomSheet Contaner

                                child: Container(
                                  height: dropdownlistIsOpen
                                      ? 639.h
                                      : _smalestFocusNode.hasFocus ||
                                              _bigestFocusNode.hasFocus
                                          ? 570.h
                                          : 355.h,
                                  width: 375.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0.sp),
                                      topRight: Radius.circular(10.0.sp),
                                    ),
                                  ),
                                  child: Container(
                                    // color: AppColors.black.withOpacity(0.15),
                                    width: 315.w,
                                    // height: 280.h,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 40.sp, horizontal: 30.sp),
                                    child: Column(
                                      children: [
                                        //اختر الفلتر المناسب
                                        Container(
                                          margin: EdgeInsets.only(right: 5.sp),
                                          alignment: Alignment.centerRight,
                                          child: buildText(
                                            'اختر الفلتر المناسب ...',
                                            20.sp,
                                            AppColors.blue100,
                                            FontWeight.w700,
                                            TextAlign.right,
                                          ),
                                        ),
                                        SizedBox(height: 22.h),
                                        // price Container
                                        buildCardContainer(
                                          300,
                                          106,
                                          10,
                                          //السعر
                                          Column(
                                            children: [
                                              // SizedBox(
                                              // height:
                                              // _moveAnimation.value),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    right: 20.w,
                                                    top: 20.h,
                                                    bottom: 15.h),
                                                alignment:
                                                    Alignment.centerRight,
                                                child: buildText(
                                                  'السعر:',
                                                  20.sp,
                                                  AppColors.blue100,
                                                  FontWeight.w700,
                                                  TextAlign.right,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(width: 26.w),
                                                  GestureDetector(
                                                    onTap: () =>
                                                        FocusScope.of(context)
                                                            .requestFocus(
                                                                FocusNode()),
                                                    child: buildPriceTextfield(
                                                        '$bigestUnitPrice',
                                                        _bigestFocusNode,
                                                        bigTextController),
                                                  ),
                                                  SizedBox(width: 10.w),
                                                  buildText(
                                                    'إلى:',
                                                    20.sp,
                                                    AppColors.blue100,
                                                    FontWeight.w400,
                                                    TextAlign.right,
                                                  ),
                                                  SizedBox(width: 45.w),
                                                  GestureDetector(
                                                    onTap: () =>
                                                        FocusScope.of(context)
                                                            .requestFocus(
                                                                FocusNode()),
                                                    child: buildPriceTextfield(
                                                        '$smalestUnitPrice',
                                                        _smalestFocusNode,
                                                        smalTextController),
                                                  ),
                                                  SizedBox(width: 10.w),
                                                  buildText(
                                                    'من:',
                                                    20.sp,
                                                    AppColors.blue100,
                                                    FontWeight.w400,
                                                    TextAlign.right,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 15.h),
                                        GestureDetector(
                                          onTap: () {
                                            FocusScope.of(context).unfocus();
                                            // Provider.of<MainProvider>(context,
                                            //         listen: false)
                                            //     .changeFilterBottomSheetDropdownlistIsOpen(
                                            //         !dropdownlistIsOpen);
                                            //  onTap: () {
                                            //   this.optionItemSelected = item;
                                            //   isShow = false;
                                            //   expandController.reverse();
                                            //   widget.onOptionSelected(item);
                                            // },

                                            //  expandController.reverse();
                                            setState(() {
                                              dropdownlistIsOpen =
                                                  !dropdownlistIsOpen;
                                              if (dropdownlistIsOpen == true) {
                                                expandController.forward();
                                              } else {
                                                expandController.reverse();
                                              }
                                            });
                                            // _runExpandCheck();
                                          },
                                          child: //Contry input

                                              buildCardContainer(
                                                  300,
                                                  40,
                                                  10,
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 16.sp,
                                                        right: 20.sp,
                                                        top: 5.sp),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 8),
                                                          child: Icon(
                                                            dropdownlistIsOpen
                                                                ? Icons
                                                                    .expand_more_rounded
                                                                : Icons
                                                                    .arrow_back_ios_outlined,
                                                            color: AppColors
                                                                .blue100,
                                                            size: 25.sp,
                                                          ),
                                                        ),
                                                        buildText(
                                                          'المحافظة',
                                                          20.sp,
                                                          AppColors.blue100,
                                                          FontWeight.w700,
                                                          TextAlign.right,
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                        ),
                                        SizedBox(height: 10.h),
                                        if (dropdownlistIsOpen)
                                          SizeTransition(
                                            axisAlignment: 1,
                                            sizeFactor: animation,
                                            child: Container(
                                              width: 300.w,
                                              height: 280.h,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 7.w),
                                              color: AppColors.blue100
                                                  .withOpacity(0.05),
                                              child: SingleChildScrollView(
                                                child: SizedBox(
                                                  width: 290.w,
                                                  height: 280.h,
                                                  child: ListView.builder(
                                                      itemCount: towns.length,
                                                      //semanticChildCount: 5,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int i) {
                                                        return Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      2.5.sp,
                                                                  horizontal:
                                                                      5.sp),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                towns[i][1] =
                                                                    !towns[i]
                                                                        [1];
                                                              });
                                                            },
                                                            child:
                                                                buildCardContainer(
                                                              290,
                                                              40,
                                                              4,
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left: 16
                                                                            .sp,
                                                                        right: 20
                                                                            .sp,
                                                                        top: 5
                                                                            .sp),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          bottom:
                                                                              8),
                                                                      child: imageContainer(
                                                                          20,
                                                                          20,
                                                                          towns[i][1] == false
                                                                              ? 'assets/images/chekBox.png'
                                                                              : 'assets/images/chekBoxDon.png',
                                                                          BoxFit
                                                                              .fill),
                                                                    ),
                                                                    buildText(
                                                                      towns[i]
                                                                          [0],
                                                                      20.sp,
                                                                      AppColors
                                                                          .blue100,
                                                                      FontWeight
                                                                          .w500,
                                                                      TextAlign
                                                                          .right,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                  // ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        SizedBox(height: 19.h),

                                        Row(
                                          children: [
                                            SizedBox(width: 8.w),
                                            GestureDetector(
                                              onTap: () {
                                                Provider.of<MainProvider>(
                                                        context,
                                                        listen: false)
                                                    .changeSearchResult(
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'sellRequest')
                                                            .where(
                                                                'orderStatus',
                                                                whereIn: [
                                                      'مقبول',
                                                      'محجوز'
                                                    ]).snapshots());
                                                FocusScope.of(context)
                                                    .unfocus();
                                                Navigator.of(context).pop();
                                              },
                                              child: Container(
                                                width: 60.w,
                                                height: 40.h,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.sp),
                                                    border: Border.all(
                                                        color: AppColors.pink,
                                                        width: 1.5.sp)),
                                                alignment: Alignment.center,
                                                child: buildText(
                                                  'إلغاء',
                                                  20.sp,
                                                  AppColors.pink,
                                                  FontWeight.w400,
                                                  TextAlign.right,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10.w),
                                            GestureDetector(
                                              onTap: () async {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                int smal;
                                                int big;
                                                if (smalTextController.text ==
                                                    '') {
                                                  smal = smalestUnitPrice;
                                                } else {
                                                  smal = int.tryParse(
                                                          smalTextController
                                                              .text) ??
                                                      smalestUnitPrice;
                                                }
                                                if (bigTextController.text ==
                                                    '') {
                                                  big = bigestUnitPrice;
                                                } else {
                                                  big = int.tryParse(
                                                          bigTextController
                                                              .text) ??
                                                      bigestUnitPrice;
                                                }

                                                // List<dynamic> townList = [];
                                                getFilterTowns(towns);

                                                //fire base
                                                if (townList.isNotEmpty &&
                                                    smal != -1 &&
                                                    big != -1) {
                                                  Provider.of<MainProvider>(
                                                          context,
                                                          listen: false)
                                                      .changeSearchResult(
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'sellRequest')
                                                              .where(
                                                                'orderStatus',
                                                                isEqualTo:
                                                                    'مقبول',
                                                              )
                                                              .where('city',
                                                                  whereIn:
                                                                      townList)
                                                              .where(
                                                                  'unitPrice',
                                                                  isGreaterThanOrEqualTo:
                                                                      smal)
                                                              .where(
                                                                  'unitPrice',
                                                                  isLessThanOrEqualTo:
                                                                      big)
                                                              .snapshots());
                                                } else if (townList.isEmpty &&
                                                    townList.isEmpty &&
                                                    smal != -1 &&
                                                    big != -1) {
                                                  Provider.of<MainProvider>(
                                                          context,
                                                          listen: false)
                                                      .changeSearchResult(
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'sellRequest')
                                                              .where(
                                                                'orderStatus',
                                                                isEqualTo:
                                                                    'مقبول',
                                                              )
                                                              .where(
                                                                  'unitPrice',
                                                                  isGreaterThanOrEqualTo:
                                                                      smal)
                                                              .where(
                                                                  'unitPrice',
                                                                  isLessThanOrEqualTo:
                                                                      big)
                                                              .snapshots());
                                                } else {
                                                  //ERRoR
                                                }
                                                Navigator.of(context).pop();
                                              },
                                              child: Container(
                                                width: 230.w,
                                                height: 40.h,
                                                decoration: BoxDecoration(
                                                    gradient:
                                                        const LinearGradient(
                                                            colors: [
                                                          Color(0xff52A0F8),
                                                          Color(0xff6E52FC)
                                                        ],
                                                            stops: [
                                                          0.0,
                                                          1.0
                                                        ],
                                                            begin:
                                                                FractionalOffset
                                                                    .centerLeft,
                                                            end: FractionalOffset
                                                                .centerRight,
                                                            tileMode: TileMode
                                                                .repeated),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.sp),
                                                    border: Border.all(
                                                        color: Colors
                                                            .transparent, // Colors.white,
                                                        width: 1.5.sp)),
                                                alignment: Alignment.center,
                                                child: Container(
                                                  width: 228.w,
                                                  height: 38.h,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.sp),
                                                      border: Border.all(
                                                          color: Colors
                                                              .transparent, // Colors.white,
                                                          width: 1.5.sp)),
                                                  alignment: Alignment.center,
                                                  child:
                                                      //  isOpen?
                                                      GradientText(
                                                    'فلتر',
                                                    style: TextStyle(
                                                        fontSize: 20.sp,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily: 'Tajawal'),
                                                    colors: const [
                                                      Color(0xff52A0F8),
                                                      Color(0xff6E52FC)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
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
                                      borderRadius:
                                          BorderRadius.circular(25.sp),
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
                    ),
                  );
                });
              }).whenComplete(() {
            Provider.of<MainProvider>(context, listen: false)
                .changeFilterBottomSheetIsOpen(!filterBottomSheetIsOpen);
            setState(() {});
          });
        }
      },
      //filter Button
      child: Container(
        width: 170.w,
        height: 40.h,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  if (filterBottomSheetIsOpen)
                    const Color(0xff52A0F8)
                  else
                    AppColors.white.withOpacity(0.01),
                  if (filterBottomSheetIsOpen)
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
              'فلتر',
              20,
              AppColors.white,
              FontWeight.w700,
              TextAlign.right,
            ),
            SizedBox(width: 10.w),
            imageContainer(18, 18, 'assets/images/filter.png', BoxFit.fill),
          ],
        ),
      ),
    );
  }

  List<dynamic> getFilterTowns(List<dynamic> towns) {
    final List<dynamic> listResult = [];
    // = towns.where((item) => item[0][1] == true).toList();
    for (final item in towns) {
      if (item[1] == true) {
        listResult.add(item[0]);
      }
    }
    setState(() {
      townList = listResult;
    });
    return listResult;
  }

  Padding listViewContent(List<dynamic> towns, int i) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.5.sp, horizontal: 5.sp),
      child: GestureDetector(
        onTap: () {
          setState(() {
            towns[i][1] = !towns[i][1];
          });
        },
        child: buildCardContainer(
          290,
          40,
          4,
          Padding(
            padding: EdgeInsets.only(left: 16.sp, right: 20.sp, top: 5.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: imageContainer(
                      18,
                      18,
                      towns[i][1] == false
                          ? 'assets/images/chekBox.png'
                          : 'assets/images/chekBoxDon.png',
                      BoxFit.fill),
                ),
                buildText(
                  towns[i][0],
                  20.sp,
                  AppColors.blue100,
                  FontWeight.w500,
                  TextAlign.right,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildPriceTextfield(String _hintText, FocusNode _focusNode,
      TextEditingController controller) {
    return Container(
      height: 24.h,
      width: 70.w,
      padding: EdgeInsets.only(top: 5.h, left: 4.w, bottom: 3.h),
      decoration: BoxDecoration(
        color: AppColors.blue100.withOpacity(0.20),
        borderRadius: BorderRadius.circular(5.sp),
      ),
      child: TextField(
        // overflow: TextOverflow.clip,
        onEditingComplete: unfocusKeyboard,
        inputFormatters: [
          LengthLimitingTextInputFormatter(8),
        ],
        focusNode: _focusNode,
        controller: controller,
        keyboardType: TextInputType.number,

        textAlign: TextAlign.left,
        style: TextStyle(
            overflow: TextOverflow.clip,
            fontSize: 13.sp,
            fontFamily: 'Tajawal',
            fontWeight: FontWeight.w400,
            // height: 0.6,
            color: AppColors.blue100.withOpacity(0.80)),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: _hintText,
          hintStyle: TextStyle(
              overflow: TextOverflow.clip,
              height: 0.6,
              fontSize: 13.sp,
              fontFamily: 'Tajawal',
              fontWeight: FontWeight.w400,
              color: AppColors.blue100.withOpacity(0.50)),
        ),
      ),
    );
  }

  void unfocusKeyboard() {
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
