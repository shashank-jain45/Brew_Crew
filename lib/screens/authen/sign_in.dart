import 'package:brew_crew/bloc/bloc/signing_in_bloc.dart';
import 'package:brew_crew/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key, required this.toggleView});
  final Function toggleView;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  TextFormFieldDecoration emailDecoration =
      TextFormFieldDecoration(lableName: 'Email');
  TextFormFieldDecoration passwordDecoration =
      TextFormFieldDecoration(lableName: 'Password');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign In"), actions: [
        ElevatedButton.icon(
          label: const Text("Register"),
          style: const ButtonStyle(),
          onPressed: () {
            widget.toggleView();
          },
          icon: const Icon(
            Icons.app_registration_rounded,
          ),
        )
      ]),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: emailDecoration.textInputDecoration,
                  validator: (value) =>
                      value!.isEmpty ? "Invalid  Email" : null,
                  controller: email,
                  onChanged: (value) {},
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: TextStyle(color: Colors.brown),
                  decoration: passwordDecoration.textInputDecoration,
                  validator: (value) => value!.length < 6
                      ? "Entered Password is incorrect"
                      : null,
                  controller: password,
                  obscureText: true,
                  onChanged: (value) {},
                ),
                ElevatedButton(
                  child: const Text("Sign In"),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // UserModel? result =
                      //     await _auth.signInWithEmailAndPassword(
                      //         email.text, password.text);
                      // if (result == null) {
                      //   setState(() {
                      //     error = "Invalid Credentials";
                      //   });
                      // }
                      context.read<SigningInBloc>().add(
                            SignIn(email.text, password.text),
                          );
                    }
                  },
                ),
                BlocBuilder<SigningInBloc, SigningInState>(
                  builder: (context, state) {
                    if (state is ErrorSigningIn) {
                      return const Text(
                        "Invalid Credentials",
                        style: TextStyle(color: Colors.brown, fontSize: 25),
                      );
                    } else {
                      return const Text('');
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
