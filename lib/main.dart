import 'package:flutter/material.dart';
import 'package:uber_clone/screens/main_screen.dart';

import './screens/signin_screen.dart';
import './screens/login_screen.dart';
// import './screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expo-Transport',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
      routes: {
        SigninScreen.routeName: (context) => const SigninScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        MainScreen.routeName: (context) => const MainScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
