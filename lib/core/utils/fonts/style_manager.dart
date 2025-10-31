import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';

import 'font_weight_helper.dart';

class StyleManager {
  static TextStyle white18Bold(BuildContext context) => TextStyle(
    fontSize: 18.sp,
    color: context.color.toolbarTextColor,
    fontWeight: FontWeightHelper.bold,
  );

  static TextStyle white16Bold(BuildContext context) => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.bold,
    color: context.color.textColor,
  );

  static TextStyle white14regular(BuildContext context) => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
    color: context.color.textColor,
  );

  static TextStyle white13regular(BuildContext context) => TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeightHelper.regular,
    color: context.color.textColor,
  );

  static TextStyle white20Bold(BuildContext context) => TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: context.color.textColor,
  );
}
