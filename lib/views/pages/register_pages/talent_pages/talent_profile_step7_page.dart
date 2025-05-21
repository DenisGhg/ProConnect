import 'package:flutter/material.dart';
import 'package:pro_connect_projet/views/sizes/app_sizes.dart';
import 'package:pro_connect_projet/views/sizes/text_sizes.dart';
import 'package:pro_connect_projet/widgets/app_snackbar.dart';
import 'package:pro_connect_projet/widgets/app_textField.dart';

import '../../../../constants/routes.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_text.dart';
import '../../../colors/app_colors.dart';

class TalentProfileStep7Page extends StatefulWidget {
  const TalentProfileStep7Page({super.key});

  @override
  State<TalentProfileStep7Page> createState() => _TalentProfileStep7PageState();
}

class _TalentProfileStep7PageState extends State<TalentProfileStep7Page> {

  //Controller de la bio
  final TextEditingController _bioController = TextEditingController();

  //Fonction de contrôle
  void _onSubmitted(){
    print(_bioController.text.length);
    if(_bioController.text.length > 100){
      AppSnackBar.show(context, "La bio doit contenir au moins 100 caractères");
    }else{
      Navigator.pushNamed(context, AppRoutes.TALENTPROFILESTEP6);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: context.screenHeight * 0.05,
        leadingWidth: context.screenHeight * 0.075,
        centerTitle: true,
        title: AppText(text: "Créez votre Profil", fontWeight: FontWeight.bold, fontSize: context.largeText * 0.9,),
        leading: Padding(
          padding: EdgeInsets.only(left: context.defaultPagePadding),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.greyColor,
              borderRadius: BorderRadius.circular(context.screenHeight * 0.03),
            ),
            child: Icon(Icons.person, size: context.screenHeight * 0.038, color: AppColors.blackColor,),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(context.defaultPagePadding),
          child: Column(
            children: [
              AppText(
                text: "Présentez-vous en quelques lignes",
                fontWeight: FontWeight.bold,
                fontSize: context.largeText * 0.9,
                textAlign: TextAlign.center,
                color: AppColors.blueColor,
              ),

              SizedBox(height: context.defaultSpacing * 2,),
              AppText(
                text: "Mettez en avant votre parcours, vos compétences clés et ce que vous recherchez. Cette biographie aide les récruteurs à mieux cerner votre profil professionnel.",
                textAlign: TextAlign.justify,
                fontWeight: FontWeight.bold,
              ),

              SizedBox(height: context.defaultSpacing * 4,),

              //Champ de la bio
              AppTextField(
                controller: _bioController,
                keyboardType: TextInputType.text,
                maxLines: 5,
                hinText: "Entrez votre bio",
              ),

              //Instruction
              Align(
                alignment: Alignment.centerRight,
                child: AppText(text: "Au moins 100 lettres", color: AppColors.greyColor,),
              )

        ],
          ),
        ),
      ),

      //Bottom Nav Bar
      bottomNavigationBar:  Container(
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        padding: EdgeInsets.all(context.defaultPagePadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(context.screenHeight * 0.038),
                  border: Border.all(
                    color: AppColors.greyColor,
                    width: 2,
                  )
              ),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios_new, size: context.screenHeight * 0.03, color: AppColors.blueColor,),
              ),
            ),

            //Suivant
            AppButton(
              onTap: _onSubmitted,
              width: context.screenWidth * 0.4,
              child: AppText(text: "Suivant"),
            )
          ],
        ),
      ),
    );
  }
}
