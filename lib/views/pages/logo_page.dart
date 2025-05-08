import 'package:flutter/material.dart';
import 'package:pro_connect_projet/constants/images_paths.dart';
import 'package:pro_connect_projet/constants/routes.dart';
import 'package:pro_connect_projet/views/colors/app_colors.dart';
import 'package:pro_connect_projet/views/sizes/app_sizes.dart';

class LogoPage extends StatefulWidget {
  const LogoPage({super.key});

  @override
  State<LogoPage> createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage> {
  void lauch(){
    Future.delayed(const Duration(seconds: 2), (){
      Navigator.pushReplacementNamed(context, AppRoutes.PRESENTATIONPAGE);
    });
  }

  @override
  initState(){
    super.initState();
    lauch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(ImagesPaths.LOGOBLUE, width: context.screenHeight * 0.37, height: context.screenHeight * 0.37,),
      ),
    );
  }
}
