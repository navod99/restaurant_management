// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_management/model/cartHandler.dart';
import 'package:restaurant_management/splash.dart';
import './screens/Login.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
      create: (context) => CartHandler(),
      child: MaterialApp(initialRoute: '/splash', routes: {
        '/splash': (context) => SplashScreen(),
        '/main': (context) => MyWidget(),
      }
          //home: MyWidget()),
          )));
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Login());
  }
}
