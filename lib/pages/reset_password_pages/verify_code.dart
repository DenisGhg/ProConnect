import 'package:flutter/material.dart';
import 'package:pro_connect_projet/pages/reset_password_pages/email_verification.dart';
import 'package:provider/provider.dart';

import '../../widgets/app_button.dart';
import '../../widgets/app_text.dart';
import '../../widgets/app_textField.dart';


class VerifyCode extends StatefulWidget {
  const VerifyCode({super.key});

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {

  TextEditingController _codeController = TextEditingController();
  String _messageCode = "";

  // Verication du code

  void verifCode(){
    if(_codeController.text.isEmpty || _codeController.text != '123456'){
      _messageCode == "*Entrez incorrect";
    }else{
      Navigator.pushNamedAndRemoveUntil(context, '/newPassword', (route) => false);
    }
  }
  @override
  Widget build(BuildContext context) {

    double screeWidth = MediaQuery.of(context).size.width;
    double screeHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Bouton retour
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_sharp, color: Colors.red),
              ),

              SizedBox(height: screeHeight * 0.04), // Espacement

              Center(
                child: AppText(
                  text: "Un code a été envoyé de 6 chiffres a été envoyé à ${context.watch<RecupMailProvider>().mailController.text}",
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: screeHeight * 0.02), // Espacement
              // Field
              AppTextField(
                keyboardType: TextInputType.emailAddress,
                controller: _codeController,
                hinText: "Entrez le code de 6 chiffres",
                labelText: "Code de 6 chiffres*",
                //suffix: AppText(text: "Renvoyez le code", fontSize: 15,),
                // En rouge au cas où il y a d'erreur
                enableBorderColor:
                _messageCode.isNotEmpty ? Colors.red : Colors.grey,
                focusedBorderColor:
                _messageCode.isNotEmpty ? Colors.red : Colors.grey,
                onChanged: (value) {
                  setState(() {
                    _messageCode = "";
                  });
                },
              ),

              //Message d'erreur en cas de non validité du mail
              AppText(text: _messageCode, color: Colors.red, fontSize: 10),

              SizedBox(height: screeHeight * 0.02), // Espacement


              // Bouton continuer
              AppButton(
                onTap: verifCode,
                height: screeHeight * 0.07,
                width: double.infinity,
                backgroundColor: Colors.blue,
                alignment: Alignment.center,
                radius: 20,
                child: AppText(
                  text: "Suivant",
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
