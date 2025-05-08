import 'package:flutter/material.dart';
import 'package:pro_connect_projet/constants/images_paths.dart';
import 'package:pro_connect_projet/constants/routes.dart';
import 'package:pro_connect_projet/providers/profil_type_provider.dart';
import 'package:pro_connect_projet/views/colors/app_colors.dart';
import 'package:pro_connect_projet/views/sizes/app_sizes.dart';
import 'package:pro_connect_projet/views/sizes/text_sizes.dart';
import 'package:provider/provider.dart';


import '../../../providers/themes/theme_provider.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_text.dart';

class ProfilChoicePage extends StatefulWidget {
  const ProfilChoicePage({super.key});

  @override
  State<ProfilChoicePage> createState() => _ProfilChoicePageState();
}

class _ProfilChoicePageState extends State<ProfilChoicePage> {

  bool selectedT = false;
  bool selectedR = false;
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_outlined,),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(context.defaultPagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profil Type
            Center(
              child: AppText(
                text: "Type de profil",
                fontWeight: FontWeight.bold,
                fontSize: context.mediumText * 1.2,
                color: AppColors.blueColor,
              ),
            ),

            // Espacement
            SizedBox(
              height: context.defaultSpacing,
            ),

            // Label de la page
            AppText(
              text: "Selectionnez le type de profil que vous souhaitez créer",
              fontSize: context.mediumText,
              textAlign: TextAlign.center,
            ),

            // Espacement
            SizedBox(
              height: context.defaultSpacing,
            ),

            // Containais de selection de Police

            // Choix Talent
            Stack(
              children: [
                // Contenu
                AppButton(
                  onTap: (){
                    setState(() {
                      selectedT = !selectedT;
                      selectedR = false;
                    });
                  },
                  height: context.screenHeight * 0.26,
                  width: double.infinity,
                  backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode ? AppColors.blackColor : AppColors.whiteColor,
                  borderColor: selectedT ? AppColors.blueColor : AppColors.greyColor,
                  borderWidth: 3,
                  //Image et Description
                  child: Row(
                    children: [
                      SizedBox(
                        height: context.screenHeight * 0.22,
                        width: context.screenWidth * 0.22,
                        child: Image.asset(
                          ImagesPaths.FINDJOB,
                          fit: BoxFit.cover,
                        ),
                      ),

                      //Espacement
                      SizedBox(
                        width: context.screenWidth * 0.05,
                      ),

                      Column(
                        children: [
                          //Titre
                          AppText(
                            text: 'Talent',
                            fontSize: context.mediumText,
                            fontWeight: FontWeight.bold,
                            color : selectedT ? AppColors.blueColor : null,
                          ),

                          //Label
                          SizedBox(
                            height: context.screenHeight * 0.18,
                            width: context.screenWidth * 0.48,
                            child: AppText(
                              text: "Etes vous à la recherche d'un emploi ? Créez un profil Talent pour acceder aux offres d'emploi et vous connectez aux recruteurs",
                              fontSize: context.smallText * 1.38,
                              color : selectedT ? AppColors.blueColor : null,
                              textAlign: TextAlign.center,
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),

                // Icone vert si selectionné
                selectedT ? Positioned(top: 0, right: 0,child: Icon(Icons.check_circle_sharp, color: AppColors.blueColor, size: context.screenWidth * 0.06,)) : Positioned(child: SizedBox()),

              ],
            ),

            // Espacement
            SizedBox(
              height: context.screenHeight * 0.02,
            ),

            // Choix Recruteur
            Stack(
              children: [
                // Contenu
                AppButton(
                  onTap: (){
                    setState(() {
                      selectedR = !selectedR;
                      selectedT = false;
                    });
                  },
                  height: context.screenHeight * 0.26,
                  width: double.infinity,
                  backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode ? AppColors.blackColor : AppColors.whiteColor,
                  borderColor: selectedR ? AppColors.blueColor : AppColors.greyColor,
                  borderWidth: 3,
                  //Image et Description
                  child: Row(
                    children: [
                      SizedBox(
                        height: context.screenHeight * 0.22,
                        width: context.screenWidth * 0.22,
                        child: Image.asset(
                          ImagesPaths.FINDTALENT,
                          fit: BoxFit.cover,
                        ),
                      ),

                      //Espacement
                      SizedBox(
                        width: context.screenWidth * 0.05,
                      ),

                      Column(
                        children: [
                          //Titre
                          AppText(
                            text: 'Recruteur',
                            fontSize: context.mediumText,
                            fontWeight: FontWeight.bold,
                            color : selectedR ? AppColors.blueColor : null,
                          ),

                          //Label
                          SizedBox(
                            height: context.screenHeight * 0.18,
                            width: context.screenWidth * 0.48,
                            child: AppText(
                              text: "Etês vous à la recherche d'un employé ? Créer un profil Recruteur et créez des appels d'offre et connectez-vous aux talents",
                              fontSize: context.smallText * 1.4,
                              color : selectedR ? AppColors.blueColor : null,
                              textAlign: TextAlign.center,
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),

                // Icone vert si selectionné
                selectedR ? Positioned(top: 0, right: 0,child: Icon(Icons.check_circle_sharp, color: AppColors.blueColor, size: context.screenWidth * 0.06,)) : Positioned(child: SizedBox()),

              ],
            ),

            SizedBox(height: context.defaultSpacing,),

            Center(
              child: AppText(
                text: errorMessage.isEmpty ? "" : errorMessage,
                color: AppColors.redColor,
              ),
            ),

            //Pour decaler le bouton vers le bas
            Spacer(),

            // Bouton Continuer
            AppButton(
              onTap: (){
                if(selectedT){
                  context.read<ProfilTypeProvider>().setProfilType("talent");
                  Navigator.pushReplacementNamed(context, AppRoutes.SIGNUPPAGE);

                }else if(selectedR){
                  Navigator.pushReplacementNamed(context, AppRoutes.SIGNUPPAGE);
                  context.read<ProfilTypeProvider>().setProfilType("recruteur");
                }else{
                  setState(() {
                    errorMessage = "Veuillez selectionner un type de profil";
                  });
                }
              },
              width: double.infinity,
              backgroundColor: selectedT || selectedR ? AppColors.blueColor : AppColors.greyColor,
              alignment: Alignment.center,
              child: AppText(
                text: "Continuer",
                fontSize: context.mediumText * 1.2,
                fontWeight: FontWeight.bold,
              ),
            ),

          ],
        ),
      ),
    );
  }
}

