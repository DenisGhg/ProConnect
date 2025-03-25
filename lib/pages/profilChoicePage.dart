import 'package:flutter/material.dart';

import '../widgets/appButton.dart';
import '../widgets/appText.dart';

class ProfilChoicePage extends StatefulWidget {
  const ProfilChoicePage({super.key});

  @override
  State<ProfilChoicePage> createState() => _ProfilChoicePageState();
}

class _ProfilChoicePageState extends State<ProfilChoicePage> {

  bool selectedT = false;
  bool selectedR = false;
  bool selectedTalent = false;
  bool selectedRecruteur = false;
  String errorMessage = "";

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
              IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_outlined, color: Colors.red, size: 30,),
              ),
        
              // Profil Type
              Center(
                child: AppText(
                  text: "Type de profil",
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
              AppText(
                text: "Selectionnez le type de profil que vous souhaitez créer",
                color: Colors.grey.shade900,
                fontSize: 16,
                textAlign: TextAlign.center,
              ),
        
              // Espacement
              SizedBox(
                height: screeHeight * 0.01
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
                        selectedTalent = !selectedTalent;
                      });
                    },
                    height: screeHeight * 0.26,
                    width: double.infinity,
                    backgroundColor: Colors.white,
                    borderColor: selectedT ? Colors.green : Colors.grey,
                    borderWidth: 3,
                    //Image et Description
                    child: Row(
                      children: [
                        SizedBox(
                          height: screeHeight * 0.22,
                          width: screeWidth * 0.22,
                          child: Image.asset(
                            "images/talentbgless.png",
                            fit: BoxFit.cover,
                          ),
                        ),
        
                        //Espacement
                        SizedBox(
                          width: screeWidth * 0.05,
                        ),
        
                        Column(
                          children: [
                            //Titre
                            AppText(
                              text: 'Talent',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color : selectedT ? Colors.green : Colors.black,
                            ),
        
                            //Label
                            SizedBox(
                              height: screeHeight * 0.18,
                              width: 170,
                              child: AppText(
                                text: "Etes vous à la recherche d'un emploi ? Créez un profil Talent pour acceder aux offres d'emploi et vous connectez aux recruteurs",
                                fontSize: 14,
                                color : selectedT ? Colors.green : Colors.black,
                                textAlign: TextAlign.center,
                              ),
                            ),
        
                          ],
                        ),
                      ],
                    ),
                  ),
        
                  // Icone vert si selectionné
                  selectedT ? Positioned(top: 0, right: 0,child: Icon(Icons.check_circle_sharp, color: Colors.green,size: 25,)) : Positioned(child: SizedBox()),
        
                ],
              ),
        
              // Espacement
              SizedBox(
                height: screeHeight * 0.02,
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
                        selectedRecruteur = !selectedRecruteur;
                      });
                    },
                    height: screeHeight * 0.26,
                    width: double.infinity,
                    backgroundColor: Colors.white,
                    borderColor: selectedR ? Colors.green : Colors.grey,
                    borderWidth: 3,
                    //Image et Description
                    child: Row(
                      children: [
                        SizedBox(
                          height: screeHeight * 0.22,
                          width: screeWidth * 0.22,
                          child: Image.asset(
                            "images/recruteurbgless.png",
                            fit: BoxFit.cover,
                          ),
                        ),
        
                        //Espacement
                        SizedBox(
                          width: screeWidth * 0.05,
                        ),
        
                        Column(
                          children: [
                            //Titre
                            AppText(
                              text: 'Recruteur',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color : selectedR ? Colors.green : Colors.black,
                            ),
        
                            //Label
                            SizedBox(
                              height: screeHeight * 0.18,
                              width: 170,
                              child: AppText(
                                text: "Etês vous à la recherche d'un employé ? Créer un profil Recruteur et créez des appels d'offre et connectez-vous aux talents",
                                fontSize: 14,
                                color : selectedR ? Colors.green : Colors.black,
                                textAlign: TextAlign.center,
                              ),
                            ),
        
                          ],
                        ),
                      ],
                    ),
                  ),
        
                  // Icone vert si selectionné
                  selectedR ? Positioned(top: 0, right: 0,child: Icon(Icons.check_circle_sharp, color: Colors.green,size: 25,)) : Positioned(child: SizedBox()),
        
                ],
              ),
        
              AppText(
                text: errorMessage.isEmpty ? "" : errorMessage,
                color: Colors.red,
              ),
        
              //Pour decaler le bouton vers le bas
              Spacer(),
        
              // Bouton Continuer
              AppButton(
                onTap: (){
                  if(selectedTalent){
                    Navigator.pushNamed(context, '/signUp');
                  }else if(selectedRecruteur){
                    Navigator.pushNamed(context, '/signUp');
                  }else{
                    setState(() {
                      errorMessage = "Veuillez selectionner un type de profil";
                    });
                  }
                },
                height: screeHeight * 0.07,
                width: double.infinity,
                backgroundColor: selectedT || selectedR ? Colors.green : Colors.grey,
                alignment: Alignment.center,
                radius: 20,
                child: AppText(
                  text: "Continuer",
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
