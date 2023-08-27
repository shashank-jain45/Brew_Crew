import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/widgets/constants.dart';
import 'package:flutter/material.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key, this.userId});
  final String? userId;
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // form values
  String? _currentName;
  String? _currentSugars;
  double? _currentStrength;
  TextFormFieldDecoration nameDecoratiom =
      TextFormFieldDecoration(lableName: 'Name');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DataBaseService(uid: widget.userId).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const Text(
                  'Update your brew settings.',
                  style: TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  initialValue: snapshot.data!.name,
                  decoration: nameDecoratiom.textInputDecoration,
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(
                    () => _currentName = val,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                DropdownButtonFormField(
                  //  decoration: textInputDecoration,
                  value: _currentSugars ?? snapshot.data!.sugar,
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugars'),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() => _currentSugars = val);
                  },
                ),
                Slider(
                  min: 100,
                  max: 900,
                  divisions: 8,
                  value: _currentStrength ?? snapshot.data!.strength.toDouble(),
                  onChanged: (value) => setState(
                    () {
                      _currentStrength = value;
                    },
                  ),
                ),
                const SizedBox(height: 10.0),
                ElevatedButton(
                    child: const Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      await DataBaseService(uid: widget.userId).updateUserData(
                          _currentSugars ?? snapshot.data!.sugar,
                          _currentStrength?.toInt() ?? snapshot.data!.strength,
                          _currentName ?? snapshot.data!.name);
                      Navigator.of(context).pop();
                    }),
              ],
            ),
          );
        } else {
          return const Text("Loading");
        }
      },
    );
  }
}
