import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/core/api/dio_consumer.dart';
import 'package:graduation/core/routes/routes.dart';
import 'package:graduation/features/auth/cubits/forgot_pass_cubit/forgot_pass_cubit.dart';
import 'package:graduation/features/auth/cubits/login_cubit/login_cubit.dart';
import 'package:graduation/features/auth/cubits/signup_cubit/signup_cubit.dart';
import 'package:graduation/features/auth/data/repos/auth_repo_implementation.dart';
import 'package:graduation/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:graduation/features/auth/presentation/screens/login_view.dart';
import 'package:graduation/features/auth/presentation/screens/signup_view.dart';
import 'package:graduation/features/chat/peresntation/views/chatbot_start.dart';
import 'package:graduation/features/chat/peresntation/views/chatbot_view.dart';
import 'package:graduation/features/community/cubits/search_for_posts_cubit/search_for_posts_cubit.dart';
import 'package:graduation/features/community/data/repos/community_repo_implementation.dart';
import 'package:graduation/features/community/presentation/views/add_comment_screen.dart';
import 'package:graduation/features/community/presentation/views/add_post_screen.dart';
import 'package:graduation/features/community/presentation/views/all_posts_screen.dart';
import 'package:graduation/features/community/presentation/views/edit_post_screen.dart';
import 'package:graduation/features/community/presentation/views/post_details_screen.dart';
import 'package:graduation/features/community/presentation/views/search_screen.dart';
import 'package:graduation/features/diagnosis/peresntation/views/upload_image_view.dart';
import 'package:graduation/features/home/peresntation/views/homeview.dart';
import 'package:graduation/features/onboarding/cubits/doctor_or_user_cubit/doctor_or_user_cubit.dart';
import 'package:graduation/features/onboarding/peresntation/views/doctor_or_user_screen.dart';
import 'package:graduation/features/onboarding/peresntation/views/onbording_view.dart';
import 'package:graduation/features/profile/cubit/delete_user_cubit/delete_user_cubit.dart';
import 'package:graduation/features/profile/cubit/faq_screen_cubit/faq_screen_cubit.dart';
import 'package:graduation/features/profile/cubit/update_password_cubit/update_password__cubit.dart';
import 'package:graduation/features/profile/cubit/update_profile_cubit/update_profile_cubit.dart';
import 'package:graduation/features/profile/data/repos/profile_repo_implementation.dart';
import 'package:graduation/features/profile/presentation/screens/change_password_screen.dart';
import 'package:graduation/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:graduation/features/profile/presentation/screens/faq_screen.dart';
import 'package:graduation/features/profile/presentation/screens/language_screen.dart';
import 'package:graduation/features/profile/presentation/screens/main_profile_screen.dart';
import 'package:graduation/features/profile/presentation/screens/screen_modes.dart';
import 'package:graduation/features/profile/presentation/screens/settings_screen.dart';
import 'package:graduation/features/splash/peresntation/views/splash_view.dart';
import 'package:graduation/features/welcome/peresntation/views/welcome_view.dart';

import '../../features/community/cubits/add_post_cubit/add_post_cubit.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashView:
        return MaterialPageRoute(
          builder: (context) => const SplashView(),
        );
      case Routes.screenModes:
        return MaterialPageRoute(
          builder: (context) => const ScreenModes(),
        );
      case Routes.settingsScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => DeleteUserCubit(
                profileRepoImplementation: ProfileRepoImplementation(
                    apiConsumer: DioConsumer(dio: Dio()))),
            child: const SettingsScreen(),
          ),
        );
      case Routes.changePasswordScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => UpdatePasswordCubit(
                profileRepoImplementation: ProfileRepoImplementation(
                    apiConsumer: DioConsumer(dio: Dio()))),
            child: const ChangePasswordScreen(),
          ),
        );
      case Routes.faqScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => FaqScreenCubit(),
            child: const FaqScreen(),
          ),
        );
      case Routes.languageScreen:
        return MaterialPageRoute(
          builder: (context) => const LanguageScreen(),
        );
      case Routes.editProfileScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => UpdateProfileCubit(
                profileRepoImplementation: ProfileRepoImplementation(
                    apiConsumer: DioConsumer(dio: Dio()))),
            child: const EditProfileScreen(),
          ),
        );
      case Routes.mainProfileScreen:
        return MaterialPageRoute(
          builder: (context) => const MainProfileScreen(),
        );
      case Routes.forgotPassScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
              create: (context) => ForgotPassCubit(
                  authRepoImplementation:
                      AuthRepoImplementation(api: DioConsumer(dio: Dio()))),
              child: const ForgotPasswordScreen()),
        );
      case Routes.doctorOrUserScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
              create: (context) => DoctorOrUserCubit(),
              child: const DoctorOrUserScreen()),
        );
      case Routes.editPostScreen:
        return MaterialPageRoute(
            builder: (context) => const EditPostScreen(),
            settings: routeSettings);
      case Routes.addCommentScreen:
        return MaterialPageRoute(
            builder: (context) => const AddCommentScreen(),
            settings: routeSettings);
      case Routes.postDetailsScreen:
        return MaterialPageRoute(
            builder: (context) => const PostDetailsScreen(),
            settings: routeSettings);
      case Routes.searchScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => SearchForPostsCubit(
                communityRepoImplementation: CommunityRepoImplementation(
                    apiConsumer: DioConsumer(dio: Dio()))),
            child: const SearchScreen(),
          ),
        );
      case Routes.addPostScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AddPostCubit(
                communityRepoImplementation: CommunityRepoImplementation(
                    apiConsumer: DioConsumer(dio: Dio()))),
            child: const AddPostScreen(),
          ),
        );
      case Routes.allPostsScreen:
        return MaterialPageRoute(
            builder: (context) => AllPostsScreen(), settings: routeSettings);
      case Routes.kWelcomeView:
        return MaterialPageRoute(
          builder: (context) => const WelcomeView(),
        );
      case Routes.kLoginView:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
              create: (context) => LoginCubit(
                  authRepoImplementation:
                      AuthRepoImplementation(api: DioConsumer(dio: Dio()))),
              child: const LoginView()),
        );
      case Routes.kHomeView:
        return MaterialPageRoute(
          builder: (context) => const HomeView(),
        );
      case Routes.kSignupView:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
              create: (context) => SignupCubit(
                  authRepoImplementation:
                      AuthRepoImplementation(api: DioConsumer(dio: Dio()))),
              child: const SignupView()),
        );
      case Routes.kOnboardingView:
        return MaterialPageRoute(
          builder: (context) => const OnbordingView(),
        );
      case Routes.kChatbotStartView:
        return MaterialPageRoute(
          builder: (context) => const chatbotStartView(),
        );
      case Routes.kChatbotView:
        return MaterialPageRoute(
          builder: (context) => const ChatBotView(),
        );
      case Routes.kUploadImageView:
        return MaterialPageRoute(
          builder: (context) => const UploadImageView(),
        );
    }
    return null;
  }
}
