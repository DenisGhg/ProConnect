import 'package:flutter/material.dart';
import 'package:pro_connect_projet/pages/auth_pages/log_in_page.dart';
import 'package:pro_connect_projet/pages/auth_pages/sign_up_page.dart';
import 'package:pro_connect_projet/pages/home_page.dart';
import 'package:pro_connect_projet/pages/landing_page.dart';
import 'package:pro_connect_projet/pages/profil_choice_page.dart';
import 'package:pro_connect_projet/pages/reset_password_pages/email_verification.dart';
import 'package:pro_connect_projet/pages/reset_password_pages/new_password.dart';
import 'package:pro_connect_projet/pages/reset_password_pages/verify_code.dart';
import 'package:pro_connect_projet/pages/success_log_in.dart';
import 'package:pro_connect_projet/pages/success_sign_up.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RecupMailProvider()),
      ],

      child: const MyApp(),
    ),
  );
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
      routes: <String, WidgetBuilder>{
        '/': (context) => LandingPage(),
        '/signUp': (context) => SignUpPage(),
        '/logIn': (context) => LogInPage(),
        '/profilChoice': (context) => ProfilChoicePage(),
        '/homePage': (context) => HomePage(),
        '/succesLogIn': (context) => SuccessLogIn(),
        '/succesSignUp': (context) => SuccessSignUp(),
        '/verifMail': (context) => EmailVerification(),
        '/verifCode': (context) => VerifyCode(),
        '/newPassword': (context) => NewPassword(),
      },
    );
  }
}
