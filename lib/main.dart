import 'package:deceasefinder/splashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color accentColor = Color(0xFF0A4A0E);
  static const Color myBlueColor = Color(0xFF1A0062);

  static const MaterialColor primaryColor = MaterialColor(
    0xFF4B834E,
    <int, Color>{
      50: Color(0xFFC7DCC8),
      400: Color(0xD8497F4C),
      500: Color(0xFF4B834E),
      600: Color(0xFF377A3A),
    },
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DermAssist',
      theme: ThemeData(
        primaryColor: const Color(0xFF4B834E),
        primaryColorDark: const Color(0xFF0A4A0E),
      ),
      home: const SplashScreen(title: 'Skin Disease Detection'),
    );
  }
}