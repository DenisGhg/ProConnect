import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pro_connect_projet/views/sizes/app_sizes.dart';
import 'package:pro_connect_projet/views/sizes/text_sizes.dart';
import 'package:pro_connect_projet/widgets/app_snackbar.dart';
import 'package:pro_connect_projet/widgets/app_text.dart';

import '../../../models/register/talent/profile.dart';
import '../../colors/app_colors.dart';


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

  //Variable pour gérer "Voir plus" ou "voir moins" de la bio
  bool isExpanded = false;
  bool isEditingBio = false;

  // Pour similer l'affichage de la modification de la bio
  String? editedBio;

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

  //Fonction pour modifier la bio
  void _showEditBioBottomSheet(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: profil!.bio);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Modifier la bio",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: controller,
              maxLines: 5,
              minLines: 3,
              decoration: const InputDecoration(
                hintText: "Entrez votre nouvelle bio...",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text("Annuler"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  child: const Text("Modifier"),
                  onPressed: () {
                    final newBio = controller.text.trim();

                    if (newBio.length < 100) {
                      AppSnackBar.show(context, "La bio doit contenir au moins 100 caractères");
                    } else {
                      setState(() {
                        editedBio = newBio;  // 🔥 maintenant dans setState
                        isExpanded = false;
                      });

                      Navigator.of(context).pop();
                      AppSnackBar.show(context, "Bio modifiée avec succès");
                    }
                  },

                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    // Pour similer l'affichage de la modification de la bio
    final String bioToDisplay = editedBio ?? profil!.bio;

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
              actionIcon: bioToDisplay.isNotEmpty ? Icons.edit : Icons.add,
              onPressed: ()=> _showEditBioBottomSheet(context),
              child: Column(
                children: [
                  AppText(
                    text: bioToDisplay.isEmpty
                        ? 'Aucune bio entrée.'
                        : isExpanded || bioToDisplay.length <= 100
                        ? bioToDisplay
                        : '${bioToDisplay.substring(0, 100)}...',
                    fontSize: context.mediumText * 0.8,
                  ),

                  //Bouton voir  plus voir moins
                  if (bioToDisplay.length > 100 && bioToDisplay.isNotEmpty)
                    TextButton(
                      onPressed: () => setState(() => isExpanded = !isExpanded),
                      child: AppText(text: isExpanded ? "Voir moins" : "Voir plus", fontSize: context.smallText * 1.2,),
                    ),
                ],
              ),
            ),
            SizedBox(height: context.defaultSpacing),

            // Section Domaines
            ProfileSectionCard(
              icon: Icons.dashboard_customize_outlined,
              title: "Domaines",
              actionIcon: Icons.add,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: profil!.domains.entries.map((entry) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: AppText(text: entry.key, fontSize: context.mediumText * 0.9, fontWeight: FontWeight.bold,),
                    subtitle: AppText(text: entry.value.join(", "), fontSize: context.mediumText * 0.75,),
                    leading: Icon(Icons.category_outlined, color: AppColors.blueColor,),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.edit, size: context.referenceSize * 1.5, color: AppColors.blueColor,),
                        SizedBox(width: context.referenceSize * 0.8),
                        Icon(Icons.delete_outline,  size: context.referenceSize * 1.5, color: AppColors.redColor,),
                      ],
                    ),
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
                spacing: context.referenceSize,
                runSpacing: context.referenceSize * 0.8,
                children: profil!.skills.map((skill) {
                  return Chip(

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        context.referenceSize * 1.2,
                      ),
                      side: BorderSide(
                        color: AppColors.blueColor,
                        width: context.referenceSize * 0.2,
                      ),
                    ),
                    deleteButtonTooltipMessage: "Supprimer",
                    label: AppText(
                      text: skill,
                      fontSize: context.smallText * 1.1,
                      fontWeight: FontWeight.w600,

                    ),
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
                    title: AppText(text: exp.company, fontSize: context.mediumText * 0.9,),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(text: dateRange, fontWeight: FontWeight.bold, fontSize: context.mediumText * 0.8,),
                        if (exp.title.isNotEmpty) AppText(text: exp.title, fontSize: context.mediumText * 0.75,),
                      ],
                    ),
                    leading: Icon(Icons.school, color: AppColors.blueColor,),
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
                    title: AppText(text: edu.company, fontSize: context.mediumText * 0.9,),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(text: dateRange, fontWeight: FontWeight.bold, fontSize: context.mediumText * 0.8,),
                        if (edu.title.isNotEmpty) AppText(text: edu.title, fontSize: context.mediumText * 0.75,),
                      ],
                    ),
                    leading: Icon(Icons.school, color: AppColors.blueColor,),
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
                radius: context.referenceSize * 4,
                backgroundImage: NetworkImage(profil!.avatar),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  height: context.referenceSize * 3.5,
                  width: context.referenceSize * 3.5,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.blueColor,
                      width: context.referenceSize * 0.2
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.camera_alt, size: context.referenceSize * 1.5, color: AppColors.blueColor,),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: context.defaultSpacing),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(text: "${profil!.firstName} ${profil!.lastName}", fontWeight: FontWeight.bold,),
            AppText(text: profil!.title, color: AppColors.greyColor, fontSize: context.mediumText * 0.9,),
          ],
        )
      ],
    );
  }

  // Ligne pour une langue : nom + niveau + actions
  Widget _buildLanguageRow(String language, String level) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.referenceSize * 0.4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$language - $level"),
          Row(
            children: [
              Icon(Icons.edit, size: context.referenceSize * 1.5, color: AppColors.blueColor,),
              SizedBox(width: context.referenceSize * 0.8),
              Icon(Icons.delete_outline,  size: context.referenceSize * 1.5, color: AppColors.redColor,),
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
  final Function()? onPressed;

  const ProfileSectionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.child,
    this.actionIcon,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(context.defaultPagePadding * 0.8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, color: AppColors.blueColor,),
                    SizedBox(width: context.referenceSize * 0.8),
                    AppText(text: title, fontWeight: FontWeight.bold, color: AppColors.blueColor,),
                  ],
                ),
                if (actionIcon != null)
                  Container(
                    height: context.referenceSize * 3.5,
                    width: context.referenceSize * 3.5,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.blueColor,
                        width: context.referenceSize * 0.2,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(actionIcon!, size: context.referenceSize * 1.5, color: AppColors.blueColor,),
                      onPressed: onPressed,
                    ),
                  ),
              ],
            ),
            SizedBox(height: context.defaultSpacing * 0.5),
            child,
          ],
        ),
      ),
    );
  }
}


