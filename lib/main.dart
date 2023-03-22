import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:restaurant_management/screens/FeedbackForm.dart';
import './screens/Login.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Firebase.initializeApp();
  runApp(const MaterialApp(home: MyWidget()));
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: FeedbackForm());
  }
}
