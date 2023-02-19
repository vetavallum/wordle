import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/quick_box.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});
  final routeName = '/settings';

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.maybePop(context);
              },
              icon: const Icon(Icons.clear))
        ],
      ),
      body: Column(children: [
        // SwitchListTile(
        //     value: _isSwitched,
        //     onChanged: (value) {
        //       setState(() {
        //         _isSwitched = value;
        //       });
        //     }),
        Container(
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.remove('stats'); //prefs.clear will remove everything
                prefs.remove('chart');
                prefs.remove('row');
                runQuickBox(context: context, message: 'Statistics Reset');
              },
              child: const Text('Reset Statistics')),
        ),
        // ListTile(
        //     title: const Text('Reset Statistics'),
        //     onTap: () async {
        //       final prefs = await SharedPreferences.getInstance();
        //       prefs.remove('stats'); //prefs.clear will remove everything
        //       prefs.remove('chart');
        //       prefs.remove('row');
        //       runQuickBox(context: context, message: 'Statistics Reset');
        //     })
      ]),
    );
  }
}
