import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uber_clone/widgets/progress_bar.dart';

import '../main.dart';
import './login_screen.dart';
import './main_screen.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({Key? key}) : super(key: key);
  static const routeName = "/signin";

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
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
                "Register as a Rider",
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
                      controller: _nameController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "Name",
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
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "email",
                        labelStyle: TextStyle(fontSize: 14.0),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: const TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(height: 1.0),
                    const SizedBox(height: 1.0),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: "Phone Number",
                        labelStyle: TextStyle(fontSize: 14.0),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: const TextStyle(fontSize: 14.0),
                    ),
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
                        if (_nameController.text.length < 3) {
                          displayToastMessage(
                              "name must be atleast 5 characters long",
                              context);
                        } else if (!_emailController.text.contains("@")) {
                          displayToastMessage(
                              "email address not valid", context);
                        } else if (_phoneController.text.isEmpty) {
                          displayToastMessage(
                              "phone number can't be empty", context);
                        } else if (_passwordController.text.length < 6) {
                          displayToastMessage(
                              "password length should be greater than 7",
                              context);
                        }
                        registerNewUser(context);
                      },
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "Register Rider",
                            style: GoogleFonts.roboto(
                                textStyle: const TextStyle(fontSize: 18.0),
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue[400],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0)),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                child: const Text("Sign in insted"),
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                    LoginScreen.routeName, (route) => false),
                style: TextButton.styleFrom(primary: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void registerNewUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const ProgressDialog(message: "Registering, Please Wait...");
        });
    final firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    )
            .catchError((error) {
      Navigator.of(context).pop();
      displayToastMessage("Error:" + error.toString(), context);
    }))
        .user;
    if (firebaseUser != null) {
      Map _userData = {
        "name": _nameController.text.trim(),
        "email": _emailController.text.trim(),
        "phone": _phoneController.text.trim(),
      };
      usersRef.child(firebaseUser.uid).set(_userData);
      displayToastMessage("Account created", context);

      Navigator.of(context)
          .pushNamedAndRemoveUntil(MainScreen.routeName, (route) => false);
    } else {
      Navigator.of(context).pop();
      displayToastMessage("New User Account has not been created ", context);
    }
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
