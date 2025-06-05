import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pro_connect_projet/views/sizes/app_sizes.dart';
import 'package:pro_connect_projet/views/sizes/text_sizes.dart';
import 'package:pro_connect_projet/widgets/app_text.dart';

import '../../../models/register/talent/profile.dart';


class TalentProfilePage extends StatefulWidget {
  const TalentProfilePage({super.key});

  @override
  State<TalentProfilePage> createState() => _TalentProfilePageState();
}

class _TalentProfilePageState extends State<TalentProfilePage> {
  TalentProfile? profil;

  // Chargement simulé du profil depuis un JSON local
  Future<void> loadProfile() async {
    final String response = await rootBundle.loadString('asserts/jsons/profiles.json');
    final List<dynamic> data = json.decode(response);
    setState(() {
      profil = TalentProfile.fromJson(data[35]); // Simule profil connecté
    });
  }

  // Convertit une date au format "yyyy-MM-dd" en "MMM yyyy" (ex: 2021-01-01 => Jan 2021)
  String _formatDate(DateTime date) {
    // Formatage simple, genre "Jan 2021"
    return "${_monthToString(date.month)} ${date.year}";
  }

  // Transforme le numéro du mois en nom abrégé en français (ou anglais si tu préfères)
  String _monthToString(int month) {
    const months = [
      'Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Juin',
      'Juil', 'Aoû', 'Sep', 'Oct', 'Nov', 'Déc'
    ];
    return months[month - 1];
  }

  //Fonction pour agrandir l'image de profil au clic
  void _showFullScreenAvatar(String imageUrl) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black, // fond noir stylé
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // annule les arrondis
      ),
      builder: (context) {
        return SizedBox(
          height: context.screenHeight,
          width: context.screenWidth,
          child: Padding(
            padding: EdgeInsets.all(context.defaultPagePadding),
            child: Column(
              children: [
                //Titre
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(text: "Photo de profil", fontWeight: FontWeight.bold, fontSize: context.largeText * 0.8,),
                    IconButton(
                      onPressed: ()=> Navigator.pop(context),
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
                //Image agrandie
                Expanded(
                  child: Center(
                    child: CircleAvatar(
                      radius: context.screenWidth / 2.5,
                      backgroundImage: NetworkImage(imageUrl),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    if (profil == null) {
      // Affichage d'un indicateur de chargement si le profil n'est pas encore dispo
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Profil du Talent")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(context.defaultPagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Header (Photo + Nom + Titre)
            _buildHeader(),
            SizedBox(height: context.defaultSpacing),

            // Section Bio
            ProfileSectionCard(
              icon: Icons.info_outline,
              title: "Bio",
              actionIcon: profil!.bio.isNotEmpty ? Icons.edit : Icons.add,
              child: Text(
                profil!.bio.isNotEmpty ? profil!.bio : "Aucune bio renseignée",
                style: const TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: context.defaultSpacing),

            // Section Domaines
            ProfileSectionCard(
              icon: Icons.dashboard_customize_outlined,
              title: "Domaines",
              actionIcon: profil!.domains.isEmpty ? Icons.add : null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: profil!.domains.entries.map((entry) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(entry.key),
                    subtitle: Text(entry.value.join(", ")),
                    leading: const Icon(Icons.category_outlined),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: context.defaultSpacing),

            // Section Compétences
            ProfileSectionCard(
              icon: Icons.star_border,
              title: "Compétences",
              actionIcon: Icons.add,
              child: Wrap(
                spacing: 8,
                children: profil!.skills.map((skill) {
                  return Chip(
                    label: Text(skill),
                    deleteIcon: const Icon(Icons.close),
                    onDeleted: () {}, // Suppression à gérer plus tard
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: context.defaultSpacing),

            // Section Expériences
            ProfileSectionCard(
              icon: Icons.work_outline,
              title: "Expériences",
              actionIcon: Icons.add,
              child: Column(
                children: profil!.experiences.map((exp) {
                  // Formatage des dates
                  String start = _formatDate(exp.startDate);
                  String end = exp.endDate != null ? _formatDate(exp.endDate!) : (exp.isCurrent ? "Présent" : "");
                  String dateRange = end.isNotEmpty ? "$start - $end" : start;

                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(exp.company),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(dateRange, style: const TextStyle(fontWeight: FontWeight.w600)),
                        if (exp.title.isNotEmpty) Text(exp.title),
                      ],
                    ),
                    leading: const Icon(Icons.business_center_outlined),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: context.defaultSpacing),

            // Section Éducation
            ProfileSectionCard(
              icon: Icons.school_outlined,
              title: "Éducation",
              actionIcon: Icons.add,
              child: Column(
                children: profil!.educations.map((edu) {
                  // Formatage des dates
                  String start = _formatDate(edu.startDate);
                  String end = edu.endDate != null ? _formatDate(edu.endDate!) : (edu.isCurrent ? "Présent" : "");
                  String dateRange = end.isNotEmpty ? "$start - $end" : start;

                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(edu.company),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(dateRange, style: const TextStyle(fontWeight: FontWeight.w600)),
                        if (edu.title.isNotEmpty) Text(edu.title),
                      ],
                    ),
                    leading: const Icon(Icons.school),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: context.defaultSpacing),

            // Section Langues
            ProfileSectionCard(
              icon: Icons.language_outlined,
              title: "Langues",
              actionIcon: Icons.add,
              child: Column(
                children: (profil!.languages ?? []).map((lang) => _buildLanguageRow(
                  lang['language'] ?? 'Langue inconnue',
                  lang['level'] ?? 'Niveau inconnu',
                )).toList(),

              ),
            ),

          ],
        ),
      ),
    );
  }

  // Header du profil : Avatar + Nom + Titre professionnel
  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => _showFullScreenAvatar(profil!.avatar),
          child: Stack(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(profil!.avatar),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.edit, size: 16),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${profil!.firstName} ${profil!.lastName}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(profil!.title, style: const TextStyle(color: Colors.grey)),
          ],
        )
      ],
    );
  }

  // Ligne pour une langue : nom + niveau + actions
  Widget _buildLanguageRow(String language, String level) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$language - $level"),
          Row(
            children: const [
              Icon(Icons.edit, size: 18),
              SizedBox(width: 8),
              Icon(Icons.delete_outline, size: 18),
            ],
          )
        ],
      ),
    );
  }
}

// Widget générique pour afficher une section du profil (titre, icône, action, contenu)
class ProfileSectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;
  final IconData? actionIcon;

  const ProfileSectionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.child,
    this.actionIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon),
                    const SizedBox(width: 8),
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                if (actionIcon != null) Icon(actionIcon!),
              ],
            ),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}


