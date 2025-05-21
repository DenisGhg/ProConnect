import 'package:flutter/material.dart';
import 'package:pro_connect_projet/constants/routes.dart';
import 'package:pro_connect_projet/providers/profil_type_provider.dart';
import 'package:pro_connect_projet/views/sizes/app_sizes.dart';
import 'package:pro_connect_projet/views/sizes/text_sizes.dart';
import 'package:provider/provider.dart';

import '../../../widgets/app_button.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/app_textField.dart';
import '../../colors/app_colors.dart';
import '../../modelsUI/field_filling_error.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  final _lastNameFocusNode = FocusNode();
  final _firstNameFocusNode = FocusNode();
  final _mailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _rePasswordFocusNode = FocusNode();

  String _messageLastName = "";
  String _messageFirstName = "";
  String _messageMail = "";
  String _messagePassword = "";
  String _messageRePassword = "";
  String _messageTerms = "";

  bool _isObscuredFirst = true;
  bool _isObscuredSecond = true;
  bool _isChecked = false;

  void verifierInfo(){
    if(_lastNameController.text.isEmpty) {
      setState(() {
        _messageLastName = "Veuillez entrer votre Nom";
      });
    }
    if(_firstNameController.text.isEmpty){
      setState(() {
        _messageFirstName = "Veuillez entrer votre Prénom(s)";
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
    }
    if(_passwordController.text.isEmpty){
      setState(() {
        _messagePassword = "Veuillez entrer un mot de passe";
      });
    }
    if(_rePasswordController.text.isEmpty){
      setState(() {
        _messageRePassword = "Veuillez confirmer votre mot de passe";
      });
    }else if(_passwordController.text != _rePasswordController.text){
      setState(() {
        _messagePassword = "Les mots de passe ne correspondent pas";
        _messageRePassword = "Les mots de passe ne correspondent pas";
      });
    }
    if(_isChecked == false){
      setState(() {
        _messageTerms = "Veuillez accepter les conditions d'utilisation";
      });
    }
    if(_messageLastName.isEmpty && _messageFirstName.isEmpty && _messageMail.isEmpty && _messagePassword.isEmpty && _messageRePassword.isEmpty && _messageTerms.isEmpty){
      //Navigator.pushNamedAndRemoveUntil(context, AppRoutes.SUCESSSIGNUPPAGE, (route) => false);
      String profilType = Provider.of<ProfilTypeProvider>(context, listen: false).profilType;
      if(profilType == "talent"){
        print(profilType);
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.TALENTPROFILPRESENTATION, (route) => false);
      }
    }
  }

  @override
  void dispose() {
    _lastNameFocusNode.dispose();
    _firstNameFocusNode.dispose();
    _mailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _rePasswordFocusNode.dispose();
    super.dispose();
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
          padding: EdgeInsets.all(context.defaultPagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: AppText(
                  text: "Créer un compte",
                  fontWeight: FontWeight.bold,
                  fontSize: context.mediumText * 1.2,
                  color: AppColors.blueColor,
                ),
              ),
          
              // Espacement
              SizedBox(
                height: context.defaultSpacing,
              ),
          
              // Label de la page
              AppText(
                text: "Créez un compte pour pouvoir profiter des fonctionnalités de ProConnect",
                color: AppColors.whiteColor,
                textAlign: TextAlign.center,
              ),
          
              // Espacement
              SizedBox(
                height: context.screenHeight * 0.03,
              ),
          
              //Formulaire SignUP
              //Nom
              AppTextField(
                keyboardType: TextInputType.text,
                controller: _lastNameController,
                focusNode: _lastNameFocusNode,
                hinText: "Entrez votre Nom",
                labelText: "Nom *",
                // En rouge au cas où il y a d'erreur
                enableBorderColor: _messageLastName.isNotEmpty ? AppColors.redColor : AppColors.greyColor,
                focusedBorderColor: _messageLastName.isNotEmpty ? AppColors.redColor : AppColors.blueColorSecond,
                onChanged: (value){
                  setState(() {
                    _messageLastName = "";
                  });
                },
                onSubmitted: (_){
                  FocusScope.of(context).requestFocus(_firstNameFocusNode);
                },
              ),
          
              // Erreur _message
              ErrorMessage(message: _messageLastName),
          
              //Espacement
              SizedBox(
                height: context.screenHeight * 0.02,
              ),
          
              //Prénom(s)
              AppTextField(
                keyboardType: TextInputType.text,
                controller: _firstNameController,
                focusNode: _firstNameFocusNode,
                hinText: "Entrez votre Prénom(s)",
                labelText: "Prénom(s) *",
                // En rouge au cas où il y a d'erreur
                enableBorderColor: _messageFirstName.isNotEmpty ? AppColors.redColor : AppColors.greyColor,
                focusedBorderColor: _messageFirstName.isNotEmpty ? AppColors.redColor : AppColors.blueColorSecond,
                onChanged: (value){
                  setState(() {
                    _messageFirstName = "";
                  });
                },
                onSubmitted: (_){
                  FocusScope.of(context).requestFocus(_mailFocusNode);
                },
              ),
              // Erreur _message
              ErrorMessage(message: _messageFirstName),
          
              //Espacement
              SizedBox(
                height: context.screenHeight * 0.02,
              ),
          
              //E-mail
              AppTextField(
                keyboardType: TextInputType.emailAddress,
                controller: _mailController,
                focusNode: _mailFocusNode,
                hinText: "Entrez votre E-mail",
                labelText: "E-mail *",
                // En rouge au cas où il y a d'erreur
                enableBorderColor: _messageMail.isNotEmpty ? AppColors.redColor : AppColors.greyColor,
                focusedBorderColor: _messageMail.isNotEmpty ? AppColors.redColor : AppColors.blueColorSecond,
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
                height: context.screenHeight * 0.02,
              ),
          
              //Mot de passe
              AppTextField(
                keyboardType: TextInputType.visiblePassword,
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                hinText: "Entrez votre Mot de passe",
                labelText: "Mot de passe *",
                obscureText: _isObscuredFirst,
                // En rouge au cas où il y a d'erreur
                enableBorderColor: _messagePassword.isNotEmpty ? AppColors.redColor : AppColors.greyColor,
                focusedBorderColor: _messagePassword.isNotEmpty ? AppColors.redColor : AppColors.blueColorSecond,
                suffixIcon: IconButton(
                  onPressed: (){
                    setState(() {
                      _isObscuredFirst = !_isObscuredFirst;
                    });
                  },
                  icon: Icon(_isObscuredFirst ? Icons.visibility : Icons.visibility_off),
                ),
                onChanged: (value){
                  setState(() {
                    _messagePassword = "";
                    _messageRePassword ="";
                  });
                },
                onSubmitted: (_){
                  FocusScope.of(context).requestFocus(_rePasswordFocusNode);
                },
              ),
          
              // Erreur _message
              ErrorMessage(message: _messagePassword),
          
              //Espacement
              SizedBox(
                height: context.screenHeight * 0.02,
              ),
          
              //Confirmation Mot de passe
              AppTextField(
                keyboardType: TextInputType.visiblePassword,
                controller: _rePasswordController,
                focusNode: _rePasswordFocusNode,
                hinText: "Confirmez votre Mot de passe",
                labelText: "Confirmer ot de passe *",
                obscureText: _isObscuredSecond,
                // En rouge au cas où il y a d'erreur
                enableBorderColor: _messageRePassword.isNotEmpty ? AppColors.redColor : AppColors.greyColor,
                focusedBorderColor: _messageRePassword.isNotEmpty ? AppColors.redColor : AppColors.blueColorSecond,
                suffixIcon: IconButton(
                  onPressed: (){
                    setState(() {
                      _isObscuredSecond = !_isObscuredSecond;
                    });
                  },
                  icon: Icon(_isObscuredSecond ? Icons.visibility : Icons.visibility_off),
                ),
                onChanged: (value){
                  setState(() {
                    _messageRePassword = "";
                    _messagePassword = "";
                  });
                },
              ),
          
              // Erreur _message
              ErrorMessage(message: _messageRePassword),
          
          
              //Espacement
              SizedBox(
                height: context.screenHeight * 0.001,
              ),
          
              //Accepter les conditions
              Row(
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (value){
                      setState(() {
                        _isChecked = value!;
                        _messageTerms = "";
                      });
                    },
                  ),
          
                  // J'accepte les conditions
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(text: "J'accepte les", style: TextStyle(color: AppColors.whiteColor, fontSize: 15)),
                        TextSpan(text: " conditions d'utilisation", style: TextStyle(color: AppColors.blueColor, fontSize: 15, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
          
                ],
              ),
          
              // Erreur _message
              ErrorMessage(message: _messageTerms),

              SizedBox(height: context.defaultSpacing * 10),
          
              // Bouton création
              AppButton(
                onTap: verifierInfo,
                width: double.infinity,
                backgroundColor: AppColors.blueColor,
                alignment: Alignment.center,
                child: AppText(
                  text: "Créer un compte",
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
          
              SizedBox(
                height: context.defaultSpacing,
              ),
          
              // connectez-vous au cas où
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //...
                  AppText(
                    text: "Vous avez déjà un compte?",
                    color: AppColors.whiteColor,
                    fontSize: context.mediumText * 0.9,
                  ),
          
                  //Espacement
                  SizedBox(
                    width: context.screenWidth * 0.01,
                  ),
          
                  // Connect
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacementNamed(context, AppRoutes.LOGINPAGE);
                    },
                    child: AppText(
                      text: "Connectez-vous !",
                      color: AppColors.blueColor,
                      fontSize: context.mediumText * 0.9,
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



