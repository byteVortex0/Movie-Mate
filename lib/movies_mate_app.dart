import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/app/theme_cubit/theme_cubit.dart';
import 'core/routes/app_routes.dart';
import 'core/utils/theme/theme_manager.dart';

class MoviesMateApp extends StatelessWidget {
  const MoviesMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 914),
      minTextAdapt: true,
      splitScreenMode: true,
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Movies Mate App',
            debugShowCheckedModeBanner: false,
            darkTheme: ThemeManager.darkTheme,
            theme: ThemeManager.lightTheme,
            themeMode: context.read<ThemeCubit>().isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            initialRoute: AppRoutes.home,
            onGenerateRoute: AppRoutes.onGenerateRoute,
          );
        },
      ),
    );
  }
}
