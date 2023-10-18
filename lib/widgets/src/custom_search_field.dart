import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomSearchFeild extends StatelessWidget {
  TextEditingController? controller;
  TextInputType? keyboardType;
  int? maxLines;
  int? maxLength;
  TextAlign textAlign;
  String? hint;
  bool enabled;
  TextDirection? textDirection;
  Widget? suffix;
  String? Function(String? value)? validator;
  void Function(String?)? onChanged;
  String? Function(String?)? onSaved;
  String? Function(String?)? onFieldSubmitted;
  void Function()? onTap;
  EdgeInsetsGeometry? margin;
  EdgeInsetsGeometry? padding;

  CustomSearchFeild({
    this.controller,
    this.keyboardType,
    this.maxLines,
    this.maxLength,
    this.textAlign = TextAlign.start,
    this.hint,
    this.enabled = true,
    this.textDirection,
    this.suffix,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.onFieldSubmitted,
    this.onTap,
    this.margin = const EdgeInsets.symmetric(vertical: 8),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        maxLength: maxLength,
        textAlign: textAlign,
        decoration: InputDecoration(
          filled: false,
          hintText: hint ?? 'Search'.tr,
          contentPadding:  EdgeInsets.all(4.sp),
          prefixIcon: const Icon(Icons.search),
          suffix: suffix,
          counterStyle: const TextStyle(fontSize: 0, color: Colors.transparent),
          focusedBorder: OutlineInputBorder(
            borderSide:  BorderSide(color: Colors.grey.shade400),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade400,
            ),
          ),
        ),
        enabled: enabled,
        textDirection: textDirection,
        validator: validator,
        onChanged: onChanged,
        onSaved: onSaved,
        onFieldSubmitted: onFieldSubmitted,
        onTap: onTap,
      ),
    );
  }
}
