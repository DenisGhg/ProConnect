import 'package:flutter/material.dart';
import 'package:pro_connect_projet/constants/routes.dart';
import 'package:pro_connect_projet/providers/register_providers/talent_providers/subdomain_selection_provider.dart';
import 'package:pro_connect_projet/providers/register_providers/talent_providers/talent_bio_provider.dart';
import 'package:pro_connect_projet/providers/register_providers/talent_providers/talent_education_provider.dart';
import 'package:pro_connect_projet/providers/register_providers/talent_providers/talent_experience_provider.dart';
import 'package:pro_connect_projet/providers/register_providers/talent_providers/talent_personal_info_provider.dart';
import 'package:pro_connect_projet/providers/register_providers/talent_providers/talent_title_pro_provider.dart';
import 'package:pro_connect_projet/views/sizes/app_sizes.dart';
import 'package:pro_connect_projet/views/sizes/text_sizes.dart';
import 'package:pro_connect_projet/widgets/app_text.dart';
import 'package:provider/provider.dart';

import '../../../../providers/auth_providers/sign_up_provider.dart';
import '../../../../widgets/app_button.dart';
import '../../../colors/app_colors.dart';


class TalentRecapPage extends StatelessWidget {
  const TalentRecapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final signUp = Provider.of<SignUpProvider>(context);
    final personalInfo = Provider.of<TalentPersonalInfoProvider>(context);
    final titlePro = Provider.of<TalentTitleProProvider>(context);
    final bio = Provider.of<TalentBioProvider>(context);
    final subdomains = Provider.of<SubDomainSelectionProvider>(context);
    final experiences = Provider.of<TalentExperienceProvider>(context);
    final educations = Provider.of<TalentEducationProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Récapitulatif du profil')),
      body: ListView(
        padding: EdgeInsets.all(context.defaultPagePadding),
        children: [
          _section(
            context: context,
            title: 'Infos de base',
            onEdit: ()=> Navigator.pushNamed(context, AppRoutes.SIGNUPPAGE),
            children: [
              _infoRow('Prénom', signUp.firstName, context,),
              _infoRow('Nom', signUp.lastName, context),
              _infoRow('Email', signUp.email, context),
            ],
          ),
          _section(
            context: context,
            title: 'Informations personnelles',
            onEdit: ()=> Navigator.pushNamed(context, AppRoutes.TALENTPERSONALINFOPAGE),
            children: [
              _infoRow('Pays', personalInfo.country ?? '', context),
              _infoRow('Ville', personalInfo.city ?? '', context),
              _infoRow('Téléphone', personalInfo.phoneNumber ?? '', context),
              _infoRow('Date de naissance', personalInfo.dateOfBirth ?? '', context),
            ],
          ),
          _section(
            context: context,
            title: 'Domaine & sous-domaines',
            onEdit: ()=> Navigator.pushNamed(context, AppRoutes.SUBDOMAINSELECTIONPAGE),
            children: subdomains.selectedSubDomains.entries.map((entry) {
              return _infoRow(entry.key, entry.value.join(', '), context);
            }).toList(),
          ),
          _section(
            context: context,
            title: 'Titre professionnel',
            onEdit: ()=> Navigator.pushNamed(context, AppRoutes.TALENTTITLEPROPAGE),
            children: [
              _infoRow('Titre', titlePro.proTitle ?? '', context),
            ],
          ),
          _section(
            context: context,
            title: 'Bio',
            onEdit: ()=> Navigator.pushNamed(context, AppRoutes.TALENTBIOPAGE),
            children: [
              _infoRow('À propos de vous', bio.bio ?? '', context),
            ],
          ),
          _section(
            context: context,
            title: 'Expériences',
            onEdit: ()=> Navigator.pushNamed(context, AppRoutes.EXPERIENCESSELECTIONPAGE),
            children: experiences.experiences.isEmpty
              ? [AppText(text: "Aucune expérience ajoutée")]
              : experiences.experiences.map((exp) {
              return _infoRow(exp.title, '${exp.company} • ${exp.startDate} ans', context);
            }).toList(),
          ),
          _section(
            context: context,
            title: 'Éducation',
            onEdit: ()=> Navigator.pushNamed(context, AppRoutes.EDUCATIONSSELECTIONPAGE),
            children: educations.educations.isEmpty
                ? [AppText(text: "Aucune education ajoutée")]
                : educations.educations.map((edu) {
              return _infoRow(edu.title, '${edu.company} • ${edu.startDate}', context);
            }).toList(),
          ),

          SizedBox(height: context.defaultSpacing,),

          AppButton(
            onTap: () => Navigator.pushNamed(context, AppRoutes.TALENTHOMEPAGE),
            child: AppText(text: 'Soumettre le profil'),
          )
        ],
      ),
    );
  }

  Widget _section({
    required String title,
    required List<Widget> children,
    required BuildContext context,
    VoidCallback? onEdit,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(text: title, fontWeight: FontWeight.bold, fontSize: context.mediumText * 1.2,),
                if (onEdit != null)
                  IconButton(
                    onPressed: onEdit,
                    icon: Icon(Icons.edit, color: AppColors.greenColor,),
                  ),
              ],
            ),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value, BuildContext context,) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(text: '$label: ', fontWeight: FontWeight.bold,),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
