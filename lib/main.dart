import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './constants/colors.dart';
import './providers/controller.dart';
import './screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Controller(),
        ),
      ],
      child: MaterialApp(
        title: 'Wordle',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColorLight: lightThemeLightShade,
            primaryColorDark: lightThemeDartShade,
            appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.white,
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            scaffoldBackgroundColor: Colors.white,
            textTheme: const TextTheme().copyWith(
                bodyText2: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black))),
        home: const HomePage(),
      ),
    );
  }
}
