import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  void lancement(){
    Future.delayed(const Duration(seconds: 3), (){
      Navigator.pushReplacementNamed(context, '/homePage');
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
          child: Image.asset("images/ProConnectLogoS.png", width: 100, height: 100,),
        ),
      ),
    );
  }
}
