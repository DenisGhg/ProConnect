import 'package:flutter/material.dart';
import 'package:pro_connect_projet/constants/routes.dart';
import 'package:pro_connect_projet/views/colors/app_colors.dart';
import 'package:pro_connect_projet/views/sizes/app_sizes.dart';
import 'package:pro_connect_projet/views/sizes/text_sizes.dart';
import 'package:pro_connect_projet/widgets/app_button.dart';
import 'package:pro_connect_projet/widgets/app_text.dart';


class TalentProfilPresentation extends StatelessWidget {
  const TalentProfilPresentation({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(context.defaultPagePadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(text: "Votre profil de Talent", fontWeight: FontWeight.bold, fontSize: context.largeText * 0.9, color: AppColors.blueColor,),

              SizedBox(height: context.defaultSpacing * 2),
              AppText(
                text: "Montrez vos compétences et démarquez-vous !",
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: context.defaultSpacing * 2,),
              AppButton(
                onTap: (){
                  Navigator.pushNamed(context, AppRoutes.TALENTPERSONALINFOPAGE);
                },
                alignment: Alignment.center,
                child: AppText(
                  text: "Continuer",
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
