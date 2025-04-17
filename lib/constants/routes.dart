import 'package:flutter/material.dart';
import 'package:pro_connect_projet/views/pages/auth_pages/log_in_page.dart';
import 'package:pro_connect_projet/views/pages/auth_pages/sign_up_page.dart';
import 'package:pro_connect_projet/views/pages/logo_page.dart';
import 'package:pro_connect_projet/views/pages/presentation_page.dart';
import 'package:pro_connect_projet/views/pages/auth_pages/profil_choice_page.dart';
import 'package:pro_connect_projet/views/pages/register_pages/talent_pages/talent_profile_presentation.dart';
import 'package:pro_connect_projet/views/pages/register_pages/talent_pages/talent_profile_step2.dart';
import 'package:pro_connect_projet/views/pages/register_pages/talent_pages/talent_profile_step1.dart';
import 'package:pro_connect_projet/views/pages/reset_password_pages/reset_password_page.dart';
import 'package:pro_connect_projet/views/pages/reset_password_pages/verify_code_page.dart';
import 'package:pro_connect_projet/views/pages/reset_password_pages/verify_mail_page.dart';
import 'package:pro_connect_projet/views/pages/success_log_in.dart';
import 'package:pro_connect_projet/views/pages/success_sign_up.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/logoPage': (context) => const LogoPage(),
  '/signUpPage': (context) => const SignUpPage(),
  '/logInPage': (context) => const LogInPage(),
  '/profilChoicePage': (context) => const ProfilChoicePage(),
  '/presentationPage': (context) => const PresentationPage(),
  '/succesLogIn': (context) => const SuccessLogIn(),
  '/succesSignUp': (context) => const SuccessSignUp(),
  '/verifyMailPage': (context) => const VerifyMailPage(),
  '/verifyCodePage': (context) => const VerifyCodePage(),
  '/resetPasswordPage': (context) => const ResetPasswordPage(),
  '/talentProfilPresentation': (context) => const TalentProfilPresentation(),
  '/talentProfileStep1' :(context) => const TalentProfileStep1(),
  '/talentProfileStep2' :(context) => const TalentProfileStep2(),
};

class AppRoutes{
  static const String LOGOPAGE = '/logoPage';
  static const String SIGNUPPAGE = '/signUpPage';
  static const String LOGINPAGE = '/logInPage';
  static const String PROFILCHOICEPAGE = '/profilChoicePage';
  static const String PRESENTATIONPAGE = '/presentationPage';
  static const String SUCCESSLOGINPAGE = '/successLoginPage';
  static const String SUCESSSIGNUPPAGE = '/successSignUpPage';
  static const String VERIFYMAILPAGE = '/verifyMailPage';
  static const String VERIFYCODEPAGE = '/verifyCodePage';
  static const String RESETPASSWORDPAGE = '/resetPasswordPage';
  static const String TALENTPROFILPRESENTATION = '/talentProfilPresentation';
  static const String TALENTPROFILESTEP1 = '/talentProfileStep1';
  static const String TALENTPROFILESTEP2 = '/talentProfileStep2';
}