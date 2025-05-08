import 'package:flutter/material.dart';
import 'package:pro_connect_projet/constants/routes.dart';
import 'package:pro_connect_projet/views/sizes/app_sizes.dart';
import 'package:pro_connect_projet/views/sizes/text_sizes.dart';

import '../../../widgets/app_button.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/app_textField.dart';
import '../../colors/app_colors.dart';
import '../../modelsUI/field_filling_error.dart';



class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<LogInPage> {

  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _mailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  String _messageMail = "";
  String _messagePassword = "";
  bool _isObscured = true;
  final String _mailVerif = "denisdenos5837@gmail.com";
  final String _passwordVerif = "123456";


  void verifierInfo(){
    if(_passwordController.text.isEmpty){
      setState(() {
        _messagePassword = "Veuillez entrer un mot de passe";
      });
    }
    if(_mailController.text.isEmpty){
      setState(() {
        _messageMail = "Veuillez entrer votre E-mail";
      });
    }else if(!_mailController.text.endsWith("@gmail.com")){
      setState(() {
        _messageMail = "Veuillez entrer un E-mail valide";
      });
    }else if(_mailController.text != _mailVerif || _passwordController.text != _passwordVerif){
      setState(() {
        _messagePassword = "E-mail ou mot de passe incorrect";
      });
    }else{
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.PRESENTATIONPAGE, (route) => false);
    }

  }

  void _focusNodeLaunch(){
    Future.delayed(const Duration(seconds: 2), (){
      FocusScope.of(context).requestFocus(_mailFocusNode);
    });
  }

  @override
  void initState() {
    _focusNodeLaunch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_sharp),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(context.defaultSpacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Titre
              Center(
                child: AppText(
                  text: "Connexion",
                  fontWeight: FontWeight.bold,
                  fontSize: context.mediumText * 1.3,
                  color: AppColors.blueColor,
                ),
              ),

              // Espacement
              SizedBox(
                height: context.defaultPagePadding,
              ),

              // Label de la page
              Center(
                child: AppText(
                  text: "Connectez pour pouvoir profiter des fonctionnalités de ProConnect",
                  color: AppColors.whiteColor,
                  
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
              ),

              // Espacement
              SizedBox(
                height: context.defaultSpacing * 3,
              ),

              //Formulaire LogIN

              //E-mail
              AppTextField(
                keyboardType: TextInputType.emailAddress,
                focusNode: _mailFocusNode,
                controller: _mailController,
                hinText: "Entrez votre E-mail",
                labelText: "E-mail *",
                // En rouge au cas où il y a d'erreur
                enableBorderColor: _messageMail.isNotEmpty ? AppColors.redColor : AppColors.greyColor,
                focusedBorderColor: _messageMail.isNotEmpty ? AppColors.redColor : AppColors.blueColor,
                onChanged: (value){
                  setState(() {
                    _messageMail = "";
                  });
                },
                onSubmitted: (_){
                  FocusScope.of(context).requestFocus(_passwordFocusNode);
                },
              ),

              // Erreur _message
              ErrorMessage(message: _messageMail),

              //Espacement
              SizedBox(
                height: context.defaultSpacing * 3,
              ),

              //Mot de passe
              AppTextField(
                keyboardType: TextInputType.visiblePassword,
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                hinText: "Entrez votre Mot de passe",
                labelText: "Mot de passe *",
                obscureText: _isObscured,
                // En rouge au cas où il y a d'erreur
                enableBorderColor: _messagePassword.isNotEmpty ? AppColors.redColor : AppColors.greyColor,
                focusedBorderColor: _messagePassword.isNotEmpty ? AppColors.redColor : AppColors.blueColor,
                suffixIcon: IconButton(
                  onPressed: (){
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                  icon: Icon(_isObscured ? Icons.visibility : Icons.visibility_off),
                ),
                onChanged: (value){
                  setState(() {
                    _messagePassword = "";
                  });
                },
              ),

              // Erreur _message
              ErrorMessage(message: _messagePassword),

              //Espacement
              SizedBox(
                height: context.defaultSpacing * 2,
              ),

              // Mot de passe oublié
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, AppRoutes.VERIFYMAILPAGE);
                },
                child: AppText(
                  text: "Mot de passe oublié?",
                  color: AppColors.blueColor,
                  fontWeight: FontWeight.bold,
                ),

              ),
              //Espacement
              SizedBox(
                height: context.defaultPagePadding * 2,
              ),
              // Bouton Login
              AppButton(
                onTap: verifierInfo,
                width: double.infinity,
                backgroundColor: AppColors.blueColor,
                alignment: Alignment.center,
                radius: 20,
                child: AppText(
                  text: "Connexion",
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                ),
              ),

              //Espacement
              SizedBox(
                height: context.defaultPagePadding * 2,
              ),

              // Inscrivez-vous au cas où
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //...
                  AppText(
                    text: "Vous n'aviez pas de compte?",
                  ),

                  //Espacement
                  SizedBox(
                    width: context.screenWidth * 0.01,
                  ),

                  // Connect
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacementNamed(context, AppRoutes.PROFILCHOICEPAGE);
                    },
                    child: AppText(
                      text: "Inscrivez-vous !",
                      color: AppColors.blueColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
