import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_real_estates/wight/appWight&Theme/theme.dart';

import 'appWight&Theme/app_widgets.dart';
import 'smallWight/drop_list_model.dart';

class SelectDropList extends StatefulWidget {
  final OptionItem itemSelected;
  final DropListModel dropListModel;
  final Function(OptionItem optionItem) onOptionSelected;
  final String lableText;
  const SelectDropList(this.itemSelected, this.dropListModel,
      this.onOptionSelected, this.lableText,
      {Key? key})
      : super(key: key);

  @override
  _SelectDropListState createState() =>
      _SelectDropListState(itemSelected, dropListModel, lableText);
}

class _SelectDropListState extends State<SelectDropList>
    with SingleTickerProviderStateMixin {
  OptionItem optionItemSelected;
  DropListModel dropListModel;
  String lableText;
  late AnimationController expandController;
  late Animation<double> animation;

  bool isShow = false;

  _SelectDropListState(
      this.optionItemSelected, this.dropListModel, this.lableText);

  @override
  void initState() {
    super.initState();

    expandController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    _runExpandCheck();
  }

  void _runExpandCheck() {
    if (isShow) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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

        GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            isShow = !isShow;
            _runExpandCheck();
            setState(() {});
          },
          child: Container(
            width: 315.w,
            height: 40.h,
            padding: EdgeInsets.only(right: 10.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: AppColors.blue100),
              boxShadow: [
                BoxShadow(
                  blurRadius: 3,
                  color: AppColors.blue100.withOpacity(0.25),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Icon(
                //   Icons.card_travel,
                //   color: Color(0xFF307DF1),
                // ),

                // SizedBox(
                //   width: 10,
                // ),
                Align(
                  alignment: const Alignment(1, 0),
                  child: Icon(
                    isShow
                        ? Icons.expand_more_rounded
                        : Icons.chevron_left_rounded,
                    color: AppColors.blue100,
                    size: 25.sp,
                  ),
                ),
                Text(
                  optionItemSelected.title!,
                  style: TextStyle(
                      // color: Color(0xFF307DF1), fontSize: 16
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Tajawal',
                      color: AppColors.blue100,
                      height: 1.3),
                ),
              ],
            ),
          ),
        ),

        SizeTransition(
            axisAlignment: 1,
            sizeFactor: animation,
            child: Container(
                margin: EdgeInsets.only(bottom: 20.sp),
                child: _buildDropListOptions(
                    dropListModel.listOptionItems, context))),
//          Divider(color: Colors.grey.shade300, height: 1,)
        SizedBox(height: 20.h)
      ],
    );
  }

  Column _buildDropListOptions(List<OptionItem> items, BuildContext context) {
    return Column(
      children: items.map((item) => _buildSubMenu(item, context)).toList(),
    );
  }

  Widget _buildSubMenu(OptionItem item, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.5.sp, horizontal: 5.sp),
      child: GestureDetector(
        child: buildCardContainer(
          340,
          40,
          4,
          Padding(
            padding: EdgeInsets.only(left: 16.sp, right: 15.sp, top: 5.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Icon(
                      item.title! == optionItemSelected.title
                          ? Icons.check_circle
                          : Icons.circle_outlined,
                      size: 26.sp,
                      color: item.title! == optionItemSelected.title
                          ? AppColors.green
                          : AppColors.blue100,
                    )),
                buildText(
                  item.title!,
                  20.sp,
                  AppColors.blue100,
                  FontWeight.w500,
                  TextAlign.right,
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          optionItemSelected = item;
          isShow = false;
          expandController.reverse();
          widget.onOptionSelected(item);
        },
      ),
    );
    //**** */
  }
}

// Padding(
//       padding: const EdgeInsets.only(left: 26.0, top: 5, bottom: 5),
//       child: GestureDetector(
//         child: Row(
//           children: <Widget>[
//             Expanded(
//               flex: 1,
//               child: Container(
//                 padding: const EdgeInsets.only(top: 20),
//                 decoration: BoxDecoration(
//                   border:
//                       Border(top: BorderSide(color: AppColors.grey4, width: 1)),
//                 ),
//                 child: Text(item.title!,
//                     style: TextStyle(
//                         color: AppColors.bluePurple,
//                         fontWeight: FontWeight.w400,
//                         fontSize: 14),
//                     maxLines: 3,
//                     textAlign: TextAlign.start,
//                     overflow: TextOverflow.ellipsis),
//               ),
//             ),
//           ],
//         ),
//         onTap: () {
//           this.optionItemSelected = item;
//           isShow = false;
//           expandController.reverse();
//           widget.onOptionSelected(item);
//         },
//       ),
//     );
