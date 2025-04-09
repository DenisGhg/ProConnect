import 'package:flutter/material.dart';

import '../../widgets/app_button.dart';
import '../../widgets/app_text.dart';
import '../../widgets/app_textField.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _rePasswordController = TextEditingController();
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
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    }
  }
  @override
  Widget build(BuildContext context) {
    double screeWidth = MediaQuery.of(context).size.width;
    double screeHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios, color: Colors.red,),
              ),

              // Titre
              Center(
                child: AppText(
                  text: "Nouveau mot de passe",
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.blue.shade900,
                ),
              ),

              // Espacement
              SizedBox(
                height: screeHeight * 0.01,
              ),

              // Label de la page
              Center(
                child: AppText(
                  text: "Créez un nouveau mot de passe",
                  color: Colors.grey.shade900,
                  fontSize: 16,
                  textAlign: TextAlign.center,
                ),
              ),

              // Espacement
              SizedBox(
                height: screeHeight * 0.03,
              ),

              //Formulaire Nouveau password

              // Erreur message
              AppText(
                text: "$_messagePassword",
                color: Colors.red,
                fontSize: 10,
              ),

              //Espacement
              SizedBox(
                height: screeHeight * 0.02,
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
                text: "$_messagePassword",
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
                enableBorderColor: _messageRePassword.isNotEmpty ? Colors.red : Colors.grey,
                focusedBorderColor: _messageRePassword.isNotEmpty ? Colors.red : Colors.grey,
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
                text: "$_messageRePassword",
                color: Colors.red,
                fontSize: 10,
              ),

              //Espacement
              SizedBox(
                height: screeHeight * 0.04 ,
              ),
              // Bouton Login
              AppButton(
                onTap: verifierInfo,
                height: screeHeight * 0.07,
                width: double.infinity,
                backgroundColor: Colors.green,
                alignment: Alignment.center,
                radius: 20,
                child: AppText(
                  text: "Créez un nouveau mot de passe",
                  color: Colors.black,
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
