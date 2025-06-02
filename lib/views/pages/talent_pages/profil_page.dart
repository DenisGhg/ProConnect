import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pro_connect_projet/views/sizes/app_sizes.dart';
import 'package:pro_connect_projet/views/sizes/text_sizes.dart';
import 'package:pro_connect_projet/widgets/app_text.dart';

import '../../../models/register/talent/profile.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  TalentProfile? profil;

  //Fonction de changement des utilisateurs
  Future<void> loadProfile() async {
    final String response = await rootBundle.loadString('asserts/jsons/profiles.json');
    final List<dynamic> data = json.decode(response);
    setState(() {
      profil = TalentProfile.fromJson(data[35]); // Simule profil connecté
    });
  }

  //Pour le lancement auto de loadProfile()
  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    if (profil == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: AppText(text: "Profil", fontSize: context.largeText,), centerTitle: true,),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(context.defaultPagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Center(
              child: Column(
                children: [
                  //Avatar
                  GestureDetector(
                    //Agrandissement de l'image au clic
                    onTap: (){
                      showDialog(
                        context: context,
                        builder: (alertContext) => AlertDialog(
                          insetPadding: EdgeInsets.zero,
                          content: Container(
                            width: context.screenWidth,
                            height: context.screenHeight * 0.7,

                            child: CircleAvatar(radius: 50, backgroundImage: NetworkImage(profil!.avatar)),
                          )
                        ),
                      );
                    },
                    child: CircleAvatar(radius: 50, backgroundImage: NetworkImage(profil!.avatar)),

                  ),
                  const SizedBox(height: 10),

                  // Nom Prénoms
                  AppText(text: "${profil!.firstName} ${profil!.lastName}", fontSize: 20, fontWeight: FontWeight.bold),

                  //Titre pro
                  AppText(text: profil!.title),
                  const SizedBox(height: 10),

                  //Bio
                  Text(profil!.bio, textAlign: TextAlign.center),
                ],
              ),
            ),
            const Divider(height: 30),

            // Expériences
            AppText(text: "Expériences", fontWeight: FontWeight.bold, fontSize: 18),
            ...profil!.experiences.map((e) => ListTile(
              title: Text(e.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(e.company),
                  Text(e.description),
                ],
              ),
              trailing: Text(e.isCurrent ? "En cours" : "${e.startDate.toLocal().toShortDateString()} - ${e.endDate != null ? e.endDate!.toLocal().toShortDateString() : 'Aujourd’hui'}"),
            )),
            const Divider(height: 30),

            // Formations
            AppText(text: "Formations", fontWeight: FontWeight.bold, fontSize: 18),
            ...profil!.educations.map((e) => ListTile(
              title: Text(e.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(e.company),
                  Text(e.description),
                ],
              ),
              trailing: Text("${e.startDate.toLocal().toShortDateString()} - ${e.endDate != null ? e.endDate!.toLocal().toShortDateString() : 'En cours'}"),
            )),
            const Divider(height: 30),

            // Langues
            AppText(text: "Langues", fontWeight: FontWeight.bold, fontSize: 18),
            Wrap(
              spacing: 10,
              children: profil!.languages.map((lang) => Chip(label: Text("${lang['language']} (${lang['level']})"))).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

extension DateHelpers on DateTime {
  String toShortDateString() {
    return "${day.toString().padLeft(2, '0')}/"
        "${month.toString().padLeft(2, '0')}/"
        "$year";
  }
}
