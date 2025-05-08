import 'package:flutter/material.dart';
import 'package:pro_connect_projet/constants/routes.dart';
import 'package:pro_connect_projet/views/colors/app_colors.dart';
import 'package:pro_connect_projet/views/sizes/app_sizes.dart';
import 'package:pro_connect_projet/views/sizes/text_sizes.dart';

import '../../../widgets/app_button.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/app_textField.dart';



class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  String _messagePassword = "";
  String _messageRePassword = "";
  bool _isObscuredFirst = true;
  bool _isObscuredSecond = true;

  //Fonction de vérification

  void verifierInfo(){
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
    if(_messagePassword.isEmpty && _messageRePassword.isEmpty){
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.PRESENTATIONPAGE, (route) => false);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
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
              // Titre
              Center(
                child: AppText(
                  text: "Nouveau mot de passe",
                  fontWeight: FontWeight.bold,
                  fontSize: context.largeText * 0.9,
                  color: AppColors.blueColor,
                ),
              ),
        
              // Espacement
              SizedBox(
                height: context.defaultSpacing,
              ),
        
              // Label de la page
              Center(
                child: AppText(
                  text: "Créez un nouveau mot de passe",
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.bold,
                ),
              ),
        
              // Espacement
              SizedBox(
                height: context.defaultSpacing * 3,
              ),
        
              //Formulaire Nouveau password
        
              // Erreur message
              AppText(
                text: _messagePassword,
                color: Colors.red,
                fontSize: context.smallText,
              ),
        
              //Espacement
              SizedBox(
                height: context.screenHeight * 0.02,
              ),
        
              //Mot de passe
              AppTextField(
                keyboardType: TextInputType.visiblePassword,
                controller: _passwordController,
                hinText: "Entrez votre le nouveau mot de passe",
                labelText: "Nouveau mot de passe",
                obscureText: _isObscuredFirst,
                // En rouge au cas où il y a d'erreur
                enableBorderColor: _messagePassword.isNotEmpty ? Colors.red : Colors.grey,
                focusedBorderColor: _messagePassword.isNotEmpty ? Colors.red : Colors.grey,
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
                    _messageRePassword = "";
                  });
                },
              ),
        
              // Erreur message
              AppText(
                text: _messagePassword,
                color: Colors.red,
                fontSize: 10,
              ),
        
              //Mot de passe
              AppTextField(
                keyboardType: TextInputType.visiblePassword,
                controller: _rePasswordController,
                hinText: "Confirmez le nouveau mot de passe",
                labelText: "Confirmez mot de passe*",
                obscureText: _isObscuredSecond,
                // En rouge au cas où il y a d'erreur
                enableBorderColor: _messageRePassword.isNotEmpty ? AppColors.redColor : AppColors.greyColor,
                focusedBorderColor: _messageRePassword.isNotEmpty ? AppColors.redColor : AppColors.blueColor,
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
                    _messagePassword = "";
                    _messageRePassword = "";
                  });
                },
              ),
        
              // Erreur message
              AppText(
                text: _messageRePassword,
                color: AppColors.redColor,
                fontSize: context.smallText,
              ),
        
              //Espacement
              SizedBox(
                height: context.defaultSpacing * 4,
              ),
              // Bouton Login
              AppButton(
                onTap: verifierInfo,
                backgroundColor: AppColors.blueColor,
                alignment: Alignment.center,
                radius: 20,
                child: AppText(
                  text: "Créez un nouveau mot de passe",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
