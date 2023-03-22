import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_management/repositories/registration_repository.dart';
import 'package:restaurant_management/screens/Login.dart';
import 'package:restaurant_management/screens/LoginForm.dart';
import '../model/user.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late String _password;
  late String _name;
  late String _email;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _name = "";
    _email = "";
    _password = "";
  }

  Future<void> _register() async {
    print("Hello, world! $_email $_name $_password");
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );

      RegisterUser user = RegisterUser(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: _name,
          email: _email);
      UserRepository userRepository = UserRepository();
      await userRepository.addUser(user);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text(
            "Registered sucessfully",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          behavior: SnackBarBehavior.floating,
        ));

        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      print("Hooo $e.message");
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text("weak-password"),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          behavior: SnackBarBehavior.floating,
        ));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text("Email already in use"),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          behavior: SnackBarBehavior.floating,
        ));
      }
      setState(() {
        _errorMessage = e.message!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sign Up"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Image.asset(
                  "assets/icons/user.png",
                  height: size.height * 0.15,
                ),
                const SizedBox(height: 35),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          cursorColor: const Color(0xFF6F35A5),
                          decoration: InputDecoration(
                              hintText: " Your Full Name",
                              prefixIcon: const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(Icons.person),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          onChanged: (value) {
                            setState(() {
                              _name = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: const Color(0xFF6F35A5),
                          decoration: InputDecoration(
                              hintText: "Your Email",
                              prefixIcon: const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(Icons.person),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          onChanged: (value) {
                            setState(() {
                              _email = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: TextFormField(
                          obscureText: true,
                          cursorColor: const Color(0xFF6F35A5),
                          decoration: InputDecoration(
                            hintText: "Your Password",
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
                              return 'Password is required';
                            }
                            if (value.length < 6) {
                              return 'Enter a password 6+ characterss long';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              _password = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: TextFormField(
                          controller: _confirmPasswordController,
                          textInputAction: TextInputAction.done,
                          obscureText: true,
                          cursorColor: const Color(0xFF6F35A5),
                          decoration: InputDecoration(
                            hintText: "Confirm Password",
                            prefixIcon: const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Icon(Icons.lock),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  width: size.width * 0.6,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: _register,
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF6F35A5))),
                    child: const Text('Sign Up'),
                  ),
                ),
              ],
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
                  "Already have an account? ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: GestureDetector(
                    onTap: () {
                      // final navigator = Navigator.of(context);
                      // navigator.pushReplacement(
                      //   MaterialPageRoute(builder: (context) => const SignIn()),
                      // );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const SignIn()),
                      );
                    },
                    child: const Text(
                      "Login",
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
        ));
  }
}
