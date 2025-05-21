import 'package:flutter/material.dart';
import 'package:pro_connect_projet/constants/routes.dart';
import 'package:pro_connect_projet/providers.dart';
import 'package:pro_connect_projet/providers/themes/theme_provider.dart';
import 'package:pro_connect_projet/themes/app_themes.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: providers,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: context.watch<ThemeProvider>().themeMode,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.TALENTPROFILESTEP1,
      routes: routes,
    );
  }
}
