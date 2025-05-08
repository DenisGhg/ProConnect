import 'package:flutter/material.dart';
import 'package:pro_connect_projet/constants/routes.dart';
import 'package:pro_connect_projet/views/sizes/app_sizes.dart';
import 'package:pro_connect_projet/views/sizes/text_sizes.dart';
import 'package:provider/provider.dart';

import '../../../providers/reset_password_providers/mail_provider.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/app_textField.dart';
import '../../colors/app_colors.dart';


class VerifyMailPage extends StatefulWidget {
  const VerifyMailPage({super.key});

  @override
  State<VerifyMailPage> createState() => _VerifyMailPageState();
}

class _VerifyMailPageState extends State<VerifyMailPage> {
  //TextEditingController _mailController = TextEditingController();

  String _messageMail = "";
  final FocusNode _mailFocusNode = FocusNode();
  // verfication de la validité du mail

  void verifMail() {
    String mail = context.read<MailProvider>().mailController.text;
    if (!mail.endsWith("@gmail.com") || mail.isEmpty) {
      setState(() {
        _messageMail = "*Veuillez entrer un e-mail valide";
      });
    } else {
      Navigator.pushNamed(context, AppRoutes.VERIFYCODEPAGE);
    }
  }

  void _focusNodeLauch(){
    Future.delayed(const Duration(seconds: 2), (){
      FocusScope.of(context).requestFocus(_mailFocusNode);
    });
  }

  @override
  void initState() {
    _focusNodeLauch();
    super.initState();
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
              Center(
                child: AppText(
                  text: "Récupération du mot de passe",
                  fontSize: context.mediumText * 1.3,
                  color: AppColors.blueColor,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: context.defaultSpacing * 5), // Espacement

              Center(
                child: AppText(
                  text: "Entrez votre adresse e-mail pour récupérer votre mot de passe ",
                  fontSize: context.mediumText * 0.8,
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: context.screenHeight * 0.02), // Espacement
              // Field
              AppTextField(
                keyboardType: TextInputType.emailAddress,
                focusNode: _mailFocusNode,
                controller: context.watch<MailProvider>().mailController,
                hinText: "Entrez votre e-mail",
                labelText: "E-mail *",
                // En rouge au cas où il y a d'erreur
                enableBorderColor: _messageMail.isNotEmpty ? AppColors.redColor : AppColors.greyColor,
                focusedBorderColor:_messageMail.isNotEmpty ? AppColors.redColor : AppColors.blueColor,
                onChanged: (value) {
                  Provider.of<MailProvider>(context, listen: false).updateMail(value);
                  setState(() {
                    _messageMail = "";
                  });
                },
              ),

              //Message d'erreur en cas de non validité du mail
              AppText(text: _messageMail, color: AppColors.redColor, fontSize: 10),

              SizedBox(height: context.defaultSpacing * 3), // Espacement
              // Bouton continuer
              AppButton(
                onTap: verifMail,
                width: double.infinity,
                backgroundColor: AppColors.blueColor,
                alignment: Alignment.center,
                radius: 20,
                child: AppText(
                  text: "Récupérer le mot de passe",
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


