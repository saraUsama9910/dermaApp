import 'package:flutter/material.dart';
import 'package:graduation/features/auth/presentation/widgets/hi_signup.dart';
import 'package:graduation/features/auth/presentation/widgets/signup_view_body.dart';

class SignupView extends StatelessWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Stack(
      children:
      [
        HiSignup(),
        SignupViewBody()
      ],
    ));
  }
}
