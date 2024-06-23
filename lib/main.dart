import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:graduation/core/api/dio_consumer.dart';
import 'package:graduation/core/cache/cache_helper.dart';
import 'package:graduation/core/commons/bloc_oserver.dart';
import 'package:graduation/core/commons/constants.dart';
import 'package:graduation/core/commons/global_cubits/change_language_cubit/change_language_cubit.dart';
import 'package:graduation/core/commons/global_cubits/change_theme_cubit/change_theme_cubit.dart';
import 'package:graduation/core/commons/global_cubits/get_user_info_cubit/get_user_info_cubit.dart';
import 'package:graduation/core/commons/global_cubits/global_community_cubit/global_community_cubit.dart';
import 'package:graduation/features/community/data/repos/community_repo_implementation.dart';
import 'package:graduation/features/profile/data/repos/profile_repo_implementation.dart';
import 'package:graduation/skin_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper().init();
  Gemini.init(
    apiKey: AppConstants.GEMINI_API_KEY,
  );
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => GlobalCommunityCubit(
          communityRepoImplementation:
              CommunityRepoImplementation(apiConsumer: DioConsumer(dio: Dio())))
        ..getAllPosts(),
    ),
    BlocProvider(
      create: (context) => ChangeLanguageCubit(),
    ),
    BlocProvider(
      create: (context) => ChangeThemeCubit(),
    ),
    BlocProvider(
      create: (context) => GetUserInfoCubit(
          profileRepoImplementation:
              ProfileRepoImplementation(apiConsumer: DioConsumer(dio: Dio()))),
    ),
  ], child: const SkinVisionApp()));
  Bloc.observer = MyBlocObserver();
}
