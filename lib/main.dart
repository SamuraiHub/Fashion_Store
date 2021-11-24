import 'dart:io';
import 'dart:ui';

import 'package:fashion_store/screens/login_screen.dart';
import 'package:fashion_store/screens/product_screen.dart';
import 'package:fashion_store/screens/registration_screen.dart';
import 'package:fashion_store/screens/welocome_screen.dart';
import 'package:fashion_store/widgetDescription.dart';
import 'package:fashion_store/widgetPageViewHeader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FashionStore(),
    );
  }
}

class FashionStore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (BuildContext context) => WelcomeScreen(),
        LoginScreen.id: (BuildContext context) => LoginScreen(),
        RegistrationScreen.id: (BuildContext contex) => RegistrationScreen(),
        ProductScreen.id: (BuildContext contex) => ProductScreen(),
      },
    );
  }
}
