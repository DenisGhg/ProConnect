import 'package:flutter/material.dart';
import 'package:pro_connect_projet/constants/routes.dart';
import 'package:pro_connect_projet/views/modelsUI/field_filling_error.dart';
import 'package:pro_connect_projet/views/sizes/app_sizes.dart';
import 'package:pro_connect_projet/views/sizes/text_sizes.dart';
import 'package:provider/provider.dart';

import '../../../providers/reset_password_providers/mail_provider.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/app_textField.dart';
import '../../colors/app_colors.dart';


class VerifyCodePage extends StatefulWidget {
  const VerifyCodePage({super.key});

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {

  final TextEditingController _codeController = TextEditingController();
  String _messageCode = "";

  // Verication du code

  void verifCode(){
    if(_codeController.text.isEmpty || _codeController.text != '123456'){
      _messageCode == "*Entrez incorrect";
    }else{
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.RESETPASSWORDPAGE, (route) => false);
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
          icon: Icon(Icons.arrow_back_sharp,),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.defaultPagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: context.defaultSpacing * 9,),
            RichText(
              text: TextSpan(
                style: TextStyle(color: AppColors.whiteColor, fontSize: context.mediumText, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(text: "Un code a été envoyé de 6 chiffres a été envoyé à : "),
                  TextSpan(text: context.watch<MailProvider>().mailController.text, style: TextStyle(color: AppColors.blueColorSecond))
                ]
              ),
            ),

            SizedBox(height: context.defaultSpacing * 2), // Espacement
            // Field
            AppTextField(
              keyboardType: TextInputType.emailAddress,
              controller: _codeController,
              hinText: "Entrez le code de 6 chiffres",
              labelText: "Code de 6 chiffres*",
              //suffix: AppText(text: "Renvoyez le code", fontSize: 15,),
              // En rouge au cas où il y a d'erreur
              enableBorderColor:
              _messageCode.isNotEmpty ? AppColors.redColor : AppColors.greyColor,
              focusedBorderColor:
              _messageCode.isNotEmpty ? AppColors.redColor : AppColors.blueColor,
              onChanged: (value) {
                setState(() {
                  _messageCode = "";
                });
              },
            ),

            //Message d'erreur en cas de non validité du mail
            ErrorMessage(message: _messageCode),

            SizedBox(height: context.defaultSpacing * 2), // Espacement

            // Bouton continuer
            AppButton(
              onTap: verifCode,
              width: double.infinity,
              backgroundColor: AppColors.blueColor,
              alignment: Alignment.center,
              radius: 20,
              child: AppText(
                text: "Suivant",
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
