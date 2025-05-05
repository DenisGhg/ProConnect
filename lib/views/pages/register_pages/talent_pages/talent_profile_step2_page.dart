import 'package:flutter/material.dart';

// La page qui gère la sélection de compétences
class TalentProfileStep2Page extends StatefulWidget {
  const TalentProfileStep2Page({super.key});

  @override
  State<TalentProfileStep2Page> createState() => _TalentProfileStep2PageState();
}

class _TalentProfileStep2PageState extends State<TalentProfileStep2Page> {
  // Dictionnaire des domaines et de leurs sous-domaines
  final Map<String, List<String>> domaines = {
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


  String? domaineActifPourSelection; // Domaine autorisé pour la sélection de sous-domaines
  List<String> sousDomainesChoisis = []; // Liste des sous-domaines sélectionnés
  String? messageAlerte; // Message d'erreur ou d'avertissement
  Set<String> domainesOuverts = {}; // Liste des domaines ouverts (sous-domaines visibles)

  // Gère l'ouverture ou la fermeture des sous-domaines d'un domaine donné
  void toggleAffichageSousDomaines(String domaine) {
    setState(() {
      if (domainesOuverts.contains(domaine)) {
        domainesOuverts.remove(domaine); // Ferme le domaine
      } else {
        domainesOuverts.add(domaine); // Ouvre le domaine
      }
    });
  }

  // Gère la sélection/désélection des sous-domaines
  void toggleSousDomaine(String domaine, String sousDomaine) {
    // Vérifie si aucun domaine n'a encore été activé ou si le domaine actuel est actif
    if (domaineActifPourSelection == null || domaineActifPourSelection == domaine) {
      if (sousDomainesChoisis.contains(sousDomaine)) {
        // Désélection d’un sous-domaine
        setState(() {
          sousDomainesChoisis.remove(sousDomaine);
          // Si plus aucun sous-domaine n'est sélectionné, on réinitialise le domaine actif
          if (sousDomainesChoisis.isEmpty) {
            domaineActifPourSelection = null;
          }
          messageAlerte = null; // Réinitialisation de l'alerte
        });
      } else if (sousDomainesChoisis.length < 3) {
        // Sélection d’un sous-domaine (max 3)
        setState(() {
          sousDomainesChoisis.add(sousDomaine);
          domaineActifPourSelection = domaine;
          messageAlerte = null;
        });
      } else {
        // Si on essaie de sélectionner plus de 3 sous-domaines
        setState(() {
          messageAlerte = 'Tu as deja selectionne 3 sous-domaines.';
        });
      }
    } else {
      // Si on tente de sélectionner un sous-domaine dans un autre domaine
      setState(() {
        messageAlerte = 'Tu ne peux choisir des sous-domaines que dans un seul domaine.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> listeWidgets = [];

    // Génère dynamiquement les widgets pour chaque domaine
    domaines.forEach((domaine, sousDomaines) {
      // Titre du domaine avec icône d'expansion
      listeWidgets.add(
        ListTile(
          title: Text(domaine),
          trailing: Icon(
            domainesOuverts.contains(domaine)
                ? Icons.keyboard_arrow_down
                : Icons.keyboard_arrow_right,
          ),
          onTap: () => toggleAffichageSousDomaines(domaine),
        ),
      );

      // Affiche les sous-domaines si le domaine est ouvert
      if (domainesOuverts.contains(domaine)) {
        listeWidgets.add(
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Wrap(
              spacing: 10,
              children: sousDomaines.map((sousDomaine) {
                final estSelectionne = sousDomainesChoisis.contains(sousDomaine);
                return GestureDetector(
                  onTap: () => toggleSousDomaine(domaine, sousDomaine),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    margin: EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      color: estSelectionne ? Colors.blue : Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      sousDomaine,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      }
    });

    // Affichage principal de la page
    return Scaffold(
      appBar: AppBar(title: Text('Choix des competences')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Choisis un domaine :',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ...listeWidgets, // Affiche tous les domaines et sous-domaines
              if (messageAlerte != null) ...[
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.orange.shade100,
                  child: Text(
                    messageAlerte!,
                    style: TextStyle(color: Colors.orange.shade800),
                  ),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
