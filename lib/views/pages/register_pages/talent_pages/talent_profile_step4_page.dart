import 'package:flutter/material.dart';
import 'package:pro_connect_projet/views/colors/app_colors.dart';
import 'package:pro_connect_projet/views/sizes/app_sizes.dart';
import 'package:pro_connect_projet/views/sizes/text_sizes.dart';
import 'package:pro_connect_projet/widgets/app_button.dart';

import '../../../../models/register/talent/experience.dart';
import '../../../../widgets/app_text.dart';

// Page principale pour ajouter et afficher les expériences
class TalentProfileStep4Page extends StatefulWidget {
  const TalentProfileStep4Page({super.key});

  @override
  State<TalentProfileStep4Page> createState() => _TalentProfileStep4PageState();
}

class _TalentProfileStep4PageState extends State<TalentProfileStep4Page> {
  List<Experience> experiences = []; // Liste des expériences ajoutées
  int? editingIndex; // Index utilisé lorsqu'on modifie une expérience

  // Clé du formulaire et controllers pour les champs
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _companyController = TextEditingController();
  final _descriptionController = TextEditingController();

  // Variables pour les dates
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isCurrent = false; // True si le poste est actuel

  // Ouvre le bottom sheet pour ajouter ou modifier une expérience
  void _showExperienceForm([int? indexToEdit]) {
    if (indexToEdit != null) {
      // Pré-remplir les champs si on modifie
      final exp = experiences[indexToEdit];
      _titleController.text = exp.title;
      _companyController.text = exp.company;
      _descriptionController.text = exp.description;
      _startDate = exp.startDate;
      _endDate = exp.endDate;
      _isCurrent = exp.isCurrent;
      editingIndex = indexToEdit;
    } else {
      // Nettoyer les champs si on ajoute une nouvelle expérience
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
                  children: [
                    AppText(
                      text : editingIndex != null ? 'Modifier une expérience' : 'Ajouter une expérience',
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: context.defaultSpacing,),

                    // Champ : Titre du poste
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(labelText: 'Titre du poste'),
                      validator: (value) => value!.isEmpty ? 'Champ requis' : null,
                    ),

                    // Champ : Entreprise
                    TextFormField(
                      controller: _companyController,
                      decoration: InputDecoration(labelText: 'Entreprise'),
                      validator: (value) => value!.isEmpty ? 'Champ requis' : null,
                    ),

                    // Champ : Description
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                    ),

                    SizedBox(height: context.defaultSpacing * 2),

                    // Sélection de la date de début
                    Row(
                      children: [
                        Expanded(
                          child: AppText(
                            text : _startDate == null
                              ? 'Date de début'
                              : 'Début : ${_startDate!.toLocal().toString().split(' ')[0]}'),
                        ),
                        ElevatedButton(
                          onPressed: () => _pickDate(isStartDate: true),
                          child: AppText(text :'Choisir'),
                        ),
                      ],
                    ),

                    // Sélection de la date de fin (si ce n’est pas un poste actuel)
                    Row(
                      children: [
                        Expanded(
                          child: _isCurrent
                              ? AppText(text : 'Poste actuel')
                              : AppText(text : _endDate == null
                              ? 'Date de fin'
                              : 'Fin : ${_endDate!.toLocal().toString().split(' ')[0]}'),
                        ),
                        if (!_isCurrent)
                          ElevatedButton(
                            onPressed: () => _pickDate(isStartDate: false),
                            child: AppText(text :'Choisir'),
                          ),
                      ],
                    ),

                    // Case à cocher : Poste actuel
                    CheckboxListTile(
                      value: _isCurrent,
                      onChanged: (val) {
                        setModalState(() => _isCurrent = val!);
                      },
                      title: AppText(text: "C'est mon poste actuel"),
                    ),

                    // Boutons d'action : Annuler et Ajouter/Modifier
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppButton(
                          width: context.screenWidth * 0.25,
                          backgroundColor: Colors.transparent,
                          onTap: ()=> Navigator.pop(context),
                          child: AppText(text: "Annuler", fontWeight: FontWeight.bold, color: AppColors.greyColor,),
                        ),
                        SizedBox(width: 8),

                        ElevatedButton(
                          onPressed: _submitExperience,
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

  // Fonction pour choisir une date (début ou fin)
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

  // Ajoute ou modifie une expérience après validation
  void _submitExperience() {
    if (_formKey.currentState!.validate() && _startDate != null) {
      final newExp = Experience(
        title: _titleController.text,
        company: _companyController.text,
        description: _descriptionController.text,
        startDate: _startDate!,
        endDate: _isCurrent ? null : _endDate,
        isCurrent: _isCurrent,
      );

      setState(() {
        if (editingIndex != null) {
          experiences[editingIndex!] = newExp; // Modification
        } else {
          experiences.add(newExp); // Ajout
        }
      });

      Navigator.pop(context); // Ferme le bottom sheet
    }
  }

  // Supprime une expérience
  void _deleteExperience(int index) {
    setState(() => experiences.removeAt(index));
  }

  // Affichage principal
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mes expériences")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(context.defaultPagePadding),
          child: Column(
            children: [
              SizedBox(height: context.defaultSpacing * 4,),
              AppText(
                text: "Ajoutez vos expériences professionnelles",
                fontWeight: FontWeight.bold,
                fontSize: context.largeText * 0.9,
                textAlign: TextAlign.center,
                color: AppColors.blueColor,
              ),

              SizedBox(height: context.defaultSpacing * 2,),
              AppText(
                text: "Renseignez vos postes que vous aviez occupés, les entreprises, les périodes et les missions réalisées. Ces informations permettent aux recruteurs de mieux comprendre votre parcours et voss compétences.",
                textAlign: TextAlign.justify,
                fontWeight: FontWeight.bold,
              ),

              SizedBox(height: context.defaultSpacing * 4,),
              // Bouton pour ouvrir le formulaire
              AppButton(
                onTap: () => _showExperienceForm(),
                width: context.screenWidth * 0.6,
                padding: EdgeInsets.zero,
                height: context.screenHeight * 0.05,
                //backgroundColor: AppColors.greyColor,
                radius: context.screenWidth * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add),
                    AppText(text: "Ajouter une expérience")
                  ],
                ),
              ),
              SizedBox(height: context.defaultSpacing * 4),

              // Liste des expériences ajoutées
              experiences.isEmpty
                  ? Center(child: AppText(text: "Aucune expérience ajoutée."))
                  : ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: experiences.length,
                itemBuilder: (_, index) {
                  final exp = experiences[index];
                  return Card(
                    margin: EdgeInsets.only(bottom: context.defaultPagePadding * 0.9),
                    child: ListTile(
                      title: AppText(text: exp.title),
                      subtitle: AppText(
                        text: "${exp.company}\n"
                            "${exp.description}\n"
                            "${exp.startDate.toLocal().toString().split(' ')[0]}"
                            "${exp.isCurrent ? ' - Présent' : ' - ${exp.endDate?.toLocal().toString().split(' ')[0] ?? ''}'}",
                      ),
                      isThreeLine: true,
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Bouton modifier
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.orange),
                            onPressed: () => _showExperienceForm(index),
                          ),
                          // Bouton supprimer
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteExperience(index),
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
    );
  }
}
