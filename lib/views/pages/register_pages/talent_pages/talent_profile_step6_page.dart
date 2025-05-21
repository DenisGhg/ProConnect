import 'package:flutter/material.dart';
import 'package:pro_connect_projet/views/sizes/app_sizes.dart';
import 'package:pro_connect_projet/views/sizes/text_sizes.dart';
import 'package:pro_connect_projet/widgets/app_snackbar.dart';

import '../../../../constants/routes.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_text.dart';
import '../../../colors/app_colors.dart';

class TalentProfileStep6Page extends StatefulWidget {
  const TalentProfileStep6Page({super.key});

  @override
  State<TalentProfileStep6Page> createState() => _TalentProfileStep6PageState();
}

class _TalentProfileStep6PageState extends State<TalentProfileStep6Page> {
  // Map pour enregistrer les langues sélectionnées : clé = langue, valeur = niveau
  final Map<String, String> selectedLanguages = {};

  // Listes de langues et de niveaux disponibles dans les menus déroulants
  final List<String> languages = ['Français', 'Anglais', 'Espagnol', 'Allemand'];
  final List<String> levels = [
    'Notions de base',
    'Conversationnel',
    'Courant',
    'Bilingue',
  ];


  // Valeurs temporaires sélectionnées dans les Dropdowns
  String? tempLanguage;
  String? tempLevel;

  // Booléen pour afficher ou non les champs de sélection
  bool showFields = false;

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
              SizedBox(height: context.defaultSpacing * 4,),
              AppText(
                text: "Ajoutez les langues que vous maîtrisez",
                fontWeight: FontWeight.bold,
                fontSize: context.largeText * 0.9,
                textAlign: TextAlign.center,
                color: AppColors.blueColor,
              ),
        
              SizedBox(height: context.defaultSpacing * 2,),
              AppText(
                text: "Indiquez les langues que vous parlez ainsi que votre niveau de maîtrise pour chacune. Ces informations aident les recruteurs à évaluer vos compétences linguistiques et votre capacité à travailler dans différents contextes culturels.",
                textAlign: TextAlign.justify,
                fontWeight: FontWeight.bold,
              ),

              SizedBox(height: context.defaultSpacing * 4,),
              // Bouton pour ajouter une nouvelle langue
              AppButton(
                onTap:() {
                  setState(() {
                    showFields = true;      // Affiche les Dropdowns
                    tempLanguage = null;    // Réinitialise la langue temporaire
                    tempLevel = null;       // Réinitialise le niveau temporaire
                  });
                }, // Utilise la méthode d'affichage de formulaire existante
                width: context.screenWidth * 0.6,
                padding: EdgeInsets.zero,
                height: context.screenHeight * 0.05,
                radius: context.screenWidth * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add),
                    AppText(text: "Ajouter une langue")
                  ],
                ),
              ),
              SizedBox(height: context.defaultSpacing * 4),
        
              // Si le booléen showFields est vrai, on affiche les champs
              if (showFields)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        // Menu déroulant pour choisir la langue
                        SizedBox(
                          width: context.screenWidth * 0.4,
                          child: DropdownButtonFormField<String>(
                            value: tempLanguage,
                            hint: AppText(text: "Langue"),
                            items: languages.map((lang) {
                              return DropdownMenuItem(value: lang, child: AppText(text: lang));
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                tempLanguage = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: context.screenWidth * 0.02), // Espace entre les deux champs

                        // Menu déroulant pour choisir le niveau
                        SizedBox(
                          width: context.screenWidth * 0.4,
                          child: DropdownButtonFormField<String>(
                            value: tempLevel,
                            hint: AppText(text: "Niveau",),
                            items: levels.map((level) {
                              return DropdownMenuItem(value: level, child: AppText(text: level));
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                tempLevel = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: context.defaultSpacing,),

                    // Bouton de validation (icône check)
                    AppButton(
                      width: context.screenWidth * 0.3,
                      onTap: () {
                        if (tempLanguage != null && tempLevel != null) {
                          // Si les deux champs sont remplis, on ajoute la langue à la Map
                          setState(() {
                            selectedLanguages[tempLanguage!] = tempLevel!;
                            showFields = false; // On cache à nouveau les champs
                          });
                        } else {
                          // Si un champ est vide, on affiche un message d'erreur
                          AppSnackBar.show(context, "Veuillez choisir une langue et un niveau.");
                        }
                      },
                      child: AppText(text: "Ajouter"),
                    ),
                  ],
                ),
        
              SizedBox(height: context.defaultSpacing), // Espace
        
              // Affiche les langues sélectionnées si la Map n'est pas vide
              if (selectedLanguages.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: selectedLanguages.entries.map((entry) {
                    return ListTile(
                      title: AppText(text: entry.key), // Langue
                      subtitle: AppText(text: "Niveau : ${entry.value}"), // Niveau
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red), // Bouton de suppression
                        onPressed: () {
                          setState(() {
                            selectedLanguages.remove(entry.key); // Supprime l’entrée de la Map
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),

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
              onTap: ()=>Navigator.pushNamed(context, AppRoutes.TALENTPROFILESTEP7),
              width: context.screenWidth * 0.4,
              child: AppText(text: "Suivant"),
            )
          ],
        ),
      ),
    );
  }
}
