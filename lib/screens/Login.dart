import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:restaurant_management/screens/LoginForm.dart';
import 'package:restaurant_management/screens/SignUpForm.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome To Lemon Restaurant",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            const SizedBox(height: 25),
            Image.asset(
              "assets/icons/cooking.png",
              height: size.height * 0.35,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 40),
              width: size.width * 0.8,
              child: Column(
                children: [
                  Container(
                    width: size.width * 0.8,
                    child: FloatingActionButton(
                      heroTag: "SignIn",
                      backgroundColor: Color(0xFF6F35A5),
                      onPressed: () {
                        final navigator = Navigator.of(context);
                        navigator.pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const SignIn()),
                        );
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    width: size.width * 0.8,
                    child: FloatingActionButton(
                      heroTag: "SignUp",
                      backgroundColor: Color(0xFF6F35A5),
                      onPressed: () async {
                        final navigator = Navigator.of(context);
                        navigator.push(
                          MaterialPageRoute(
                              builder: (context) => const SignUpForm()),
                        );
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: const Text(
                        "Sign up",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
