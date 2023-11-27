import 'package:computer_app/bottom_nav.dart';
import 'package:computer_app/login/intropage.dart';
import 'package:computer_app/login/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PC Shop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: IntroPage(),
      routes: {
        '/intropage': (context) => const IntroPage(),
        '/login': (context) => const LoginPage(),
        '/bottom_nav': (context) => const BottomNavigation(),
      },
    );
  }
}
