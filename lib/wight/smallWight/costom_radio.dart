import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../Provider/main_provider.dart';
import '../appWight&Theme/theme.dart';

class MyRadioListTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String leading;
  final Widget? title;
  final ValueChanged<T?> onChanged;

  MyRadioListTile({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.leading,
    this.title,
  }) : super(key: key) {
    // TODO: implement
    //throw UnimplementedError();
  }

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    return InkWell(
      onTap: () {
        onChanged(value);
        if (value == 0) {
          Provider.of<MainProvider>(context, listen: false).changeSearchResult(
              FirebaseFirestore.instance.collection('sellRequest').where(
                  'orderStatus',
                  whereIn: ['مقبول', 'محجوز']).snapshots());
        } else if (value == 1) {
          Provider.of<MainProvider>(context, listen: false).changeSearchResult(
              FirebaseFirestore.instance
                  .collection('sellRequest')
                  .where('orderStatus', whereIn: ['مقبول', 'محجوز'])
                  .orderBy('unitPrice', descending: false)
                  .snapshots());
        } else if (value == 2) {
          Provider.of<MainProvider>(context, listen: false).changeSearchResult(
              FirebaseFirestore.instance
                  .collection('sellRequest')
                  .where('orderStatus', whereIn: ['مقبول', 'محجوز'])
                  .orderBy('unitPrice', descending: true)
                  .snapshots());
        }
      },
      child: Container(
        height: 30.h,
        padding: EdgeInsets.only(left: 30.sp),
        child: Row(
          children: [
            _customRadioButton,
            // SizedBox(width: 110.w),
            if (title != null) title,
          ],
        ),
      ),
    );
  }

  Widget get _customRadioButton {
    final isSelected = value == groupValue;
    return Icon(
      isSelected ? Icons.check_circle : Icons.circle_outlined,
      size: isSelected ? 26.sp : 26.sp,
      color: isSelected ? AppColors.green : AppColors.blue100,
    );
  }
}
