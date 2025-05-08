import 'package:flutter/material.dart';
import 'package:pro_connect_projet/constants/images_paths.dart';
import 'package:pro_connect_projet/constants/routes.dart';
import 'package:pro_connect_projet/widgets/app_button.dart';
import 'package:pro_connect_projet/widgets/app_text.dart';
import 'package:pro_connect_projet/widgets/app_textField.dart';
import '../../../colors/app_colors.dart';

class TalentProfileStep1 extends StatefulWidget {
  const TalentProfileStep1({super.key});

  @override
  State<TalentProfileStep1> createState() => _TalentProfileStep1State();
}

class _TalentProfileStep1State extends State<TalentProfileStep1> {
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _dateBirthController = TextEditingController();
  final TextEditingController _langagesController = TextEditingController();

  String? countryError;
  String? cityError;
  String? phoneNumberError;
  String? dateOfBirthError;
  String? languagesError;

  void verifierInfo() {
    setState(() {
      countryError = _countryController.text.isEmpty ? "Le pays est obligatoire" : null;
      cityError = _cityController.text.isEmpty ? "La ville est obligatoire" : null;
      phoneNumberError = _phoneNumberController.text.isEmpty ? "Le numéro de téléphone est obligatoire" : null;
      dateOfBirthError = _dateBirthController.text.isEmpty ? "La date de naissance est obligatoire" : null;
      languagesError = _langagesController.text.isEmpty ? "Les langues sont obligatoires" : null;
    });

    if (countryError == null &&
        cityError == null &&
        phoneNumberError == null &&
        dateOfBirthError == null &&
        languagesError == null) {
      Navigator.pushNamed(context, AppRoutes.TALENTPROFILESTEP2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: "Créez votre profil",
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    ImagesPaths.PROFILEAVATAR,
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
              Center(
                child: AppButton(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 35,
                  child: AppText(
                    text: "Téléchargez une photo de profil",
                    color: Colors.white,
                    fontSize: 12,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              AppText(text: "Pays"),
              AppTextField(
                keyboardType: TextInputType.text,
                controller: _countryController,
                hinText: "Choisissez votre pays",
                enableBorderColor: countryError != null ? Colors.red : Colors.grey,
                focusedBorderColor: countryError != null ? Colors.red : Colors.grey,
                onChanged: (_) => setState(() => countryError = null),
              ),
              countryError != null
                  ? AppText(text: countryError!, color: Colors.red, fontSize: 12)
                  : const SizedBox.shrink(),
              const SizedBox(height: 12),

              AppText(text: "Ville"),
              AppTextField(
                keyboardType: TextInputType.text,
                controller: _cityController,
                hinText: "Choisissez votre ville",
                enableBorderColor: cityError != null ? Colors.red : Colors.grey,
                focusedBorderColor: cityError != null ? Colors.red : Colors.grey,
                onChanged: (_) => setState(() => cityError = null),
              ),
              cityError != null
                  ? AppText(text: cityError!, color: Colors.red, fontSize: 12)
                  : const SizedBox.shrink(),
              const SizedBox(height: 12),

              AppText(text: "Numéro de Téléphone"),
              AppTextField(
                keyboardType: TextInputType.phone,
                controller: _phoneNumberController,
                hinText: "Numéro de Téléphone",
                enableBorderColor: phoneNumberError != null ? Colors.red : Colors.grey,
                focusedBorderColor: phoneNumberError != null ? Colors.red : Colors.grey,
                onChanged: (_) => setState(() => phoneNumberError = null),
              ),
              phoneNumberError != null
                  ? AppText(text: phoneNumberError!, color: Colors.red, fontSize: 12)
                  : const SizedBox.shrink(),
              const SizedBox(height: 12),

              AppText(text: "Date de Naissance"),
              AppTextField(
                keyboardType: TextInputType.datetime,
                controller: _dateBirthController,
                hinText: "DD/MM/AAAA",
                enableBorderColor: dateOfBirthError != null ? Colors.red : Colors.grey,
                focusedBorderColor: dateOfBirthError != null ? Colors.red : Colors.grey,
                onChanged: (_) => setState(() => dateOfBirthError = null),
              ),
              dateOfBirthError != null
                  ? AppText(text: dateOfBirthError!, color: Colors.red, fontSize: 12)
                  : const SizedBox.shrink(),
              const SizedBox(height: 12),

              AppText(text: "Langues"),
              AppTextField(
                keyboardType: TextInputType.text,
                controller: _langagesController,
                hinText: "Choisissez vos langues",
                enableBorderColor: languagesError != null ? Colors.red : Colors.grey,
                focusedBorderColor: languagesError != null ? Colors.red : Colors.grey,
                onChanged: (_) => setState(() => languagesError = null),
              ),
              languagesError != null
                  ? AppText(text: languagesError!, color: Colors.red, fontSize: 12)
                  : const SizedBox.shrink(),
              const SizedBox(height: 12),

              AppButton(
                onTap: verifierInfo,
                height: 50,
                width: double.infinity,
                backgroundColor: AppColors.blueColor,
                alignment: Alignment.center,
                child: AppText(
                  text: "Continuer",
                  color: Colors.white,
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
