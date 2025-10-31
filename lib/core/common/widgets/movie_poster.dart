import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoviePoster extends StatefulWidget {
  final String? posterImage;
  final double width;
  final double height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final ValueChanged<String>? onImageGenerated;

  const MoviePoster({
    super.key,
    this.posterImage,
    required this.width,
    required this.height,
    this.fit = BoxFit.fill,
    this.borderRadius,
    this.onImageGenerated,
  });

  static const String baseUrl = 'https://image.tmdb.org/t/p/w500/';
  static const List<String> fallbackImages = [
    'xR0IhVBjbNU34b8erhJCgRbjXo3.jpg',
    'yvirUYrva23IudARHn3mMGVxWqM.jpg',
    'fWVSwgjpT2D78VUh6X8UBd2rorW.jpg',
    'souvvkJHYhztC1UqZ8lEVUiJa3J.jpg',
    '2Yc8Kl2ldPpDzLrG2M5Ddv62FXB.jpg',
    'chpWmskl3aKm1aTZqUHRCtviwPy.jpg',
    'cdqLnri3NEGcmfnqwk2TSIYtddg.jpg',
    'yd3RMKUmeNQusDsQ3G8LyreAr0O.jpg',
    '4shf5Alq4KWCKqrAAQe0JGJHYp5.jpg',
    '8RjbBaeMaMpdBZIzd6FWYxW7xHv.jpg',
    'ysRCiRiqcwHJO0Tyk4kaEfCkSx4.jpg',
    '3K93GWotLXe4FqpErri0xkpLaD5.jpg',
    'xXxuJPNUDZ0vjsAXca0O5p3leVB.jpg',
    'dkBQC0jmkmTOJJMgwsBdgkzZ6Ry.jpg',
  ];

  @override
  State<MoviePoster> createState() => _MoviePosterState();
}

class _MoviePosterState extends State<MoviePoster> {
  late String imageUrl;

  @override
  void initState() {
    super.initState();
    imageUrl = getImageUrl();
    if (widget.onImageGenerated != null) {
      widget.onImageGenerated!(imageUrl);
    }
  }

  String getImageUrl() {
    final random = Random();
    if (widget.posterImage != null && widget.posterImage!.isNotEmpty) {
      return '${widget.posterImage}';
    }
    final randomImage = MoviePoster
        .fallbackImages[random.nextInt(MoviePoster.fallbackImages.length)];
    return '${MoviePoster.baseUrl}$randomImage';
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.borderRadius ?? BorderRadius.circular(16.r),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        placeholder: (context, url) => Container(
          width: widget.width,
          height: widget.height,
          color: Colors.grey.shade300,
          child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        ),
        errorWidget: (context, url, error) => Container(
          width: widget.width,
          height: widget.height,
          color: Colors.grey.shade200,
          child: const Icon(
            Icons.image_not_supported,
            size: 50,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
