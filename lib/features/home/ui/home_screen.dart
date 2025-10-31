import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_mate/core/app/theme_cubit/theme_cubit.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';
import 'package:movie_mate/core/utils/fonts/style_manager.dart';
import 'package:movie_mate/features/home/logic/cubit/get_popular_movies_cubit.dart';

import 'widgets/error_massage.dart';
import 'widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 50) {
        context.read<GetPopularMoviesCubit>().loadMoreMovies();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.bgColor,
      appBar: AppBar(
        backgroundColor: context.color.bgToolbarColor,
        titleSpacing: 50,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.movie_creation_outlined,
              color: context.color.toolbarTextColor,
            ),
            SizedBox(width: 6.w),
            Text('Movies', style: StyleManager.white18Bold(context)),
          ],
        ),
        centerTitle: true,
        actions: [
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () async {
                  await context.read<ThemeCubit>().changeThemeMode();
                },
                icon: Icon(
                  Icons.dark_mode,
                  color: context.color.toolbarTextColor,
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: RefreshIndicator.adaptive(
          onRefresh: () async {
            await context.read<GetPopularMoviesCubit>().fetchPopularMovies(
              page: 1,
              forceRefresh: true,
            );
          },
          child: BlocBuilder<GetPopularMoviesCubit, GetPopularMoviesState>(
            builder: (context, state) {
              if (state is GetPopularMoviesLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is GetPopularMoviesError) {
                return ErrorMassage(
                  message: state.message,
                  onRetry: () {
                    context.read<GetPopularMoviesCubit>().fetchPopularMovies(
                      page: 1,
                    );
                  },
                );
              }

              if (state is GetPopularMoviesLoaded) {
                final movies = state.movies.results;

                return ListView.separated(
                  controller: _scrollController,
                  itemCount: state.isLoadingMore
                      ? movies.length + 1
                      : movies.length,
                  separatorBuilder: (_, __) => SizedBox(height: 10.h),
                  itemBuilder: (context, index) {
                    if (index == movies.length) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    return MovieCard(movie: movies[index]);
                  },
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
