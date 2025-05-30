import 'package:flutter/material.dart';
import 'package:pro_connect_projet/constants/routes.dart';
import 'package:pro_connect_projet/views/colors/app_colors.dart';
import 'package:pro_connect_projet/views/sizes/app_sizes.dart';
import 'package:pro_connect_projet/views/sizes/text_sizes.dart';
import 'package:pro_connect_projet/widgets/app_button.dart';
import 'package:provider/provider.dart';

import '../../../../models/register/talent/education.dart';
import '../../../../providers/register_providers/talent_providers/talent_education_provider.dart';
import '../../../../widgets/app_text.dart';


// Page pour ajouter ou modifier les formations
class EducationsSelectionPage extends StatefulWidget {
  const EducationsSelectionPage({super.key});

  @override
  State<EducationsSelectionPage> createState() => _EducationsSelectionPageState();
}

class _EducationsSelectionPageState extends State<EducationsSelectionPage> {
  List<Education> educations = [];
  int? editingIndex;

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _companyController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;
  bool _isCurrent = false;

  void _showExperienceForm([int? indexToEdit]) {
    if (indexToEdit != null) {
      final edu = educations[indexToEdit];
      _titleController.text = edu.title;
      _companyController.text = edu.company;
      _descriptionController.text = edu.description;
      _startDate = edu.startDate;
      _endDate = edu.endDate;
      _isCurrent = edu.isCurrent;
      editingIndex = indexToEdit;
    } else {
      _titleController.clear();
      _companyController.clear();
      _descriptionController.clear();
      _startDate = null;
      _endDate = null;
      _isCurrent = false;
      editingIndex = null;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Padding(
              padding: EdgeInsets.all(context.defaultPagePadding),
              child: Form(
                key: _formKey,
                child: Wrap(
                  children : [
                    AppText(
                      text: editingIndex != null
                          ? 'Modifier une formation'
                          : 'Ajouter une formation',
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: context.defaultSpacing),

                    // Champ : Intitulé du diplôme
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(labelText: 'Diplôme ou formation'),
                      validator: (value) => value!.isEmpty ? 'Champ requis' : null,
                    ),

                    // Champ : École
                    TextFormField(
                      controller: _companyController,
                      decoration: InputDecoration(labelText: 'Établissement'),
                      validator: (value) => value!.isEmpty ? 'Champ requis' : null,
                    ),

                    // Champ : Description / Spécialité
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(labelText: 'Spécialité / Détails'),
                      maxLines: 3,
                    ),

                    SizedBox(height: context.defaultSpacing * 2),

                    // Date de début
                    Row(
                      children: [
                        Expanded(
                          child: AppText(
                            text: _startDate == null
                                ? 'Date de début'
                                : 'Début : ${_startDate!.toLocal().toString().split(' ')[0]}',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => _pickDate(isStartDate: true),
                          child: AppText(text: 'Choisir'),
                        ),
                      ],
                    ),

                    // Date de fin (si non en cours)
                    Row(
                      children: [
                        Expanded(
                          child: _isCurrent
                              ? AppText(text: 'Formation en cours')
                              : AppText(
                            text: _endDate == null
                                ? 'Date de fin'
                                : 'Fin : ${_endDate!.toLocal().toString().split(' ')[0]}',
                          ),
                        ),
                        if (!_isCurrent)
                          ElevatedButton(
                            onPressed: () => _pickDate(isStartDate: false),
                            child: AppText(text: 'Choisir'),
                          ),
                      ],
                    ),

                    // Case à cocher : Formation en cours
                    CheckboxListTile(
                      value: _isCurrent,
                      onChanged: (val) {
                        setModalState(() => _isCurrent = val!);
                      },
                      title: AppText(text: "Formation en cours"),
                    ),

                    // Boutons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppButton(
                          width: context.screenWidth * 0.25,
                          backgroundColor: Colors.transparent,
                          onTap: () => Navigator.pop(context),
                          child: AppText(
                            text: "Annuler",
                            fontWeight: FontWeight.bold,
                            color: AppColors.greyColor,
                          ),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _submitEducation,
                          child: AppText(text: editingIndex != null ? 'Modifier' : 'Ajouter'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _pickDate({required bool isStartDate}) async {
    final now = DateTime.now();
    final initialDate = isStartDate ? (_startDate ?? now) : (_endDate ?? now);

    final date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      setState(() {
        if (isStartDate) {
          _startDate = date;
        } else {
          _endDate = date;
        }
      });
    }
  }

  void _submitEducation() {
    if (_formKey.currentState!.validate() && _startDate != null) {
      final newEdu = Education(
        title: _titleController.text,
        company: _companyController.text,
        description: _descriptionController.text,
        startDate: _startDate!,
        endDate: _isCurrent ? null : _endDate,
        isCurrent: _isCurrent,
      );

      setState(() {
        if (editingIndex != null) {
          educations[editingIndex!] = newEdu;
        } else {
          educations.add(newEdu);
        }
      });

      Navigator.pop(context);
    }
  }

  void _deleteEducation(int index) {
    setState(() => educations.removeAt(index));
  }

  //Enregistrement et routage
  void _onSubmitted(){
    final provider = Provider.of<TalentEducationProvider>(context, listen: false);
    provider.setEducations(educations);
    Navigator.pushNamed(context, AppRoutes.LANGUAGESSELECTIONPAGE);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: context.screenHeight * 0.05,
        leadingWidth: context.screenHeight * 0.075,
        centerTitle: true,
        title: AppText(
          text: "Créez votre Profil",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(context.defaultPagePadding),
          child: Column(
            children: [
              SizedBox(height: context.defaultSpacing * 4,),
              AppText(
                text: "Ajoutez vos formations académiques",
                fontWeight: FontWeight.bold,
                fontSize: context.largeText * 0.9,
                textAlign: TextAlign.center,
                color: AppColors.blueColor,
              ),

              SizedBox(height: context.defaultSpacing * 2,),
              AppText(
                text: "Renseignez les diplômes ou formations que vous avez suivis, les établissements, les périodes et les spécialités. Ces informations permettent aux recruteurs de mieux comprendre votre parcours académique.",
                textAlign: TextAlign.justify,
                fontWeight: FontWeight.bold,
              ),

              SizedBox(height: context.defaultSpacing * 4,),
              // Bouton pour ouvrir le formulaire d'ajout de formation
              AppButton(
                onTap: () => _showExperienceForm(), // Utilise la méthode d'affichage de formulaire existante
                width: context.screenWidth * 0.6,
                padding: EdgeInsets.zero,
                height: context.screenHeight * 0.05,
                radius: context.screenWidth * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add),
                    AppText(text: "Ajouter une formation")
                  ],
                ),
              ),
              SizedBox(height: context.defaultSpacing * 4),

              // Liste des formations ajoutées
              educations.isEmpty
                  ? Center(child: AppText(text: "Aucune formation ajoutée."))
                  : ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: educations.length,
                itemBuilder: (_, index) {
                  final edu = educations[index];
                  return Card(
                    margin: EdgeInsets.only(bottom: context.defaultPagePadding * 0.9),
                    child: ListTile(
                      title: AppText(text: edu.title),
                      subtitle: AppText(
                        text: "${edu.company}\n"
                            "${edu.description}\n"
                            "${edu.startDate.toLocal().toString().split(' ')[0]}"
                            "${edu.isCurrent ? ' - Présent' : ' - ${edu.endDate?.toLocal().toString().split(' ')[0] ?? ''}'}",
                      ),
                      isThreeLine: true,
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Bouton modifier
                          IconButton(
                            icon: Icon(Icons.edit, color: AppColors.orangeColor),
                            onPressed: () => _showExperienceForm(index), // Reutilise la même fonction pour modifier
                          ),
                          // Bouton supprimer
                          IconButton(
                            icon: Icon(Icons.delete, color: AppColors.redColor),
                            onPressed: () => _deleteEducation(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
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
                ),
              ),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  size: context.screenHeight * 0.03,
                  color: AppColors.blueColor,
                ),
              ),
            ),
            // Suivant
            AppButton(
              onTap: _onSubmitted,
              width: context.screenWidth * 0.4,
              child: AppText(text: "Suivant"),
            ),
          ],
        ),
      ),
    );
  }

}
