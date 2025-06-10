import 'package:pro_connect_projet/providers/auth_providers/sign_up_provider.dart';
import 'package:pro_connect_projet/providers/profil_type_provider.dart';
import 'package:pro_connect_projet/providers/register_providers/talent_providers/skill_selection_provider.dart';
import 'package:pro_connect_projet/providers/register_providers/talent_providers/subdomain_selection_provider.dart';
import 'package:pro_connect_projet/providers/register_providers/talent_providers/talent_bio_provider.dart';
import 'package:pro_connect_projet/providers/register_providers/talent_providers/talent_education_provider.dart';
import 'package:pro_connect_projet/providers/register_providers/talent_providers/talent_experience_provider.dart';
import 'package:pro_connect_projet/providers/register_providers/talent_providers/talent_language_provider.dart';
import 'package:pro_connect_projet/providers/register_providers/talent_providers/talent_personal_info_provider.dart';
import 'package:pro_connect_projet/providers/register_providers/talent_providers/talent_title_pro_provider.dart';
import 'package:pro_connect_projet/providers/reset_password_providers/mail_provider.dart';
import 'package:pro_connect_projet/providers/talent_providers/notification_talent_provider.dart';
import 'package:pro_connect_projet/providers/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';


List<SingleChildWidget> providers = [
  //Recuperation du mail pour la réinitialisation du mot de passe
  ChangeNotifierProvider(create: (context) => MailProvider()),

  //Type de profil
  ChangeNotifierProvider(create: (context) => ProfilTypeProvider()),

  //Theme
  ChangeNotifierProvider(create: (context) => ThemeProvider()),

  //Page d'inscription
  ChangeNotifierProvider(create: (context) => SignUpProvider()),

  //Info Personnel Talent
  ChangeNotifierProvider(create: (context) => TalentPersonalInfoProvider()),

  //Choix des domaines et sous domaines
  ChangeNotifierProvider(create: (context) => SubDomainSelectionProvider()),
  
  //Choix des compétences
  ChangeNotifierProvider(create: (context) => SkillSelectionProvider()),

  //Titre Pro Talent
  ChangeNotifierProvider(create: (context) => TalentTitleProProvider()),

  //Experiences Talent
  ChangeNotifierProvider(create: (context) => TalentExperienceProvider()),

  //Educations Talent
  ChangeNotifierProvider(create: (context) => TalentEducationProvider()),

  //Langues du Talent
  ChangeNotifierProvider(create: (context) => TalentLanguageProvider()),

  //Bio du Talent
  ChangeNotifierProvider(create: (context) => TalentBioProvider()),

  //AFTER LOGIN

  //Notification Talent
  ChangeNotifierProvider(create: (context) => NotificationTalentProvider()),
  
];