import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service/shared_pref/pref_keys.dart';
import '../../service/shared_pref/shared_pref.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial()) {
    loadTheme();
  }

  Future<void> loadTheme() async {
    final savedTheme = await SharedPref.getValue(PrefKeys.isDark) as bool?;

    final isDark = savedTheme ?? false;

    if (savedTheme == null) {
      await SharedPref.setValue(PrefKeys.isDark, isDark);
    }

    emit(ChangeThemeMode(isDark: isDark));
  }

  Future<void> changeThemeMode({bool? sharedMode}) async {
    final newMode = sharedMode ?? !isDark;
    await SharedPref.setValue(PrefKeys.isDark, newMode);
    emit(ChangeThemeMode(isDark: newMode));
  }

  bool get isDark =>
      state is ChangeThemeMode && (state as ChangeThemeMode).isDark;
}
