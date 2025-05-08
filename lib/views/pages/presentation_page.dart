import 'package:flutter/material.dart';
import 'package:pro_connect_projet/constants/routes.dart';
import 'package:pro_connect_projet/views/sizes/app_sizes.dart';
import 'package:pro_connect_projet/views/sizes/text_sizes.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text.dart';
import '../colors/app_colors.dart';

class PresentationPage extends StatefulWidget {
  const PresentationPage({super.key});

  @override
  State<PresentationPage> createState() => _PresentationPageState();
}

class _PresentationPageState extends State<PresentationPage> {



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // Page d'accueil
      body: Padding(
        padding: EdgeInsets.all(context.defaultPagePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Welcome
            AppText(
              text: "Bienvenue sur ProConnect !",
              textAlign: TextAlign.center,
              fontSize: context.largeText * 1.1,
              fontWeight: FontWeight.bold,
              color: AppColors.blueColor,
            ),

            // Espacement
            SizedBox(
              height: context.defaultSpacing * 5,
            ),

            //Bref description
            AppText(
              text: "Créez facilement votre portfolio professionnel et mettez en avant vos compétences et projets en tant qu'informaticien. Que vous soyez recruteur ou talent, ProConnect vous aide à trouver les bonnes connexions dans le monde du numérique.",
              textAlign: TextAlign.center,
              fontWeight: FontWeight.bold,
            ),

            // Espacement
            SizedBox(
              height: context.defaultSpacing * 3,
            ),

            // Espacement
            SizedBox(
              height: context.defaultSpacing * 3,
            ),

            // Boutons Se connecter et S'inscrire
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // Bouton s'inscrire
                AppButton(
                  onTap: (){
                    Navigator.pushNamed(context, AppRoutes.PROFILCHOICEPAGE);
                  },
                  width: context.screenWidth * 0.4,
                  alignment: Alignment.center,
                  child: AppText(
                    text: "S'incrire",
                    fontWeight: FontWeight.bold,
                  ),
                ),

                //Espacement
                SizedBox(
                  width: context.screenWidth * 0.02,
                ),

                // Se Connecter
                AppButton(
                  onTap: (){
                    Navigator.pushNamed(context, AppRoutes.LOGINPAGE);
                  },
                  width: context.screenWidth * 0.4,
                  backgroundColor: AppColors.blueColorSecond,
                  alignment: Alignment.center,
                  child: AppText(
                    text: "Se connecter",
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
