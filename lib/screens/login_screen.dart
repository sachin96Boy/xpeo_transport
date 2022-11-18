import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/progress_bar.dart';

import '../main.dart';
import './main_screen.dart';
import './signin_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  static const routeName = "/login";

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 45.0,
              ),
              Image.network(
                "https://i.ibb.co/0qJyPKx/Red-Grey-Automotive-Car-Silhouette-Logo.png",
                width: 400.0,
                height: 300.0,
                alignment: Alignment.center,
              ),
              const SizedBox(height: 1.0),
              Text(
                "Rider Login",
                style: GoogleFonts.roboto(
                    textStyle: Theme.of(context).textTheme.headline5,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(
                  20.0,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 1.0),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(fontSize: 14.0),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: const TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(height: 1.0),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(fontSize: 14.0),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: const TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(height: 10.0),
                    ElevatedButton(
                      onPressed: () {
                        if (!_emailController.text.contains("@")) {
                          displayToastMessage(
                              "email address not valid", context);
                        } else if (_passwordController.text.isEmpty) {
                          displayToastMessage("password required", context);
                        } else {
                          loginAndAuthenticateUser(context);
                        }
                      },
                      child: SizedBox(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "Log In",
                            style: GoogleFonts.roboto(
                                textStyle: const TextStyle(fontSize: 18.0),
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.yellow,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0)),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                child: const Text("Sign Up insted"),
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                    SigninScreen.routeName, (route) => false),
                style: TextButton.styleFrom(primary: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void loginAndAuthenticateUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const ProgressDialog(
              message: "Authenticating, Please Wait...");
        });
    final firebaseUser = (await _firebaseAuth
            .signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    )
            .catchError((error) {
      Navigator.of(context).pop();
      displayToastMessage("Error:" + error.toString(), context);
    }))
        .user;
    if (firebaseUser != null) {
      usersRef.child(firebaseUser.uid).once().then((event) {
        final dataSnapshot = event.snapshot;
        if (dataSnapshot.value != null) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(MainScreen.routeName, (route) => false);
          displayToastMessage("User loged In", context);
        } else {
          Navigator.of(context).pop();
          _firebaseAuth.signOut();
          displayToastMessage("Usr recordes Does  not exist", context);
        }
      });
    } else {
      Navigator.of(context).pop();
      displayToastMessage("Error occured, Can't log In", context);
    }
  }
}
