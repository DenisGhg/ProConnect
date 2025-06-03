import 'package:flutter/material.dart';
import 'package:pro_connect_projet/constants/routes.dart';
import 'package:pro_connect_projet/views/colors/app_colors.dart';
import 'package:pro_connect_projet/views/sizes/app_sizes.dart';
import 'package:pro_connect_projet/views/sizes/text_sizes.dart';
import 'package:pro_connect_projet/widgets/app_button.dart';
import 'package:pro_connect_projet/widgets/app_snackbar.dart';
import 'package:pro_connect_projet/widgets/app_text.dart';
import 'package:provider/provider.dart';

import '../../../../providers/register_providers/talent_providers/subdomain_selection_provider.dart';

class SubdomainSelectionPage extends StatefulWidget {
  const SubdomainSelectionPage({super.key});

  @override
  State<SubdomainSelectionPage> createState() => _SubdomainSelectionPageState();
}

class _SubdomainSelectionPageState extends State<SubdomainSelectionPage> {
  // Données principales : domaines et leurs sous-domaines
  final Map<String, List<String>> domainData = {
    'Développement Web et Mobile': [
      'Développement mobile',
      'Développement web',
      'Développement full-stack',
      'Frontend',
      'Backend',
      'Design web et mobile',
    ],
    'Design et UI/UX': [
      'Design UI',
      'Design UX',
      'Maquettage (Figma, Adobe XD)',
      'Identité visuelle',
      'Prototypage interactif',
    ],
    'Data et Intelligence Artificielle': [
      'Science des données',
      'Analyse de données',
      'Machine Learning',
      'Deep Learning',
      'Big Data',
    ],
    'Cybersécurité': [
      'Pentesting',
      'Analyse forensique',
      'Sécurité réseau',
      'Cryptographie',
      'Sécurité applicative',
    ],
    'Administration Systèmes et Réseaux': [
      'Administration systèmes Linux',
      'Administration Windows Server',
      'Virtualisation (VMware, Proxmox)',
      'Réseaux informatiques',
      'Supervision et monitoring',
    ],
    'Marketing Digital et SEO': [
      'Rédaction web',
      'Référencement SEO',
      'Publicité en ligne (Google Ads, Facebook Ads)',
      'Email marketing',
      'Stratégie digitale',
    ],
    'Gestion de Projet et Agilité': [
      'Scrum',
      'Product Owner',
      'Gestion de projet agile',
      'Conduite de projet',
      'Outils de gestion (Jira, Trello)',
    ],
    'DevOps et Cloud': [
      'CI/CD',
      'Infrastructure as Code',
      'Cloud (AWS, Azure, GCP)',
      'Conteneurisation (Docker)',
      'Orchestration (Kubernetes)',
    ],
  };

  // Map pour enregistrer les sous-domaines sélectionnés par domaine
  final Map<String, List<String>> selectedSubDomains = {};

  // Méthode appelée lorsqu’on clique sur un sous-domaine
  void _onSubDomainTap(String domain, String subDomain) {
    final isAlreadySelected = selectedSubDomains[domain]?.contains(subDomain) ?? false;

    setState(() {
      if (isAlreadySelected) {
        // Si déjà sélectionné → on le retire
        selectedSubDomains[domain]!.remove(subDomain);
        if (selectedSubDomains[domain]!.isEmpty) {
          selectedSubDomains.remove(domain); // Retire complètement le domaine s’il est vide
        }
      } else {
        // Vérifie si on tente d'ajouter un 3e domaine
        if (!selectedSubDomains.containsKey(domain) && selectedSubDomains.length >= 2) {
          String alert = "Vous ne pouvez sélectionner des sous-domaines que dans 2 domaines au maximum.";
          AppSnackBar.show(context, alert);
          return;
        }

        // Vérifie la limite de 3 sous-domaines par domaine
        if ((selectedSubDomains[domain]?.length ?? 0) >= 3) {
          String alert = 'Vous ne pouvez sélectionner que 3 sous-domaines dans "$domain".';
          AppSnackBar.show(context, alert);
          return;
        }

        // Ajoute le domaine s’il n’existait pas déjà
        selectedSubDomains.putIfAbsent(domain, () => []);
        selectedSubDomains[domain]!.add(subDomain);
      }
    });
  }



  // Vérifie si un sous-domaine est sélectionné
  bool _isSelected(String domain, String subDomain) {
    return selectedSubDomains[domain]?.contains(subDomain) ?? false;
  }

  void onSubmitted(){
    if(selectedSubDomains.keys.isEmpty){
      AppSnackBar.show(context, "Aucun domaine sélectionné");
    }
    else{
      final provider = Provider.of<SubDomainSelectionProvider>(context, listen: false);
      provider.saveSelections(selectedSubDomains);
      Navigator.pushNamed(context, AppRoutes.SKILLSSELECTIONPAGE);
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
              //Intro
              AppText(
                text: "Choisissez les domaines qui représentent le mieux votre profil professionnel",
                fontWeight: FontWeight.bold,
                fontSize: context.largeText * 0.9,
                textAlign: TextAlign.center,
                color: AppColors.blueColor,
              ),
        
              // Message d’instructions
              SizedBox(height: context.defaultSpacing * 2),
              Row(
                children: [
                  Icon(Icons.info_outline, color: AppColors.blueColor,),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark ? AppColors.whiteColor : AppColors.blackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: context.smallText * 1.2,
                        ),
                        children: [
                          TextSpan(text: "Vous pouvez choisir jusqu’à "),
                          TextSpan(text: "2 domaines", style: TextStyle(color: AppColors.blueColor)),
                          TextSpan(text: " avec "),
                          TextSpan(text: "3 sous-domaines", style: TextStyle(color: AppColors.blueColor)),
                          TextSpan(text: " chacun.")
                        ]
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: context.defaultSpacing),
              Row(
                children: [
                  Icon(Icons.info_outline, color: AppColors.blueColor,),
                  Expanded(
                    child: AppText(
                      text: "Ne vous inquiètez pas, vous pouvez modifier vos choix plus tard",
                      fontWeight: FontWeight.bold,
                      fontSize: context.smallText * 1.3,
                    ),
                  ),
                ],
              ),

              SizedBox(height: context.defaultSpacing * 2),
        
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: domainData.length,
                itemBuilder: (context, index) {
                  final domain = domainData.keys.elementAt(index);
                  final subDomains = domainData[domain]!;
        
                  return ExpansionTile(
                    title: AppText(text: domain, fontWeight: FontWeight.bold,),
                    children: [
                      Wrap(
                        spacing: context.screenWidth * 0.02,
                        runSpacing: context.screenHeight * 0.01,
                        children: subDomains.map((sub) {
                          final isSelected = _isSelected(domain, sub);
        
                          return GestureDetector(
                            onTap: () => _onSubDomainTap(domain, sub),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: context.screenHeight * 0.01, vertical: context.screenHeight * 0.01),
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.blueColor: AppColors.greyColor,
                                borderRadius: BorderRadius.circular(context.defaultPagePadding),
                              ),
                              child: AppText(text: sub)
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: context.defaultSpacing),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),

      //Boutons Confirmer et Retour
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
              onTap: onSubmitted,
              width: context.screenWidth * 0.4,
              child: AppText(text: "Suivant"),
            )
          ],
        ),
      ),
    );
  }
}
