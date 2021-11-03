import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import './screens/main_screen.dart';
import './screens/signin_screen.dart';
import './screens/login_screen.dart';
// import './screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final DatabaseReference usersRef =
    FirebaseDatabase.instance.reference().child("users");

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
      home: LoginScreen(),
      routes: {
        SigninScreen.routeName: (context) => SigninScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        MainScreen.routeName: (context) => const MainScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
