import 'package:flutter/material.dart';

import '../../widgets/app_button.dart';
import '../../widgets/app_text.dart';
import '../../widgets/app_textField.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _mailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _rePasswordController = TextEditingController();

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
      Navigator.pushNamedAndRemoveUntil(context, '/succesSignUp', (route) => false);
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
                  icon: Icon(Icons.arrow_back_sharp, color: Colors.red,),
                ),
        
                // Titre
                Center(
                  child: AppText(
                    text: "Créer un compte",
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
                    text: "Créez un compte pour pouvoir profiter des fonctionnalités de ProConnect",
                    color: Colors.grey.shade900,
                    fontSize: 16,
                    textAlign: TextAlign.center,
                  ),
                ),
        
                // Espacement
                SizedBox(
                  height: screeHeight * 0.03,
                ),
        
                //Formulaire SignUP
                //Nom
                AppTextField(
                  keyboardType: TextInputType.text,
                  controller: _lastNameController,
                  hinText: "Entrez votre Nom",
                  labelText: "Nom *",
                  // En rouge au cas où il y a d'erreur
                  enableBorderColor: _messageLastName.isNotEmpty ? Colors.red : Colors.grey,
                  focusedBorderColor: _messageLastName.isNotEmpty ? Colors.red : Colors.grey,
                  onChanged: (value){
                    setState(() {
                      _messageLastName = "";
                    });
                  },
                ),
        
                // Erreur _message
                AppText(
                  text: "$_messageLastName",
                  color: Colors.red,
                  fontSize: 10,
                ),
        
                //Espacement
                SizedBox(
                  height: screeHeight * 0.02,
                ),
        
                //Prénom(s)
                AppTextField(
                  keyboardType: TextInputType.text,
                  controller: _firstNameController,
                  hinText: "Entrez votre Prénom(s)",
                  labelText: "Prénom(s) *",
                  // En rouge au cas où il y a d'erreur
                  enableBorderColor: _messageFirstName.isNotEmpty ? Colors.red : Colors.grey,
                  focusedBorderColor: _messageFirstName.isNotEmpty ? Colors.red : Colors.grey,
                  onChanged: (value){
                    setState(() {
                      _messageFirstName = "";
                    });
                  },
                ),
                // Erreur _message
                AppText(
                  text: "$_messageFirstName",
                  color: Colors.red,
                  fontSize: 10,
                ),
        
                //Espacement
                SizedBox(
                  height: screeHeight * 0.02,
                ),
        
                //E-mail
                AppTextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _mailController,
                  hinText: "Entrez votre E-mail",
                  labelText: "E-mail *",
                  // En rouge au cas où il y a d'erreur
                  enableBorderColor: _messageMail.isNotEmpty ? Colors.red : Colors.grey,
                  focusedBorderColor: _messageMail.isNotEmpty ? Colors.red : Colors.grey,
                  onChanged: (value){
                    setState(() {
                      _messageMail = "";
                    });
                  },
                ),
        
                // Erreur _message
                AppText(
                  text: "$_messageMail",
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
                      _messageRePassword ="";
                    });
                  },
                ),
        
                // Erreur _message
                AppText(
                  text: "$_messagePassword",
                  color: Colors.red,
                  fontSize: 10,
                ),
        
                //Espacement
                SizedBox(
                  height: screeHeight * 0.02,
                ),
        
                //Confirmation Mot de passe
                AppTextField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: _rePasswordController,
                  hinText: "Confirmez votre Mot de passe",
                  labelText: "Confirmer ot de passe *",
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
                      _messageRePassword = "";
                      _messagePassword = "";
                    });
                  },
                ),
        
                // Erreur _message
                 AppText(
                  text: "$_messageRePassword",
                  color: Colors.red,
                  fontSize: 10,
                ),
        
        
                //Espacement
                SizedBox(
                  height: screeHeight * 0.001,
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
                        children: const<TextSpan>[
                          TextSpan(text: "J'accepte les", style: TextStyle(color: Colors.black, fontSize: 15)),
                          TextSpan(text: " conditions d'utilisation", style: TextStyle(color: Colors.green, fontSize: 15, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),

                  ],
                ),

                // Erreur _message
                AppText(
                  text: "$_messageTerms",
                  color: Colors.red,
                  fontSize: 10,
                ),

                // Bouton création
                AppButton(
                  onTap: verifierInfo,
                  height: screeHeight * 0.07,
                  width: double.infinity,
                  backgroundColor: Colors.green,
                  alignment: Alignment.center,
                  radius: 20,
                  child: AppText(
                    text: "Créer un compte",
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(
                  height: screeHeight * 0.01,
                ),

                // connectez-vous au cas où
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //...
                    AppText(
                      text: "Vous avez déjà un compte?",
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
                        Navigator.pushReplacementNamed(context, '/logIn');
                      },
                      child: AppText(
                        text: "Connectez-vous !",
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
