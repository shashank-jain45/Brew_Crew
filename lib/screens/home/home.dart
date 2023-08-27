import 'package:brew_crew/bloc/bloc/database_bloc.dart';
import 'package:brew_crew/bloc/bloc/signing_in_bloc.dart';
import 'package:brew_crew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/brew_tile.dart';
import '../settings_form.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.userId});
  final String? userId;

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(userId: userId),
            );
          });
    }

    return BlocProvider(
      create: (context) => DatabaseBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Home"), actions: [
          TextButton.icon(
            label: const Text(
              "Logout",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              context.read<SigningInBloc>().add(SignOut());
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
          TextButton.icon(
              onPressed: () {
                DataBaseService(uid: userId).userData;
                _showSettingsPanel();
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
              label: const Text(
                "Update",
                style: TextStyle(color: Colors.white),
              ))
        ]),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/coffee_bg.png"),
                  fit: BoxFit.cover)),
          child: BlocBuilder<DatabaseBloc, DatabaseState>(
            builder: (context, state) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return (state is DataFetched)
                      ? BrewTile(brew: state.brews![index])
                      : const Text('An Error Occured');
                },
                itemCount: state is DataFetched ? state.brews!.length : 0,
              );
            },
          ),
        ),
      ),
    );
  }
}
