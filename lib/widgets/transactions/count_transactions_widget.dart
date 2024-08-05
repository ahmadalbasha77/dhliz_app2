import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CountTransactionWidget extends StatelessWidget {
  final String title;
  final String type;
  final Color color;
  final Color iconColor;
  final IconData icon;
  final int count;

  const CountTransactionWidget(
      {super.key,
      required this.title,
      required this.type,
      required this.count,
      required this.color,
      required this.iconColor,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title.tr, style: const TextStyle(color: Colors.black54)),
        SizedBox(
          height: 7.h,
        ),
        Text(count.toString(), style: TextStyle(fontSize: 20.sp)),
        SizedBox(
          height: 7.h,
        ),
        Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(7)),
          child: Row(children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7.w),
              child: Text(type.tr, style: TextStyle(color: iconColor)),
            ),

            Icon(
              icon ,
              color: iconColor,
              size: 12.w,
            )
          ]),
        ),
      ],
    );
  }
}
