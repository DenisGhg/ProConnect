import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pro_connect_projet/widgets/app_text.dart';

import '../../../models/register/talent/profile.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  TalentProfile? profil;

  Future<void> loadProfile() async {
    final String response = await rootBundle.loadString('asserts/jsons/profiles.json');
    final List<dynamic> data = json.decode(response);
    setState(() {
      profil = TalentProfile.fromJson(data[26]); // Simule profil connecté
    });
  }

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
      appBar: AppBar(title: const Text("Profil Talent")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Center(
              child: Column(
                children: [
                  CircleAvatar(radius: 50, backgroundImage: NetworkImage(profil!.avatar)),
                  const SizedBox(height: 10),
                  AppText(text: "${profil!.firstName} ${profil!.lastName}", fontSize: 20, fontWeight: FontWeight.bold),
                  AppText(text: profil!.title),
                  const SizedBox(height: 10),
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
        "${year}";
  }
}
