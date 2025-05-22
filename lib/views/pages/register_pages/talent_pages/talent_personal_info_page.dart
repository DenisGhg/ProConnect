import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:pro_connect_projet/constants/images_paths.dart';
import 'package:pro_connect_projet/constants/routes.dart';
import 'package:pro_connect_projet/views/sizes/app_sizes.dart';
import 'package:pro_connect_projet/views/sizes/text_sizes.dart';
import 'package:pro_connect_projet/widgets/app_button.dart';
import 'package:pro_connect_projet/widgets/app_text.dart';
import 'package:pro_connect_projet/widgets/app_textField.dart';
import 'package:provider/provider.dart';
import '../../../../providers/register_providers/talent_providers/talent_personal_info_provider.dart';
import '../../../colors/app_colors.dart';

class TalentPersonalInfoPage extends StatefulWidget {
  const TalentPersonalInfoPage({super.key});

  @override
  State<TalentPersonalInfoPage> createState() => _TalentPersonalInfoPageState();
}

class _TalentPersonalInfoPageState extends State<TalentPersonalInfoPage> {
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _dateBirthController = TextEditingController();
  Country? _selectedCountry;

  String? countryError;
  String? cityError;
  String? phoneNumberError;
  String? dateOfBirthError;

  void onSubmitted() {
    setState(() {
      countryError = _countryController.text.isEmpty ? "Le pays est obligatoire" : null;
      cityError = _cityController.text.isEmpty ? "La ville est obligatoire" : null;
      phoneNumberError = _phoneNumberController.text.isEmpty ? "Le numéro de téléphone est obligatoire" : null;
      dateOfBirthError = _dateBirthController.text.isEmpty ? "La date de naissance est obligatoire" : null;
    });

    if (countryError == null &&
        cityError == null &&
        phoneNumberError == null &&
        dateOfBirthError == null) {

      final provider = Provider.of<TalentPersonalInfoProvider>(context, listen: false);
      provider.setCountry(_countryController.text.trim());
      provider.setCity(_cityController.text.trim());
      provider.setPhoneNumber(_phoneNumberController.text.trim());
      provider.setDateOfBirth(_dateBirthController.text.trim());

      Navigator.pushNamed(context, AppRoutes.SUBDOMAINSELECTIONPAGE);
    }
  }


  void _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: "Sélectionnez votre date de naissance",
    );
    if (pickedDate != null) {
      setState(() {
        _dateBirthController.text =
        "${pickedDate.day.toString().padLeft(2, '0')}/"
            "${pickedDate.month.toString().padLeft(2, '0')}/"
            "${pickedDate.year}";
        dateOfBirthError = null;
      });
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
          padding: EdgeInsets.all(context.defaultPagePadding),
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
                  width: context.screenWidth * 0.6,
                  height: 35,
                  child: AppText(
                    text: "Téléchargez une photo de profil",
                    fontSize: context.smallText,
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
                readOnly: true,
                enableBorderColor: countryError != null ? AppColors.redColor: AppColors.greyColor,
                focusedBorderColor: countryError != null ? AppColors.redColor: AppColors.blueColorSecond,
                //onChanged: (_) => setState(() => countryError = null),
                onTap: () {
                  showCountryPicker(
                    context: context,
                    showPhoneCode: true,
                    onSelect: (Country country) {
                      setState(() {
                        _selectedCountry = country;
                        _countryController.text = '${country.flagEmoji} ${country.name} (+${country.phoneCode})';
                      });
                    },
                  );
                },
              ),
              countryError != null
                  ? AppText(text: countryError!, color: AppColors.redColor, fontSize: 12)
                  : const SizedBox.shrink(),
              const SizedBox(height: 12),

              AppText(text: "Ville"),
              AppTextField(
                keyboardType: TextInputType.text,
                controller: _cityController,
                hinText: "Choisissez votre ville",
                enableBorderColor: cityError != null ? AppColors.redColor: AppColors.greyColor,
                focusedBorderColor: cityError != null ? AppColors.redColor: AppColors.blueColorSecond,
                onChanged: (_) => setState(() => cityError = null),
              ),
              cityError != null
                  ? AppText(text: cityError!, color: AppColors.redColor, fontSize: 12)
                  : const SizedBox.shrink(),
              const SizedBox(height: 12),

              AppText(text: "Numéro de Téléphone"),
              AppTextField(
                keyboardType: TextInputType.phone,
                controller: _phoneNumberController,
                hinText: "Numéro de Téléphone",
                prefix: AppText(text: _selectedCountry != null ? '+${_selectedCountry!.phoneCode} ' : ''),
                enableBorderColor: phoneNumberError != null ? AppColors.redColor: AppColors.greyColor,
                focusedBorderColor: phoneNumberError != null ? AppColors.redColor: AppColors.blueColorSecond,
                onChanged: (_) => setState(() => phoneNumberError = null),
              ),
              phoneNumberError != null
                  ? AppText(text: phoneNumberError!, color: AppColors.redColor, fontSize: 12)
                  : const SizedBox.shrink(),
              const SizedBox(height: 12),

              AppText(text: "Date de Naissance"),
              AppTextField(
                readOnly: true,
                keyboardType: TextInputType.datetime,
                controller: _dateBirthController,
                hinText: "DD/MM/AAAA",
                enableBorderColor: dateOfBirthError != null ? AppColors.redColor : AppColors.greyColor,
                focusedBorderColor: dateOfBirthError != null ? AppColors.redColor : AppColors.blueColorSecond,
                onTap: _selectDate,
                onChanged: (_) => setState(() => dateOfBirthError = null),
              ),

              dateOfBirthError != null
                  ? AppText(text: dateOfBirthError!, color: AppColors.redColor, fontSize: 12)
                  : const SizedBox.shrink(),

              SizedBox(height: context.defaultSpacing * 15,),

              AppButton(
                onTap: onSubmitted,
                height: 50,
                width: double.infinity,
                backgroundColor: AppColors.blueColor,
                alignment: Alignment.center,
                child: AppText(
                  text: "Continuer",
                  color: AppColors.whiteColor,
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
