import 'package:brew_crew/bloc/bloc/signing_in_bloc.dart';
import 'package:brew_crew/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.toggleView});
  final Function toggleView;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TextFormFieldDecoration emailDecoration =
      TextFormFieldDecoration(lableName: 'Email');
  TextFormFieldDecoration passwordDecoration =
      TextFormFieldDecoration(lableName: 'Password');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registration"), actions: [
        ElevatedButton.icon(
          label: const Text("Sign In"),
          onPressed: () {
            widget.toggleView();
          },
          icon: const Icon(
            Icons.login,
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
                      value!.isEmpty ? "Enter an Email" : null,
                  controller: email,
                  onChanged: (value) {},
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: passwordDecoration.textInputDecoration,
                  validator: (value) => value!.length < 6
                      ? "Entered password must be longer than 6 characters"
                      : null,
                  controller: password,
                  obscureText: true,
                  onChanged: (value) {},
                ),
                ElevatedButton(
                  child: const Text(
                    "Register",
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      context
                          .read<SigningInBloc>()
                          .add(Register(email.text, password.text));
                    }
                  },
                ),
                BlocBuilder<SigningInBloc, SigningInState>(
                  builder: (context, state) {
                    if (state is ErrorRegisteringIn) {
                      return const Text(
                        "Invalid Credentials",
                        style: TextStyle(color: Colors.red, fontSize: 25),
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
