import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';
import 'package:movie_mate/core/routes/app_routes.dart';
import 'package:movie_mate/core/utils/fonts/style_manager.dart';

import '../../../../core/common/widgets/movie_poster.dart';
import '../../data/models/popular_movies_model.dart';

class MovieCard extends StatefulWidget {
  final MoviesResult movie;

  const MovieCard({super.key, required this.movie});

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  String? posterImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          AppRoutes.movieDetails,
          arguments: {'movie': widget.movie, 'posterImage': posterImage},
        );
      },
      child: Container(
        height: 150.h,
        decoration: BoxDecoration(
          color: context.color.cardColor,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4.r,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            MoviePoster(
              height: 140.h,
              width: 100.w,
              onImageGenerated: (image) {
                posterImage = image;
              },
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.movie.title,
                      style: StyleManager.white16Bold(context),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        SizedBox(width: 4.w),
                        Text(
                          '${widget.movie.voteAverage.toStringAsFixed(1)}/10',
                          style: StyleManager.white14regular(context),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        'Drama',
                        style: StyleManager.white13regular(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: Icon(
                Ionicons.chevron_forward_outline,
                color: context.color.textColor,
                size: 22.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
