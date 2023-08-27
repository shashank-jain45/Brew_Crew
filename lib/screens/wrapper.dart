import 'package:brew_crew/bloc/bloc/signing_in_bloc.dart';
import 'package:brew_crew/screens/authen/auth.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:brew_crew/screens/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SigningInBloc, SigningInState>(
      builder: (context, state) {
        if (state is SignedIn) {
          return HomeScreen(
            userId: state.userId,
          );
        } else if (state is Loading) {
          return const LoadingScreen();
        } else {
          return const AuthenticationScreen();
        }
      },
    );
  }
}
