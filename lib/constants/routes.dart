import 'package:flutter/material.dart';
import 'package:pro_connect_projet/providers/register_providers/talent_providers/talent_recap_page.dart';
import 'package:pro_connect_projet/views/pages/auth_pages/log_in_page.dart';
import 'package:pro_connect_projet/views/pages/auth_pages/sign_up_page.dart';
import 'package:pro_connect_projet/views/pages/logo_page.dart';
import 'package:pro_connect_projet/views/pages/presentation_page.dart';
import 'package:pro_connect_projet/views/pages/auth_pages/profil_choice_page.dart';
import 'package:pro_connect_projet/views/pages/register_pages/talent_pages/educations_selection_page.dart';
import 'package:pro_connect_projet/views/pages/register_pages/talent_pages/experiences_selection_page.dart';
import 'package:pro_connect_projet/views/pages/register_pages/talent_pages/languages_selection_page.dart';
import 'package:pro_connect_projet/views/pages/register_pages/talent_pages/subdomain_selection_page.dart';
import 'package:pro_connect_projet/views/pages/register_pages/talent_pages/talent_bio_page.dart';
import 'package:pro_connect_projet/views/pages/register_pages/talent_pages/talent_title_pro_page.dart';
import 'package:pro_connect_projet/views/pages/reset_password_pages/reset_password_page.dart';
import 'package:pro_connect_projet/views/pages/reset_password_pages/verify_code_page.dart';
import 'package:pro_connect_projet/views/pages/reset_password_pages/verify_mail_page.dart';
import 'package:pro_connect_projet/views/pages/success_log_in.dart';

import '../views/pages/register_pages/talent_pages/talent_personal_info_page.dart';
import '../views/pages/register_pages/talent_pages/talent_profile_presentation_page.dart';


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
  '/talentPersonalInfoPage' :(context) => const TalentPersonalInfoPage(),
  '/subdomainSelectionPage' :(context) => const SubdomainSelectionPage(),
  '/talentTitleProPage' :(context) => TalentTitleProPage(),
  '/experiencesSelectionPage' :(context) => ExperiencesSelectionPage(),
  '/educationsSelectionPage' :(context) => EducationsSelectionPage(),
  '/languagesSelectionPage' :(context) => LanguagesSelectionPage(),
  '/talentBioPage' :(context) => TalentBioPage(),
  '/talentRecapPage' : (context) => TalentRecapPage(),
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
  static const String TALENTPERSONALINFOPAGE = '/talentPersonalInfoPage';
  static const String SUBDOMAINSELECTIONPAGE = '/subdomainSelectionPage';
  static const String TALENTTITLEPROPAGE = '/talentTitleProPage';
  static const String EXPERIENCESSELECTIONPAGE = '/experiencesSelectionPage';
  static const String EDUCATIONSSELECTIONPAGE = '/educationsSelectionPage';
  static const String LANGUAGESSELECTIONPAGE = '/languagesSelectionPage';
  static const String TALENTBIOPAGE = '/talentBioPage';
  static const String TALENTRECAPPAGE = '/talentRecapPage';

}