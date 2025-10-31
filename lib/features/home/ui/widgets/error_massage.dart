import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';

import '../../../../core/utils/fonts/style_manager.dart';

class ErrorMassage extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorMassage({super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: StyleManager.white16Bold(context),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            ElevatedButton.icon(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                backgroundColor: context.color.bgToolbarColor,
              ),
              icon: Icon(Icons.refresh, color: context.color.toolbarTextColor),
              label: Text(
                'Retry',
                style: StyleManager.white14regular(
                  context,
                ).copyWith(color: context.color.toolbarTextColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
