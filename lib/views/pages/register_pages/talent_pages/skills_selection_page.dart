import 'package:flutter/material.dart';
import 'package:pro_connect_projet/views/colors/app_colors.dart';
import 'package:pro_connect_projet/views/sizes/app_sizes.dart';
import 'package:pro_connect_projet/views/sizes/text_sizes.dart';
import 'package:pro_connect_projet/widgets/app_text.dart';
import 'package:provider/provider.dart';

import '../../../../constants/routes.dart';
import '../../../../providers/register_providers/talent_providers/skill_selection_provider.dart';
import '../../../../providers/register_providers/talent_providers/subdomain_selection_provider.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_snackbar.dart';
import '../../../../widgets/app_textField.dart';

// =========================== PAGE DE SÉLECTION DES SKILLS ===========================
class SkillSelectionPage extends StatefulWidget {
  const SkillSelectionPage({super.key});

  @override
  State<SkillSelectionPage> createState() => _SkillSelectionPageState();
}

class _SkillSelectionPageState extends State<SkillSelectionPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _tempSelectedSkills = [];

  // Map globale de skills par sous-domaine (master list)
  final Map<String, List<String>> skillSuggestions = {
    // Développement Web et Mobile
    'Développement mobile': [
      'Flutter',
      'Dart',
      'Kotlin',
      'Swift',
      'React Native',
      'Java (Android)',
      'Objective-C',
    ],
    'Développement web': [
      'HTML',
      'CSS',
      'JavaScript',
      'TypeScript',
      'PHP',
      'Ruby on Rails',
      'ASP.NET',
    ],
    'Développement full-stack': [
      'Node.js',
      'Express',
      'MongoDB',
      'React',
      'Angular',
      'Vue.js',
      'Django',
    ],
    'Frontend': [
      'React',
      'Vue.js',
      'Angular',
      'Svelte',
      'Bootstrap',
      'Tailwind CSS',
      'Webpack',
    ],
    'Backend': [
      'Node.js',
      'Express',
      'Laravel',
      'Django',
      'Spring Boot',
      'Ruby',
      'Go',
      'PHP',
    ],
    'Design web et mobile': [
      'Adobe XD',
      'Figma',
      'Sketch',
      'InVision',
      'Principle',
      'Zeplin',
    ],

    // Design et UI/UX
    'Design UI': [
      'Adobe Photoshop',
      'Adobe Illustrator',
      'Figma',
      'Sketch',
      'Canva',
    ],
    'Design UX': [
      'Wireframing',
      'User Research',
      'Usability Testing',
      'Information Architecture',
      'Persona Creation',
    ],
    'Maquettage (Figma, Adobe XD)': [
      'Figma',
      'Adobe XD',
      'Sketch',
      'Axure',
      'Balsamiq',
    ],
    'Identité visuelle': [
      'Logo Design',
      'Brand Guidelines',
      'Typography',
      'Color Theory',
      'Visual Branding',
    ],
    'Prototypage interactif': [
      'InVision',
      'Marvel App',
      'Proto.io',
      'Framer',
      'Axure',
    ],

    // Data et Intelligence Artificielle
    'Science des données': ['Python', 'R', 'Pandas', 'NumPy', 'Jupyter', 'SQL'],
    'Analyse de données': [
      'Excel',
      'Tableau',
      'Power BI',
      'Google Analytics',
      'Data Visualization',
    ],
    'Machine Learning': [
      'TensorFlow',
      'Scikit-learn',
      'Keras',
      'PyTorch',
      'XGBoost',
    ],
    'Deep Learning': ['CNN', 'RNN', 'LSTM', 'GANs', 'Autoencoders'],
    'Big Data': ['Hadoop', 'Spark', 'Kafka', 'Flink', 'NoSQL'],

    // Cybersécurité
    'Pentesting': [
      'Metasploit',
      'Nmap',
      'Burp Suite',
      'Wireshark',
      'Kali Linux',
    ],
    'Analyse forensique': [
      'EnCase',
      'FTK',
      'Autopsy',
      'Volatility',
      'Sleuth Kit',
    ],
    'Sécurité réseau': ['Firewall', 'VPN', 'IDS/IPS', 'Wireshark', 'SSL/TLS'],
    'Cryptographie': ['AES', 'RSA', 'Hashing', 'PGP', 'TLS/SSL'],
    'Sécurité applicative': [
      'OWASP',
      'Code Review',
      'Secure Coding',
      'Static Analysis',
      'Dynamic Analysis',
    ],

    // Administration Systèmes et Réseaux
    'Administration systèmes Linux': [
      'Bash',
      'Shell scripting',
      'Systemd',
      'Cron',
      'Networking Linux',
    ],
    'Administration Windows Server': [
      'Active Directory',
      'PowerShell',
      'Group Policy',
      'DNS',
      'DHCP',
    ],
    'Virtualisation (VMware, Proxmox)': [
      'VMware vSphere',
      'Proxmox VE',
      'VirtualBox',
      'Hyper-V',
    ],
    'Réseaux informatiques': [
      'TCP/IP',
      'Subnetting',
      'Routing',
      'Switching',
      'Wireshark',
    ],
    'Supervision et monitoring': [
      'Nagios',
      'Zabbix',
      'Prometheus',
      'Grafana',
      'ELK Stack',
    ],

    // Marketing Digital et SEO
    'Rédaction web': [
      'Copywriting',
      'Content Marketing',
      'Blogging',
      'Storytelling',
      'SEO Writing',
    ],
    'Référencement SEO': [
      'On-Page SEO',
      'Off-Page SEO',
      'Google Search Console',
      'Keyword Research',
      'Backlinks',
    ],
    'Publicité en ligne (Google Ads, Facebook Ads)': [
      'Google Ads',
      'Facebook Ads',
      'Instagram Ads',
      'PPC',
      'Campaign Management',
    ],
    'Email marketing': [
      'Mailchimp',
      'Sendinblue',
      'A/B Testing',
      'Segmentation',
      'Automation',
    ],
    'Stratégie digitale': [
      'Social Media Strategy',
      'Content Strategy',
      'Analytics',
      'Growth Hacking',
    ],

    // Gestion de Projet et Agilité
    'Scrum': [
      'Sprint Planning',
      'Daily Standup',
      'Sprint Review',
      'Retrospective',
      'Product Backlog',
    ],
    'Product Owner': [
      'User Stories',
      'Backlog Grooming',
      'Stakeholder Management',
      'Prioritization',
    ],
    'Gestion de projet agile': [
      'Kanban',
      'Lean',
      'Agile Metrics',
      'Burndown Chart',
    ],
    'Conduite de projet': [
      'Planning',
      'Risk Management',
      'Budgeting',
      'Communication',
    ],
    'Outils de gestion (Jira, Trello)': [
      'Jira',
      'Trello',
      'Asana',
      'Microsoft Project',
      'Monday.com',
    ],

    // DevOps et Cloud
    'CI/CD': ['Jenkins', 'GitLab CI', 'CircleCI', 'Travis CI', 'Azure DevOps'],
    'Infrastructure as Code': ['Terraform', 'Ansible', 'Puppet', 'Chef'],
    'Cloud (AWS, Azure, GCP)': [
      'AWS EC2',
      'Azure Functions',
      'Google Cloud Storage',
      'AWS S3',
      'Azure DevOps',
    ],
    'Conteneurisation (Docker)': ['Docker', 'Docker Compose', 'Docker Swarm'],
    'Orchestration (Kubernetes)': [
      'Kubernetes',
      'Helm',
      'Kubectl',
      'OpenShift',
    ],
  };

  // Récupère toutes les skills disponibles dans la map (sans doublons)
  List<String> getAllSkills() {
    final allSkillsSet = <String>{};
    for (var skillsList in skillSuggestions.values) {
      allSkillsSet.addAll(skillsList);
    }
    return allSkillsSet.toList();
  }

  // Récupère les suggestions basées sur les sous-domaines sélectionnés
  List<String> getSuggestionsFromSubDomains(
    Map<String, List<String>> selectedSubDomains,
  ) {
    final Set<String> suggestions = {};
    // On récupère les sous-domaines choisis
    final selectedSubDomainsList = selectedSubDomains.values.expand(
      (subList) => subList,
    );
    for (var subDomain in selectedSubDomainsList) {
      if (skillSuggestions.containsKey(subDomain)) {
        suggestions.addAll(skillSuggestions[subDomain]!);
      }
    }
    return suggestions.toList();
  }


  //Fonction de validation
  void onSubmitted(){
    if(_tempSelectedSkills.isEmpty){
      AppSnackBar.show(context, "Aucune compétence sélectionnée");
    }
    else{
      context.read<SkillSelectionProvider>().setSkills(_tempSelectedSkills);
      Navigator.pushNamed(context, AppRoutes.SKILLSSELECTIONPAGE);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Map des domaines et sous domaines déjà selectionnés par le talent
    final subDomainSelections = context.watch<SubDomainSelectionProvider>().selectedSubDomains;

    final searchText = _searchController.text.trim().toLowerCase();

    // Si y'a du texte dans la recherche -> on affiche la recherche globale filtrée
    // Sinon on affiche juste les suggestions liées aux sous-domaines sélectionnés

    final List<String> displayedSkills =
        searchText.isEmpty
            ? getSuggestionsFromSubDomains(
              subDomainSelections,
            ).where((skill) => !_tempSelectedSkills.contains(skill)).toList()
            : getAllSkills()
                .where(
                  (skill) =>
                      skill.toLowerCase().contains(searchText) &&
                      !_tempSelectedSkills.contains(skill),
                ) // exclure ceux déjà choisis
                .toList();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: context.screenHeight * 0.05,
        leadingWidth: context.screenHeight * 0.075,
        centerTitle: true,
        title: AppText(
          text: "Créez votre profil",
          fontWeight: FontWeight.bold,
          fontSize: context.largeText * 0.9,
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: context.defaultPagePadding),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.greyColor,
              borderRadius: BorderRadius.circular(context.screenHeight * 0.03),
            ),
            child: Icon(
              Icons.person,
              size: context.screenHeight * 0.038,
              color: AppColors.blackColor,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(context.defaultPagePadding),
        child: Column(
          children: [
            //Intro
            AppText(
              text: "Ajoutez les compétences que vous maîtrises vraiment.",
              fontWeight: FontWeight.bold,
              fontSize: context.largeText * 0.9,
              textAlign: TextAlign.center,
              color: AppColors.blueColor,
            ),
            SizedBox(height: context.defaultSpacing,),

            // Champ de recherche : déclenche le setState pour rafraîchir la liste au fur et à mesure
            AppTextField(
              keyboardType: TextInputType.text,
              controller: _searchController,
              labelText: 'Rechercher une compétence',
              onChanged: (value) => setState(() {}),
            ),
            SizedBox(height: context.defaultSpacing),

            AppText(
              text: "Suggestions",
              fontWeight: FontWeight.bold,
              color: AppColors.blueColor,
            ),
            SizedBox(height: context.defaultSpacing),

            // Liste des compétences affichées (suggestions ou résultats recherche)
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: context.tenPixel * 0.8,
                  runSpacing: context.tenPixel * 0.8,
                  children:
                      displayedSkills.map((skill) {
                        return Hero(
                          tag: skill,
                          transitionOnUserGestures: true,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _tempSelectedSkills.add(skill);
                                AppSnackBar.show(context, "Compétence $skill ajouter avec succès");
                              });
                            },
                            child: Card(
                              elevation: 3,
                              color: AppColors.whiteColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  context.tenPixel * 1.2,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: context.tenPixel * 0.8,
                                  horizontal: context.tenPixel * 1.6,
                                ),
                                child: AppText(
                                  text: skill,
                                  fontWeight: FontWeight.w600,
                                  fontSize: context.smallText,
                                  color: AppColors.blackColor,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ),
            ),
            SizedBox(height: context.defaultSpacing),

            if(_tempSelectedSkills.isNotEmpty)
              AppText(
                text: "Compétences choisie(s)",
                fontWeight: FontWeight.bold,
                color: AppColors.blueColor,
              ),
              SizedBox(height: context.defaultSpacing,),

            // Affichage des skills sélectionnés sous forme de chips
            SizedBox(
              height: context.screenHeight * 0.2,
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: context.tenPixel,
                  runSpacing: context.tenPixel * 0.8,
                  children:
                      _tempSelectedSkills
                          .map(
                            (skill) => Hero(
                              tag: skill,
                              transitionOnUserGestures: true,
                              child: Chip(
                                backgroundColor: AppColors.blueColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    context.tenPixel * 1.2,
                                  ),
                                  side: BorderSide(
                                    color: AppColors.blueColor,
                                    width: context.tenPixel * 0.2,
                                  ),
                                ),
                                deleteButtonTooltipMessage: "Supprimer",
                                label: AppText(
                                  text: skill,
                                  fontSize: context.smallText * 1.1,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.blackColor,
                                ),
                                onDeleted: () {
                                  setState(() {
                                    _tempSelectedSkills.remove(skill);
                                    AppSnackBar.show(context, "Compétence $skill supprimer avec succès");
                                  });
                                },
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
            ),
            SizedBox(height: context.defaultSpacing),

            // Bouton pour valider et enregistrer les skills dans le provider
            /*ElevatedButton(
              onPressed: () {
                skillProvider.setSkills(_tempSelectedSkills);
                Navigator.pop(context);
              },
              child: const Text("Enregistrer les compétences"),
            ),*/
          ],
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
