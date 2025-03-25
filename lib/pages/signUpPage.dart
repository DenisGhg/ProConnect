import 'package:flutter/material.dart';
import '../widgets/appButton.dart';
import '../widgets/appText.dart';
import '../widgets/appTextField.dart';

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

  String messageLastName = "";
  String messageFirstName = "";
  String messageMail = "";
  String messagePassword = "";
  String messageRePassword = "";
  String messageTerms = "";

  bool _isObscuredFirst = true;
  bool _isObscuredSecond = true;
  bool _isChecked = false;

  void verifierInfo(){
    if(_lastNameController.text.isEmpty) {
      setState(() {
        messageLastName = "Veuillez entrer votre Nom";
      });
    }
    if(_firstNameController.text.isEmpty){
      setState(() {
        messageFirstName = "Veuillez entrer votre Prénom(s)";
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
    }
    if(_passwordController.text.isEmpty){
      setState(() {
        messagePassword = "Veuillez entrer un mot de passe";
      });
    }
    if(_rePasswordController.text.isEmpty){
      setState(() {
        messageRePassword = "Veuillez confirmer votre mot de passe";
      });
    }else if(_passwordController.text != _rePasswordController.text){
      setState(() {
        messagePassword = "Les mots de passe ne correspondent pas";
        messageRePassword = "Les mots de passe ne correspondent pas";
      });
    }
    if(_isChecked == false){
      setState(() {
        messageTerms = "Veuillez accepter les conditions d'utilisation";
      });
    }
    if(messageLastName.isEmpty && messageFirstName.isEmpty && messageMail.isEmpty && messagePassword.isEmpty && messageRePassword.isEmpty && messageTerms.isEmpty){
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
                  enableBorderColor: messageLastName.isNotEmpty ? Colors.red : Colors.grey,
                  focusedBorderColor: messageLastName.isNotEmpty ? Colors.red : Colors.grey,
                  onChanged: (value){
                    setState(() {
                      messageLastName = "";
                    });
                  },
                ),
        
                // Erreur message
                AppText(
                  text: "$messageLastName",
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
                  enableBorderColor: messageFirstName.isNotEmpty ? Colors.red : Colors.grey,
                  focusedBorderColor: messageFirstName.isNotEmpty ? Colors.red : Colors.grey,
                  onChanged: (value){
                    setState(() {
                      messageFirstName = "";
                    });
                  },
                ),
                // Erreur message
                AppText(
                  text: "$messageFirstName",
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
                  obscureText: _isObscuredFirst,
                  // En rouge au cas où il y a d'erreur
                  enableBorderColor: messagePassword.isNotEmpty ? Colors.red : Colors.grey,
                  focusedBorderColor: messagePassword.isNotEmpty ? Colors.red : Colors.grey,
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
                      messagePassword = "";
                      messageRePassword ="";
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
        
                //Confirmation Mot de passe
                AppTextField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: _rePasswordController,
                  hinText: "Confirmez votre Mot de passe",
                  labelText: "Confirmer ot de passe *",
                  obscureText: _isObscuredSecond,
                  // En rouge au cas où il y a d'erreur
                  enableBorderColor: messageRePassword.isNotEmpty ? Colors.red : Colors.grey,
                  focusedBorderColor: messageRePassword.isNotEmpty ? Colors.red : Colors.grey,
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
                      messageRePassword = "";
                      messagePassword = "";
                    });
                  },
                ),
        
                // Erreur message
                 AppText(
                  text: "$messageRePassword",
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
                          messageTerms = "";
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

                // Erreur message
                AppText(
                  text: "$messageTerms",
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
