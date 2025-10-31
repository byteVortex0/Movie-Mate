import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';

import '../../../core/common/widgets/movie_poster.dart';
import '../../../core/utils/fonts/style_manager.dart';
import '../../home/data/models/popular_movies_model.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({
    super.key,
    required this.movie,
    required this.posterImage,
  });

  final MoviesResult movie;
  final String posterImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.bgColor,
      appBar: AppBar(
        backgroundColor: context.color.bgToolbarColor,
        title: Text('Movie Details', style: StyleManager.white18Bold(context)),
        leading: BackButton(color: context.color.toolbarTextColor),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MoviePoster(
              posterImage: posterImage,
              height: 280.h,
              width: double.infinity,
            ),

            SizedBox(height: 20.h),

            Text(movie.title, style: StyleManager.white20Bold(context)),

            SizedBox(height: 10.h),

            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 22),
                SizedBox(width: 6.w),
                Text(
                  '${movie.voteAverage.toStringAsFixed(1)} / 10',
                  style: StyleManager.white16Bold(context),
                ),
                SizedBox(width: 12.w),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(10.r),
                    color: context.color.bgColor,
                  ),
                  child: Text(
                    'Drama',
                    style: StyleManager.white14regular(context),
                  ),
                ),
              ],
            ),

            SizedBox(height: 25.h),

            Text('Description', style: StyleManager.white16Bold(context)),
            SizedBox(height: 8.h),
            Text(
              movie.overview,
              style: TextStyle(
                fontSize: 15.sp,
                color: context.color.textColor!.withValues(alpha: .7),
                height: 1.4,
              ),
            ),

            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
