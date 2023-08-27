import 'package:brew_crew/bloc/bloc/database_bloc.dart';
import 'package:brew_crew/bloc/bloc/signing_in_bloc.dart';
import 'package:brew_crew/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SigningInBloc(),
        ),
        BlocProvider(
          create: (context) => DatabaseBloc(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
            appBarTheme: const AppBarTheme(color: Colors.brown),
            colorScheme: const ColorScheme(
                brightness: Brightness.light,
                primary: Colors.brown,
                onPrimary: Colors.white,
                secondary: Colors.white,
                onSecondary: Colors.white,
                error: Colors.brown,
                onError: Colors.brown,
                background: Colors.white70,
                onBackground: Colors.white70,
                surface: Colors.white,
                onSurface: Colors.white)),
        home: const Wrapper(),
      ),
    );
  }
}
