import 'package:flutter/material.dart';

import '../../widgets/app_button.dart';
import '../../widgets/app_text.dart';
import '../../widgets/app_textField.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<LogInPage> {

  TextEditingController _mailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String messageMail = "";
  String messagePassword = "";
  bool _isObscured = true;
  String _mailVerif = "denisdenos5837@gmail.com";
  String _passwordVerif = "123456";


  void verifierInfo(){
    if(_passwordController.text.isEmpty){
      setState(() {
        messagePassword = "Veuillez entrer un mot de passe";
      });
    }
    if(_mailController.text.isEmpty){
      setState(() {
        messageMail = "Veuillez entrer votre E-mail";
      });
    }else if(!_mailController.text.endsWith("@gmail.com")){
      setState(() {
        messageMail = "Veuillez entrer un E-mail valide";
      });
    }else if(_mailController.text != _mailVerif || _passwordController.text != _passwordVerif){
      setState(() {
        messagePassword = "E-mail ou mot de passe incorrect";
      });
    }else{
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
          child: SingleChildScrollView(
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
                    text: "Connexion",
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
                    text: "Connectez pour pouvoir profiter des fonctionnalités de ProConnect",
                    color: Colors.grey.shade900,
                    fontSize: 16,
                    textAlign: TextAlign.center,
                  ),
                ),
        
                // Espacement
                SizedBox(
                  height: screeHeight * 0.03,
                ),
        
                //Formulaire LogIN
        
                //E-mail
                AppTextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _mailController,
                  hinText: "Entrez votre E-mail",
                  labelText: "E-mail *",
                  // En rouge au cas où il y a d'erreur
                  enableBorderColor: messageMail.isNotEmpty ? Colors.red : Colors.grey,
                  focusedBorderColor: messageMail.isNotEmpty ? Colors.red : Colors.grey,
                  onChanged: (value){
                    setState(() {
                      messageMail = "";
                    });
                  },
                ),
        
                // Erreur message
                AppText(
                  text: "$messageMail",
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
                  hinText: "Entrez votre Mot de passe",
                  labelText: "Mot de passe *",
                  obscureText: _isObscured,
                  // En rouge au cas où il y a d'erreur
                  enableBorderColor: messagePassword.isNotEmpty ? Colors.red : Colors.grey,
                  focusedBorderColor: messagePassword.isNotEmpty ? Colors.red : Colors.grey,
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
                      messagePassword = "";
                    });
                  },
                ),
        
                // Erreur message
                AppText(
                  text: "$messagePassword",
                  color: Colors.red,
                  fontSize: 10,
                ),
        
                //Espacement
                SizedBox(
                  height: screeHeight * 0.02,
                ),
        
                // Mot de passe oublié
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, '/verifMail');
                  },
                  child: AppText(
                    text: "Mot de passe oublié?",
                    color: Colors.green,
                    fontSize: screeWidth * 0.04,
                    fontWeight: FontWeight.bold,
                  ),

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
                    text: "Connexion",
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        
                //Espacement
                SizedBox(
                  height: screeHeight * 0.04,
                ),
        
                // Inscrivez-vous au cas où
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //...
                    AppText(
                      text: "Vous n'aviez pas de compte?",
                      color: Colors.blue.shade900,
                      fontSize: screeWidth * 0.04,

                    ),
        
                    //Espacement
                    SizedBox(
                      width: screeWidth * 0.01,
                    ),
        
                    // Connect
                    GestureDetector(
                      onTap: (){
                        Navigator.pushReplacementNamed(context, '/profilChoice');
                      },
                      child: AppText(
                        text: "Inscrivez-vous !",
                        color: Colors.green,
                        fontSize: screeWidth * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
