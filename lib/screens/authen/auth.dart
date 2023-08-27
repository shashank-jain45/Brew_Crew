import 'package:brew_crew/bloc/bloc/signing_in_bloc.dart';
import 'package:brew_crew/screens/authen/register.dart';
import 'package:brew_crew/screens/authen/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    BlocListener<SigningInBloc, SigningInState>(
      listener: (context, state) {
        if (state is ErrorRegisteringIn) {
          showSignIn = false;
        }
      },
    );
    if (showSignIn == true) {
      return SignInScreen(toggleView: toggleView);
    } else {
      return RegisterScreen(toggleView: toggleView);
    }
  }
}
