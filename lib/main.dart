import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'core/app/env_variables.dart';
import 'core/app/theme_cubit/theme_cubit.dart';
import 'core/di/injection.dart';
import 'core/service/hive/hive_database.dart';
import 'core/service/shared_pref/shared_pref.dart';
import 'movies_mate_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EnvVariables.init();

  await ScreenUtil.ensureScreenSize();

  await SharedPref.init();

  await HiveDatabase.instance.setup();

  setupInjection();

  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://fdfe1b92de71ca70fdd4d4a865ee03a0@o4510279937753088.ingest.us.sentry.io/4510279939457024';
      options.sendDefaultPii = true;
    },
    appRunner: () => runApp(
      SentryWidget(
        child: BlocProvider(
          create: (BuildContext context) => sl<ThemeCubit>(),
          child: const MoviesMateApp(),
        ),
      ),
    ),
  );
}
