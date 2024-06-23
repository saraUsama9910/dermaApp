import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/commons/functions.dart';
import 'package:graduation/core/routes/routes.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/widgets/resuable_text.dart';
import 'package:graduation/features/auth/cubits/login_cubit/login_cubit.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginCubitState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          showToast(
              msg: 'Login Successfully', toastStates: ToastStates.success);
          navigate(context: context, route: Routes.kHomeView);
        }
        if (state is LoginFailureState) {
          showToast(msg: state.errorMessage, toastStates: ToastStates.error);
        }
      },
      builder: (context, state) {
        final loginCubit = BlocProvider.of<LoginCubit>(context);
        return Form(
          key: loginCubit.loginFormKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 180),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18),
                child: ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your email to continue';
                            }
                            return null;
                          },
                          onFieldSubmitted: (value) {
                            if (loginCubit.loginFormKey.currentState!
                                .validate()) {
                              loginCubit.login(
                                  email: loginCubit.emailController.text,
                                  password: loginCubit.passwordController.text);
                            }
                          },
                          controller: loginCubit.emailController,
                          decoration: const InputDecoration(
                              suffixIcon: Icon(
                                Icons.check,
                                color: AppColors.kGreyColor,
                              ),
                              label: Text(
                                'Gmail',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.kBlueColor,
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        TextFormField(
                          obscureText: loginCubit.passwordObsecureText,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your password to continue';
                            }
                            return null;
                          },
                          onFieldSubmitted: (value) {
                            if (loginCubit.loginFormKey.currentState!
                                .validate()) {
                              loginCubit.login(
                                  email: loginCubit.emailController.text,
                                  password: loginCubit.passwordController.text);
                            }
                          },
                          controller: loginCubit.passwordController,
                          decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  loginCubit.changePasswordEye();
                                },
                                child: Icon(
                                  loginCubit.passwordSuffiXIcon,
                                  color: AppColors.kGreyColor,
                                ),
                              ),
                              label: const Text(
                                'Password',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.kBlueColor,
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              navigate(
                                  context: context,
                                  route: Routes.forgotPassScreen);
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17.sp,
                                color: AppColors.kBlueColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 70.h,
                        ),
                        state is LoginLoadingState
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ))
                            : GestureDetector(
                                onTap: () {
                                  if (loginCubit.loginFormKey.currentState!
                                      .validate()) {
                                    loginCubit.login(
                                        email: loginCubit.emailController.text,
                                        password:
                                            loginCubit.passwordController.text);
                                    loginCubit.passwordController.clear();
                                    loginCubit.emailController.clear();
                                  }
                                },
                                child: Container(
                                  height: 55.h,
                                  width: 300.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    gradient: const LinearGradient(colors: [
                                      AppColors.primaryColor,
                                      AppColors.kkPrimaryColor
                                    ]),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'SIGN IN',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.sp,
                                          color: AppColors.white),
                                    ),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 50.h,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                               ResuableText(
                                text: 'Don\'t have an account?',
                                color: AppColors.kGreyColor,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.kSignupView);
                                },
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(

                                      ///done login page
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.sp,
                                      color: AppColors.kBlueColor),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
