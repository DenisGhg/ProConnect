import 'package:flutter/material.dart';
import 'package:pro_connect_projet/constants/images_paths.dart';
import 'package:pro_connect_projet/constants/routes.dart';

class LogoPage extends StatefulWidget {
  const LogoPage({super.key});

  @override
  State<LogoPage> createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage> {
  void lancement(){
    Future.delayed(const Duration(seconds: 5), (){
      Navigator.pushReplacementNamed(context, AppRoutes.PRESENTATIONPAGE);
    });
  }

  @override
  initState(){
    super.initState();
    lancement();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child : Center(
          child: Image.asset(ImagesPaths.LOGOWHITE, width: 300, height: 300,),
        ),
      ),
    );
  }
}
