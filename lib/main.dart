import 'package:flutter/material.dart';
import 'package:pro_connect_projet/pages/homePage.dart';
import 'package:pro_connect_projet/pages/landingPage.dart';
import 'package:pro_connect_projet/pages/profilChoicePage.dart';
import 'package:pro_connect_projet/pages/signUpPage.dart';
import 'package:pro_connect_projet/pages/succesLogIn.dart';
import 'package:pro_connect_projet/pages/succesSignUp.dart';


import 'pages/logInPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //initialRoute: '/',
      routes: {
        '/': (context) => LandingPage(),
        '/signUp': (context) => SignUpPage(),
        '/logIn': (context) => LogInPage(),
        '/profilChoice': (context) => ProfilChoicePage(),
        '/homePage': (context) => HomePage(),
        '/succesLogIn':(context) => SuccesLogIn(),
        '/succesSignUp':(context) => SuccesSignUp(),
      },
    );
  }
}