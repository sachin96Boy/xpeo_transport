import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import './models/address.dart';
import './provider/userprovider.dart';

import './screens/search_screen.dart';
import './screens/main_screen.dart';
import './screens/signin_screen.dart';
import './screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DotEnv().load(fileName: '.env');
  runApp(const MyApp());
}

final DatabaseReference usersRef =
    FirebaseDatabase.instance.ref().child("users");

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(
        Address(
            placeFormattedAddress: "",
            placeName: "",
            placeId: "",
            latitude: 0.0,
            longitude: 0.0),
      ),
      child: MaterialApp(
        title: 'Expo-Transport',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MainScreen(),
        routes: {
          SigninScreen.routeName: (context) => SigninScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          MainScreen.routeName: (context) => const MainScreen(),
          SearchScreen.routeName: (context) => const SearchScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
