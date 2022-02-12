import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:my_real_estates/Provider/main_provider.dart';
import 'package:my_real_estates/screens/real_estate_details.dart';
import 'package:my_real_estates/screens/rent_order_page.dart';
import 'package:my_real_estates/wight/Filter&Sort/filter_bottom_sheet.dart';
import 'package:my_real_estates/wight/appWight&Theme/app_widgets.dart';
import 'package:my_real_estates/wight/appWight&Theme/theme.dart';
import 'package:provider/provider.dart';

import '../wight/Filter&Sort/sort_botttomsheet.dart';
import '../wight/animation_search_bar.dart';
import '../wight/dilog/Privacy_dilog.dart';
import '../wight/dilog/sell_order_ready_dialogpage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  // const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  late Stream<QuerySnapshot<Map<String, dynamic>>> adRef;

  bool iamReadySellShowDilog = false;
  bool sellansRentOrderShowBTN = false;

  // PersistentBottomSheetController _controller;
  @override
  Widget build(BuildContext context) {
    // var adRef = FirebaseFirestore.instance.collection('sellRequest');
    try {
      adRef = Provider.of<MainProvider>(context, listen: true).searchResult;
    } on StateError catch (e) {
      print(e.message);
    }

    final bool isloding =
        Provider.of<MainProvider>(context, listen: true).isLoding;
    sellansRentOrderShowBTN = Provider.of<MainProvider>(context, listen: true)
        .sellansRentOrderShowBTN;
    iamReadySellShowDilog =
        Provider.of<MainProvider>(context, listen: true).iamReadySellShowDilog;

    // adRef
    //     .where('unitPrice', isGreaterThanOrEqualTo: 80)
    //     .where('unitPrice', isLessThanOrEqualTo: 8000)
    //     .where('city', isEqualTo: 'city');

    // Stream<QuerySnapshot<Map<String, dynamic>>> res = adRef.snapshots();
    // res = adRef
    //     .where('unitPrice', isGreaterThanOrEqualTo: 500)
    //     .where('unitPrice', isLessThanOrEqualTo: 350000)
    //     .where('city', isEqualTo: 'جنوب سيناء')
    //     .snapshots();
    // res = adRef.orderBy('unitPrice', descending: true).snapshots();
    // res = adRef
    //     .where('unitPrice', isGreaterThanOrEqualTo: 500, 'city', isEqualTo: 'جنوب سيناء')
    //     .where('unitPrice', isLessThanOrEqualTo: 350000)
    //     .where()
    //     .orderBy('unitPrice', descending: true)
    //     .snapshots();
    //all FirebaseFirestore.instance.collection('sellRequest');
    //
    //order by // FirebaseFirestore.instance.collection('sellRequest').orderBy('unitPrice', descending: true);
    //
//filtter by FirebaseFirestore.instance.collection('sellRequest')
    // .where('unitPrice' ,isGreaterThanOrEqualTo: smal value)
    // .where('unitPrice' ,isLessThanOrEqualTo: big value)
    // .where('city',isEqualTo: 'city' );
    return Theme(

        // We need this theme override so that the corners of the bottom sheet modal can be rounded
        data: ThemeData(canvasColor: Colors.transparent),
        child: Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Container(
                  color: AppColors.darkblue,
                  child: Stack(
                    children: [
                      // Placeholder(),
                      Column(
                        children: [
                          AnimSearchBar(
                            width: 375.w,
                            rtl: true,

                            // color: AppColors.green,
                            helpText: 'ابحث هنا',
                            closeSearchOnSuffixTap: true,
                            style: const TextStyle(),
                            // prefixIcon: Icon(Icons.search),
                            // suffixIcon: Icon(Icons.close),
                            textController: textController,
                            onSuffixTap: () {
                              setState(() {
                                textController.clear();
                              });
                            },
                          ),
                          SizedBox(height: 10.h),
                          //زرار الفلتر والترتيب
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SortBotttomsheet(),
                              SizedBox(width: 10.w),
                              FilterBottomSheet(),
                              //**********************************************************/
                            ],
                          ),
                          SizedBox(height: 25.h),
                          // SizedBox(height: 226.h),
                          Expanded(
                            // height: 648.h,
                            // width: 375.w,
                            // color: AppColors.white,

                            // child: Padding(
                            //   padding: const EdgeInsets.all(
                            //       16.0), //محتاج هنا تعديل

                            child: StreamBuilder<QuerySnapshot>(
                              stream: adRef,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data!.docs.isEmpty) {
                                    return noDataContainer();
                                  }
                                  //data
                                  return ListView.builder(
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder:
                                          (BuildContext context, int i) {
                                        // var s =    snapshot.data!.docs[i].get('unitPrice');
                                        //  snapshot.data!.docs.first['unitPrice'];

                                        // dinamic
                                        //'اعلان',
                                        //   // snapshot
                                        //     .data!.docs[i]
                                        //     .get(
                                        //         'unitPrice'),
                                        return GestureDetector(
                                          onTap: () {
                                            final String id =
                                                snapshot.data!.docs[i].id;
                                            Provider.of<MainProvider>(context,
                                                    listen: false)
                                                .changeSellRequestDocumentId(
                                                    id);
                                            changeimageList(snapshot, i);
                                            // await getFirebaseImageFolder(
                                            //     context,
                                            //     '${snapshot.data!.docs[i].get('requestNumber')}');
                                            // addImageList(context,
                                            //     '${snapshot.data!.docs[i].get('requestNumber')}');
                                            Provider.of<MainProvider>(context,
                                                    listen: false)
                                                .changeUnitNumber(
                                                    '${snapshot.data!.docs[i].get('requestNumber')}');
                                            Navigator.of(context).push(
                                              MaterialPageRoute<void>(
                                                  builder: (BuildContext
                                                          context) =>
                                                      const RealEstateDetails()),
                                            );
                                          },
                                          child: Container(
                                            width: 350.w,
                                            height: 105.h,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 15.sp,
                                                vertical: 10.sp),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10.sp),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColors.white
                                                      .withOpacity(0.20),
                                                  blurRadius: 15,
                                                ),
                                              ],
                                            ),
                                            clipBehavior: Clip.antiAlias,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    SizedBox(height: 10.h),
                                                    buildText(
                                                      snapshot.data!.docs[i]
                                                          .get('AdTitle'),
                                                      12.sp,
                                                      AppColors.purple,
                                                      FontWeight.w700,
                                                      TextAlign.center,
                                                    ),
                                                    SizedBox(height: 6.h),
                                                    Row(
                                                      children: [
                                                        buildText(
                                                          'ج.م  ',
                                                          12.sp,
                                                          AppColors.blue100,
                                                          FontWeight.w700,
                                                          TextAlign.center,
                                                        ),
                                                        buildText(
                                                          '${snapshot.data!.docs[i].get('unitPrice')}',
                                                          //'500000',
                                                          15.sp,
                                                          AppColors.blue100,
                                                          FontWeight.w700,
                                                          TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 4.h),
                                                    Row(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            buildText(
                                                              'زيادة سنوية',
                                                              11.sp,
                                                              AppColors.blue100,
                                                              FontWeight.w700,
                                                              TextAlign.center,
                                                            ),
                                                            SizedBox(
                                                                width: 5.w),
                                                            buildText(
                                                                //' 13% ',
                                                                '${snapshot.data!.docs[i].get('AnnualIncrementValue')}%',
                                                                15.sp,
                                                                AppColors.green,
                                                                FontWeight.w700,
                                                                TextAlign
                                                                    .center),
                                                          ],
                                                        ),
                                                        SizedBox(width: 20.w),
                                                        SizedBox(
                                                          width: 105.w,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              buildText(
                                                                'عائد سنوى',
                                                                11.sp,
                                                                AppColors
                                                                    .blue100,
                                                                FontWeight.w700,
                                                                TextAlign
                                                                    .center,
                                                              ),
                                                              buildText(
                                                                '${snapshot.data!.docs[i].get('annualReturnValue')}',
                                                                // '5000',
                                                                15.sp,
                                                                AppColors.green,
                                                                FontWeight.w700,
                                                                TextAlign
                                                                    .center,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 2.h),
                                                    Row(
                                                      children: [
                                                        buildText(
                                                            'ج.م    ',
                                                            12.sp,
                                                            AppColors.blue100,
                                                            FontWeight.w700,
                                                            TextAlign.center),
                                                        buildText(
                                                            '${snapshot.data!.docs[i].get('ExpectedAnnualIncome').toInt()}',
                                                            // '8000 ',
                                                            15.sp,
                                                            AppColors.purple,
                                                            FontWeight.w700,
                                                            TextAlign.center),
                                                        SizedBox(width: 28.w),
                                                        buildText(
                                                          ' اجمالي العائد السنوي ',
                                                          11.sp,
                                                          AppColors.blue100,
                                                          FontWeight.w700,
                                                          TextAlign.center,
                                                        ),
                                                        // SizedBox(width: 8.w),
                                                      ],
                                                    ),
                                                    // SizedBox(height: 8.h),
                                                  ],
                                                ),
                                                SizedBox(width: 10.w),
                                                if (getimage(snapshot, i) == '')
                                                  imageContainer(
                                                      100,
                                                      105,
                                                      'assets/images/placeholderImage.jpg',
                                                      BoxFit.fill),
                                                if (getimage(snapshot, i) != '')
                                                  SizedBox(
                                                    width: 100.w,
                                                    height: 105.h,
                                                    child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      imageUrl:
                                                          getimage(snapshot, i),
                                                      progressIndicatorBuilder:
                                                          (context, url,
                                                                  downloadProgress) =>
                                                              Center(
                                                        child: CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Icon(
                                                              Icons.error),
                                                    ),

                                                    //     CachedNetworkImage(
                                                    //   imageUrl: text
                                                    //       .data!,
                                                    //   imageBuilder:
                                                    //       (context,imageProvider) =>
                                                    //           Container(
                                                    //     decoration:
                                                    //         BoxDecoration(
                                                    //       image: DecorationImage(
                                                    //           image:
                                                    //               imageProvider,
                                                    //           fit: BoxFit
                                                    //               .cover,
                                                    //           colorFilter: ColorFilter.mode(
                                                    //               Colors.red,
                                                    //               BlendMode.colorBurn)),
                                                    //     ),
                                                    //   ),
                                                    //   placeholder: (context,
                                                    //           url) =>
                                                    //       CircularProgressIndicator(),
                                                    //   errorWidget: (context,
                                                    //           url,
                                                    //           error) =>
                                                    //       Icon(Icons
                                                    //           .error),
                                                    // ),

                                                    //  Image
                                                    //     .network(
                                                    //   text.data
                                                    //       .toString(),
                                                    //   fit: BoxFit
                                                    //       .fill,
                                                    //   loadingBuilder: (BuildContext
                                                    //           context,
                                                    //       Widget
                                                    //           child,
                                                    //       loadingProgress) {
                                                    //     if (loadingProgress ==
                                                    //         null)
                                                    //       return child;
                                                    //     return Center(
                                                    //       child: CircularProgressIndicator(

                                                    //           ),
                                                    //     );
                                                    //   },
                                                    // ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                }
                                if (snapshot.hasError) {
                                  //error
                                  return noDataContainer();
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  //loding
                                  return Container(
                                      height: 620.h,
                                      width: 375.w,
                                      alignment: Alignment.center,
                                      child: const Center(
                                          child: CircularProgressIndicator()));
                                }
                                return Container(
                                    height: 620.h,
                                    width: 375.w,
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('data',
                                            style: TextStyle(
                                              color: AppColors.white,
                                            )),
                                        const Center(
                                            child: CircularProgressIndicator())
                                      ],
                                    ));
                              },
                            ),
                          ),
                        ],
                      ),
                      //اظهار زائر الانتقال الى صفحات الايجار والبيع
                      Positioned(
                        left: 20,
                        bottom: 20,
                        child: GestureDetector(
                          onTap: () {
                            final fristTimeprivacy = Provider.of<MainProvider>(
                                    context,
                                    listen: false)
                                .fristTimeprivacy;
                            if (fristTimeprivacy == true) {
                              privacyDialog(context: context);
                            } else {
                              Provider.of<MainProvider>(context, listen: false)
                                  .changesellansRentOrderShowBTN(true);
                            }
                          },

                          //  Navigator.of(context).push(
                          //   MaterialPageRoute<void>(
                          //       builder: (BuildContext context) => RentOrder()),
                          // ),
                          // sellOrderReadyDialog(context: context),
                          //showdilogButton(true),
                          // showDialogFUN(
                          //                               context: context,
                          //                               title: 'تم الحجز لمده 24 ساعه',
                          //                               orderNumber: '122'),
                          // Navigator.of(context).push(
                          //                             MaterialPageRoute<void>(
                          //                                 builder: (BuildContext context) =>
                          //tapFoatingActionButton(true),
                          child: Container(
                            width: 50.h,
                            height: 50.h,
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
                              borderRadius: BorderRadius.circular(25.sp),
                            ),
                            child: Icon(
                              Icons.add_rounded,
                              size: 40.sp,
                              color: AppColors.white,
                            ),
                          ),
                        ),

                        // FloatingActionButton(

                        //   backgroundColor: AppColors.bluePurple,
                        //   onPressed: () {},
                        // ),
                      ),
                    ],
                  ),
                ),
                if (sellansRentOrderShowBTN == true)
                  //زراير الانتقال الى صفحات طلبات البيع والايجار
                  GestureDetector(
                    onTap: () =>
                        Provider.of<MainProvider>(context, listen: false)
                            .changesellansRentOrderShowBTN(false),
                    child: Container(
                      width: 375.w,
                      height: 812.h,
                      color: AppColors.black.withOpacity(0.90),
                      alignment: Alignment.center,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //الانتقال الى صفحه طلبات الايجار
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RentOrder())),
                                  child: buildOrderContainer(
                                      'assets/images/rentOrder.png'),
                                ),
                                SizedBox(width: 20.w),
                                //الانتقال الى صفحه طلبات البيع
                                GestureDetector(
                                  onTap: () =>
                                      sellOrderReadyDialog(context: context),
                                  child: buildOrderContainer(
                                      'assets/images/SellOrder.png'),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            //زرار التراجع
                            GestureDetector(
                              onTap: () => Provider.of<MainProvider>(context,
                                      listen: false)
                                  .changesellansRentOrderShowBTN(false),
                              child: Container(
                                width: 320.w,
                                height: 40.h,
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(top: 3.sp),
                                decoration: BoxDecoration(
                                  color: AppColors.pink,
                                  borderRadius: BorderRadius.circular(10.sp),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.25),
                                      blurRadius: 10.sp,
                                    ),
                                  ],
                                ),
                                child: buildText(
                                  'تراجــــع',
                                  22.sp,
                                  AppColors.white,
                                  FontWeight.w400,
                                  TextAlign.center,
                                ),
                              ),
                            )
                          ]),
                    ),
                  ),
                if (isloding) lodingContainer(),
              ],
            ),
          ),
        ));
  }

  Future<String> downloadURLFun(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int i) async {
    try {
      final ListResult downloadURL = await FirebaseStorage.instance
          .ref('${snapshot.data!.docs[i].get('requestNumber')}')
          .listAll();
      var res = '';
      await downloadURL.items.first
          .getDownloadURL()
          .then((value) => res = value);
      // .whenComplete((value) => value.items.first.getDownloadURL())
      // .toString();

      return res;
    } catch (error) {
      return '';
    }
  }

  Center noDataContainer() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          imageContainer(
              105, 105, 'assets/images/noDataError.png', BoxFit.fill),
          SizedBox(height: 10.h),
          buildText(
              'نأسف', 37.sp, AppColors.white, FontWeight.w700, TextAlign.right),
          buildText('لا توجد بينات', 20.sp, AppColors.white, FontWeight.w500,
              TextAlign.left),
          SizedBox(height: 50.h),
          GestureDetector(
            onTap: () {
              Provider.of<MainProvider>(context, listen: false)
                  .changeSearchResult(FirebaseFirestore.instance
                      .collection('sellRequest')
                      .where('orderStatus',
                          whereIn: ['مقبول', 'محجوز']).snapshots());
              setState(() {});
            },
            child: Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(56.w / 2),
              ),
              child: Icon(
                Icons.refresh_rounded,
                color: AppColors.black,
                size: 40.sp,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> getFirebaseImageFolder(BuildContext ctx, String fileID) async {
    Provider.of<MainProvider>(ctx, listen: false).clearImageList();
    final storageRef = FirebaseStorage.instance.ref().child(fileID);
    await storageRef.listAll().then((result) {
      for (final Reference element in result.items) {
        String? res;
        element.getDownloadURL().then((value) {
          res = value;
          if (res != null) {
            Provider.of<MainProvider>(ctx, listen: false).addToImageList(res);
          }
        });
      }
    });
  }

  Future<void> addImageList(BuildContext ctx, String fileID) async {
    // {snapshot.data!.docs[i].get('requestNumber')}
    final ListResult downloadURL =
        await FirebaseStorage.instance.ref(fileID).listAll();
    final List<String> imagelist = [];
    if (downloadURL.items.isNotEmpty) {
      for (final Reference element in downloadURL.items) {
        final String path = element.fullPath;
        final String res =
            await FirebaseStorage.instance.ref(path).getDownloadURL();
        imagelist.add(res);
      }
      if (imagelist.isNotEmpty) {
        Provider.of<MainProvider>(ctx, listen: false)
            .changeimageList(imagelist);
      }
    } else {
      Provider.of<MainProvider>(ctx, listen: false).changeimageList([]);
    }

    //providor
    //.first.getDownloadURL().then((value) => res = value);
  }

  String getimage(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int i) {
    final List<dynamic> res =
        List.from(snapshot.data!.docs[i].get('imageList'));

    return res[0];
  }

  void changeimageList(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int i) {
    final List<String> res = List.from(snapshot.data!.docs[i].get('imageList'));
    Provider.of<MainProvider>(context, listen: false).changeimageList(res);
  }

  Container buildOrderContainer(String imagePath) {
    return Container(
      width: 150.w,
      height: 200.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: imagePath == 'assets/images/rentOrder.png'
            ? const Color(0xff52A0F8)
            : const Color(0xff6E52FC),
        // gradient: new LinearGradient(
        //     colors: [Color(0xff52A0F8), Color(0xff6E52FC)],
        //     stops: [0.0, 1.0],
        //     begin: FractionalOffset.centerLeft,
        //     end: FractionalOffset.centerRight,
        //     tileMode: TileMode.repeated),
        borderRadius: BorderRadius.circular(7.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.25),
            blurRadius: 10.sp,
            offset: Offset(0, 4.sp),
          ),
        ],
      ),
      child: imageContainer(82, 162, imagePath, BoxFit.fill),
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
}
// unfocusKeyboard() {
//     final FocusScopeNode currentScope = FocusScope.of(context);
//     if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
//       FocusManager.instance.primaryFocus?.unfocus();
//     }
//   }
