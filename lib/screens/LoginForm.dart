import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant_management/screens/Home.dart';
import 'SignUpForm.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late String _password;
  late String _email;

  String errorMessage = '';

    @override
  void initState() {
    super.initState();
    _email = "";
    _password = "";
  }

  Future<void> _login() async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text(
            "Login sucessfully",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          behavior: SnackBarBehavior.floating,
        ));

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home(userCredential.user)),
        );
      }
    } on FirebaseAuthException catch (e) {
      print("wwww$e.message");
      setState(() {
        errorMessage = e.message!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(
                  "assets/icons/food.png",
                  height: size.height * 0.25,
                ),
                const SizedBox(height: 35),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  cursorColor: const Color(0xFF6F35A5),
                  decoration: InputDecoration(
                      hintText: " Email",
                      prefixIcon: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(Icons.person),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    cursorColor: const Color(0xFF6F35A5),
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(Icons.lock),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required';
                      }
                      return null;
                    },
                    onChanged: (value) => {
                      setState(() {
                        _password =value;
                      })
                    },
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  width: size.width * 0.6,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF6F35A5))),
                    child: const Text('Login'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have an account? ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3.0),
                child: GestureDetector(
                  onTap: () {
                    final navigator = Navigator.of(context);
                    navigator.pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => const SignUpForm()),
                    );
                  },
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Color(0xFF6F35A5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
