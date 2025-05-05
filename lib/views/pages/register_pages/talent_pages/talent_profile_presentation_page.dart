import 'package:flutter/material.dart';
import 'package:pro_connect_projet/constants/routes.dart';
import 'package:pro_connect_projet/views/colors/app_colors.dart';
import 'package:pro_connect_projet/widgets/app_button.dart';
import 'package:pro_connect_projet/widgets/app_text.dart';


class TalentProfilPresentation extends StatelessWidget {
  const TalentProfilPresentation({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(text: "Votre profil de Talent"),
              SizedBox(height: 20,),
              AppText(
                text: "Montrez vos compétences et démarquez-vous !",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20,),
              Hero(
                tag: "sign",
                child: AppButton(
                  onTap: (){
                    Navigator.pushNamed(context, AppRoutes.TALENTPROFILESTEP1);
                  },
                  height: 50,
                  width: double.infinity,
                  backgroundColor: AppColors.blueColor,
                  alignment: Alignment.center,
                  radius: 20,
                  child: AppText(
                    text: "Continuer",
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
