import 'package:flutter/material.dart';
import 'package:graduation/features/auth/presentation/widgets/hello_signin.dart';
import 'package:graduation/features/auth/presentation/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Stack(
      children:
      [
        HelloSignin(),
        LoginViewBody(),
      ],
    ));
  }
}
