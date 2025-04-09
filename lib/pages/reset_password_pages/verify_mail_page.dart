import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/reset_password_providers/mail_provider.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text.dart';
import '../../widgets/app_textField.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  //TextEditingController _mailController = TextEditingController();

  String _messageMail = "";
  //TextEditingController get userMail => _mailController;

  // verfication de la validité du mail

  void verifMail() {
    String mail = context.read<MailProvider>().mailController.text;
    if (!mail.endsWith("@gmail.com") || mail.isEmpty) {
      setState(() {
        _messageMail = "*Veuillez entrer un e-mail valide";
      });
    } else {
      Navigator.pushNamed(context, '/verifCode');
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
                  text: "Récupération du mot de passe",
                  fontSize: 20,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: screeHeight * 0.05), // Espacement

              Center(
                child: AppText(
                  text:
                      "Entrez votre adresse e-mail pour récupérer votre mot de passe ",
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),

              SizedBox(height: screeHeight * 0.02), // Espacement
              // Field
              AppTextField(
                keyboardType: TextInputType.emailAddress,
                controller: context.watch<MailProvider>().mailController,
                hinText: "Entrez votre e-mail",
                labelText: "E-mail *",
                // En rouge au cas où il y a d'erreur
                enableBorderColor:
                    _messageMail.isNotEmpty ? Colors.red : Colors.grey,
                focusedBorderColor:
                    _messageMail.isNotEmpty ? Colors.red : Colors.grey,
                onChanged: (value) {
                  Provider.of<MailProvider>(context, listen: false).updateMail(value);
                  setState(() {
                    _messageMail = "";
                  });
                },
              ),

              //Message d'erreur en cas de non validité du mail
              AppText(text: _messageMail, color: Colors.red, fontSize: 10),

              SizedBox(height: screeHeight * 0.02), // Espacement
              // Bouton continuer
              AppButton(
                onTap: verifMail,
                height: screeHeight * 0.07,
                width: screeHeight,
                backgroundColor: Colors.blue,
                alignment: Alignment.center,
                radius: 20,
                child: AppText(
                  text: "Récupérer le mot de passe",
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


