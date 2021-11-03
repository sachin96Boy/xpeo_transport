import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uber_clone/screens/signin_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
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
                      onPressed: () => {print("button clicked")},
                      child: Container(
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
                child: Text("Sign Up insted"),
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
}
