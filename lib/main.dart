import 'package:flutter/material.dart';
import 'package:scanconvertapp/screens/splash_screen/splash_screen.dart';

import 'constants/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = TextStyle(
      color: Colors.white, // Set your desired text color here
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        textTheme: TextTheme(
          bodyLarge: defaultTextStyle,
          bodyMedium: defaultTextStyle,
          titleLarge: TextStyle(
            color: Colors.white,
          ),
          displayLarge: defaultTextStyle,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
            .copyWith(background: Color(appBackgroundColor)),
      ),
      home: SplashScreen(),
    );
  }
}
