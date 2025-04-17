import 'package:pro_connect_projet/providers/profil_type_provider.dart';
import 'package:pro_connect_projet/providers/reset_password_providers/mail_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';


List<SingleChildWidget> providers = [
  //Recuperation du mail pour la réinitialisation du mot de passe
  ChangeNotifierProvider(create: (context) => MailProvider()),

  //Type de profil
  ChangeNotifierProvider(create: (context) => ProfilTypeProvider()),
];