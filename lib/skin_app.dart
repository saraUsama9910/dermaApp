import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/api/api_keys.dart';
import 'package:graduation/core/cache/cache_helper.dart';
import 'package:graduation/core/commons/global_cubits/change_language_cubit/change_language_cubit.dart';
import 'package:graduation/core/commons/global_cubits/change_theme_cubit/change_theme_cubit.dart';
import 'package:graduation/core/localization/app_localization.dart';
import 'package:graduation/core/routes/app_router.dart';
import 'package:graduation/core/routes/routes.dart';

class SkinVisionApp extends StatelessWidget {
  const SkinVisionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocBuilder<ChangeThemeCubit, ChangeThemeState>(
  builder: (context, state) {
    return BlocBuilder<ChangeLanguageCubit, ChangeLanguageState>(
          builder: (context, state) {
            return MaterialApp(
              onGenerateRoute: AppRouter.onGenerateRoute,
              initialRoute: CacheHelper().getData(key: ApiKeys.token)==null?Routes.splashView:Routes.kHomeView,
              locale: Locale(BlocProvider
                  .of<ChangeLanguageCubit>(context)
                  .desiredLanguage),
              theme: BlocProvider.of<ChangeThemeCubit>(context).isDarkMode==true?ThemeData.dark():ThemeData.light(),
              localizationsDelegates: const [
                AppLocalizationDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],
              supportedLocales: AppLocalization.supportedLocales,
              localeResolutionCallback: (deviceLocale, supportedLocales) {
                for (var locale in supportedLocales) {
                  if (deviceLocale != null &&
                      deviceLocale.languageCode == locale.languageCode) {
                    return deviceLocale;
                  }
                }
                return supportedLocales.first;
              },
              debugShowCheckedModeBanner: false,
            );
          },
        );
  },
);
      },
    );
  }
}