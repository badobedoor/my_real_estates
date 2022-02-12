import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_real_estates/wight/appWight&Theme/app_widgets.dart';
import 'package:my_real_estates/wight/appWight&Theme/theme.dart';
import 'package:provider/provider.dart';

import '../../Provider/main_provider.dart';
import '../dilog/showDialog.dart';

class AddimageContainer extends StatefulWidget {
  const AddimageContainer({
    Key? key,
    required this.imageFileList,
  }) : super(key: key);

  final List<XFile>? imageFileList;

  @override
  State<AddimageContainer> createState() => _AddimageContainerState();
}

class _AddimageContainerState extends State<AddimageContainer> {
  final ImagePicker imagePicker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(bottom: 10.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Text(
                //   '* ',
                //   style: TextStyle(
                //       color: AppColors.red, fontSize: 22.sp),
                // ),
                buildText(
                  'اضافه الصور',
                  20.sp,
                  AppColors.blue100,
                  FontWeight.w700,
                  TextAlign.end,
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                if (widget.imageFileList!.isNotEmpty)
                  Expanded(
                    child: SizedBox(
                      height: 109.h,
                      child: ListView.builder(
                        reverse: true,
                        itemCount: widget.imageFileList!.length == 6
                            ? widget.imageFileList!.length
                            : widget.imageFileList!.length + 1,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          if (widget.imageFileList!.length < 6 &&
                              index >
                                  widget.imageFileList!
                                      .indexOf(widget.imageFileList!.last)) {
                            return GestureDetector(
                              onTap: () => selectImages(context),
                              child: SizedBox(
                                height: 140,
                                child: Container(
                                  width: 140.w,
                                  height: 109.h,
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: AppColors.blue100,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Icons.add_a_photo,
                                    size: 40.sp,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              width: 140.w,
                              height: 109.h,
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: AppColors.blue100,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.black.withOpacity(0.25),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: SizedBox(
                                      width: 140.w,
                                      height: 109.h,
                                      child: Image.file(
                                          File(widget
                                              .imageFileList![index].path),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          // delete
                                          onTap: () {
                                            setState(() {
                                              widget.imageFileList!
                                                  .removeAt(index);
                                            });
                                          },
                                          child: Container(
                                            height: 20.h,
                                            width: 70.w,
                                            decoration: BoxDecoration(
                                              color: AppColors.pink
                                                  .withOpacity(.70),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(10)),
                                            ),
                                            child: Icon(
                                              Icons.delete_forever_outlined,
                                              color: AppColors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          // edit,
                                          onTap: () {
                                            getImageFromGallery(index);
                                          },
                                          child: Container(
                                            height: 20.h,
                                            width: 70.w,
                                            decoration: BoxDecoration(
                                              color: AppColors.blue100
                                                  .withOpacity(.70),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      bottomRight:
                                                          Radius.circular(10)),
                                            ),
                                            child: Icon(
                                              Icons.edit,
                                              color: AppColors.white,
                                              size: 20,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  )
                else
                  GestureDetector(
                    onTap: () {
                      selectImages(context);
                      // Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 315.w,
                      alignment: Alignment.center,
                      // color: AppColors.blue100,
                      child: imageContainer(
                          145, 130, 'assets/images/addphoto.png', BoxFit.fill),
                    ),
                  ),
                SizedBox(height: 20.h)
              ],
            ),
          ],
        ));
  }

  Future<void> selectImages(BuildContext ctx) async {
    FocusScope.of(context).unfocus();
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage(
      maxHeight: 480,
      maxWidth: 640,
    );
    if (selectedImages!.isNotEmpty) {
      if (selectedImages.length > 6 ||
          widget.imageFileList!.length + selectedImages.length > 6) {
        showEroorDialogFUN(
            context: ctx,
            title: 'خطأ',
            eroorText: 'لا يمكن اختيار اكثر من 6 صور ');
      } else {
        widget.imageFileList!.addAll(selectedImages);

        Provider.of<MainProvider>(ctx, listen: false)
            .changeimageFileList(widget.imageFileList);
      }
    }
    // print('Image List Length:' + widget.imageFileList!.length.toString());

    setState(() {});
  }

  Future<void> getImageFromGallery(int index) async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        // _image = File(image.path);
        widget.imageFileList![index] = image;
        //add image to the list
      } else {}
    });
  }
}

// Container addimageContainer(BuildContext context,{List<XFile>? imageFileList}) {
//     return Container(
//                           padding: EdgeInsets.only(bottom: 10.h),
//                           child: Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   // Text(
//                                   //   '* ',
//                                   //   style: TextStyle(
//                                   //       color: AppColors.red, fontSize: 22.sp),
//                                   // ),
//                                   buildText(
//                                     'اضافه الصور',
//                                     20.sp,
//                                     AppColors.blue100,
//                                     FontWeight.w700,
//                                     TextAlign.end,
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 20.h,
//                               ),
//                               Row(
//                                 children: [
//                                   // Row(children: []),
//                                   imageFileList!.length != 0
//                                       ?
//                                       // imageContainer(
//                                       //     140,
//                                       //     109,
//                                       //     'assets/images/addphoto.png',
//                                       //     BoxFit.fill),
//                                       // if (imageFileList!.length < 6)
//                                       //                                         GestureDetector(
//                                       //                                           onTap: () => selectImages(context),
//                                       //                                           child: Icon(
//                                       //                                             Icons.add_a_photo,
//                                       //                                             size: 40.sp,
//                                       //                                           ),
//                                       //                                         ),
//                                       Expanded(
//                                           child: Container(
//                                             height: 109.h,
//                                             child: ListView.builder(
//                                               reverse: true,
//                                               itemCount: imageFileList!
//                                                           .length ==
//                                                       6
//                                                   ? imageFileList!.length
//                                                   : imageFileList!.length + 1,
//                                               scrollDirection:
//                                                   Axis.horizontal,
//                                               itemBuilder:
//                                                   (BuildContext context,
//                                                       int index) {
//                                                 if (imageFileList!.length <
//                                                         6 &&
//                                                     index >
//                                                         imageFileList!
//                                                             .indexOf(
//                                                                 imageFileList!
//                                                                     .last)) {
//                                                   return GestureDetector(
//                                                     onTap: () =>
//                                                         selectImages(context),
//                                                     child: Container(
//                                                       height: 140,
//                                                       child: Container(
//                                                         width: 140.w,
//                                                         height: 109.h,
//                                                         margin:
//                                                             EdgeInsets.all(5),
//                                                         decoration:
//                                                             BoxDecoration(
//                                                           color: AppColors
//                                                               .blue100,
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(
//                                                                       10.0),
//                                                         ),
//                                                         child: Icon(
//                                                           Icons.add_a_photo,
//                                                           size: 40.sp,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   );
//                                                 } else {
//                                                   return Container(
//                                                     width: 140.w,
//                                                     height: 109.h,
//                                                     margin: EdgeInsets.all(5),
//                                                     decoration: BoxDecoration(
//                                                       color:
//                                                           AppColors.blue100,
//                                                       borderRadius:
//                                                           BorderRadius
//                                                               .circular(10.0),
//                                                       boxShadow: [
//                                                         BoxShadow(
//                                                           color: AppColors
//                                                               .black
//                                                               .withOpacity(
//                                                                   0.25),
//                                                           spreadRadius: 0,
//                                                           blurRadius: 6,
//                                                           offset:
//                                                               Offset(0, 0),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                     child: Stack(
//                                                       children: [
//                                                         ClipRRect(
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(
//                                                                       10),
//                                                           child: Container(
//                                                             width: 140.w,
//                                                             height: 109.h,
//                                                             child: Image.file(
//                                                               File(imageFileList![
//                                                                       index]
//                                                                   .path),
//                                                               fit:
//                                                                   BoxFit.fill,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Positioned(
//                                                           bottom: 0,
//                                                           child: Row(
//                                                             children: [
//                                                               GestureDetector(
// // delete
//                                                                 onTap: () {
//                                                                   setState(
//                                                                       () {
//                                                                     imageFileList!
//                                                                         .removeAt(
//                                                                             index);
//                                                                   });
//                                                                 },
//                                                                 child:
//                                                                     Container(
//                                                                   height:
//                                                                       20.h,
//                                                                   width: 70.w,
//                                                                   decoration:
//                                                                       BoxDecoration(
//                                                                     color: AppColors
//                                                                         .pink
//                                                                         .withOpacity(
//                                                                             .70),
//                                                                     borderRadius:
//                                                                         BorderRadius.only(
//                                                                             bottomLeft: Radius.circular(10)),
//                                                                   ),
//                                                                   child: Icon(
//                                                                     Icons
//                                                                         .delete_forever_outlined,
//                                                                     color: AppColors
//                                                                         .white,
//                                                                     size: 20,
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               GestureDetector(
// // edit,
//                                                                 onTap: () {
//                                                                   getImageFromGallery(
//                                                                       index);
//                                                                 },

//                                                                 child:
//                                                                     Container(
//                                                                   height:
//                                                                       20.h,
//                                                                   width: 70.w,
//                                                                   decoration:
//                                                                       BoxDecoration(
//                                                                     color: AppColors
//                                                                         .blue100
//                                                                         .withOpacity(
//                                                                             .70),
//                                                                     borderRadius:
//                                                                         BorderRadius.only(
//                                                                             bottomRight: Radius.circular(10)),
//                                                                   ),
//                                                                   child: Icon(
//                                                                     Icons
//                                                                         .edit,
//                                                                     color: AppColors
//                                                                         .white,
//                                                                     size: 20,
//                                                                   ),
//                                                                 ),
//                                                               )
//                                                             ],
//                                                           ),
//                                                         )
//                                                       ],
//                                                     ),
//                                                   );
//                                                 }
//                                               },
//                                             ),
//                                           ),
//                                         )
//                                       : GestureDetector(
//                                           onTap: () {
//                                             selectImages(context);
//                                             // Navigator.of(context).pop();
//                                           },
//                                           child: imageContainer(
//                                               145,
//                                               130,
//                                               'assets/images/addphoto.png',
//                                               BoxFit.fill),
//                                         ),

//                                   SizedBox(height: 20.h)
//                                 ],
//                               ),
//                             ],
//                           ));
//                             void selectImages(BuildContext ctx) async {
//     final List<XFile>? selectedImages = await imagePicker.pickMultiImage();

//   }
