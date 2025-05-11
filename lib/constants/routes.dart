import 'package:flutter/material.dart';
import 'package:pro_connect_projet/views/pages/auth_pages/log_in_page.dart';
import 'package:pro_connect_projet/views/pages/auth_pages/sign_up_page.dart';
import 'package:pro_connect_projet/views/pages/logo_page.dart';
import 'package:pro_connect_projet/views/pages/presentation_page.dart';
import 'package:pro_connect_projet/views/pages/auth_pages/profil_choice_page.dart';
import 'package:pro_connect_projet/views/pages/register_pages/talent_pages/talent_profile_step2_page.dart';
import 'package:pro_connect_projet/views/pages/register_pages/talent_pages/talent_profile_step3_page.dart';
import 'package:pro_connect_projet/views/pages/register_pages/talent_pages/talent_profile_step5_page.dart';
import 'package:pro_connect_projet/views/pages/register_pages/talent_pages/talent_profile_step6_page.dart';
import 'package:pro_connect_projet/views/pages/reset_password_pages/reset_password_page.dart';
import 'package:pro_connect_projet/views/pages/reset_password_pages/verify_code_page.dart';
import 'package:pro_connect_projet/views/pages/reset_password_pages/verify_mail_page.dart';
import 'package:pro_connect_projet/views/pages/success_log_in.dart';

import '../views/pages/register_pages/talent_pages/talent_profile_presentation_page.dart';
import '../views/pages/register_pages/talent_pages/talent_profile_step1_page.dart';
import '../views/pages/register_pages/talent_pages/talent_profile_step4_page.dart';
import '../views/pages/register_pages/talent_pages/talent_profile_step7_page.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/logoPage': (context) => const LogoPage(),
  '/signUpPage': (context) => const SignUpPage(),
  '/logInPage': (context) => const LogInPage(),
  '/profilChoicePage': (context) => const ProfilChoicePage(),
  '/presentationPage': (context) => const PresentationPage(),
  '/succesLogIn': (context) => const SuccessLogIn(),
  '/verifyMailPage': (context) => const VerifyMailPage(),
  '/verifyCodePage': (context) => const VerifyCodePage(),
  '/resetPasswordPage': (context) => const ResetPasswordPage(),
  '/talentProfilPresentation': (context) => const TalentProfilPresentation(),
  '/talentProfileStep1' :(context) => const TalentProfileStep1(),
  '/talentProfileStep2' :(context) => TalentProfileStep2Page(),
  '/talentProfileStep3' :(context) => TalentProfileStep3Page(),
  '/talentProfileStep4' :(context) => TalentProfileStep4Page(),
  '/talentProfileStep5' :(context) => TalentProfileStep5Page(),
  '/talentProfileStep6' :(context) => TalentProfileStep6Page(),
  '/talentProfileStep7' :(context) => TalentProfileStep7Page(),
};

class AppRoutes{
  static const String LOGOPAGE = '/logoPage';
  static const String SIGNUPPAGE = '/signUpPage';
  static const String LOGINPAGE = '/logInPage';
  static const String PROFILCHOICEPAGE = '/profilChoicePage';
  static const String PRESENTATIONPAGE = '/presentationPage';
  static const String SUCCESSLOGINPAGE = '/successLoginPage';
  static const String VERIFYMAILPAGE = '/verifyMailPage';
  static const String VERIFYCODEPAGE = '/verifyCodePage';
  static const String RESETPASSWORDPAGE = '/resetPasswordPage';
  static const String TALENTPROFILPRESENTATION = '/talentProfilPresentation';
  static const String TALENTPROFILESTEP1 = '/talentProfileStep1';
  static const String TALENTPROFILESTEP2 = '/talentProfileStep2';
  static const String TALENTPROFILESTEP3 = '/talentProfileStep3';
  static const String TALENTPROFILESTEP4 = '/talentProfileStep4';
  static const String TALENTPROFILESTEP5 = '/talentProfileStep5';
  static const String TALENTPROFILESTEP6 = '/talentProfileStep6';
  static const String TALENTPROFILESTEP7 = '/talentProfileStep7';
}