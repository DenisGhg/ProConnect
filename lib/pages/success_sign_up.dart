import 'package:flutter/material.dart';

import '../widgets/app_button.dart';
import '../widgets/app_text.dart';

class SuccessSignUp extends StatelessWidget {
  const SuccessSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          AppText(
            text: "Inscription réussie",
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),

          SizedBox(height: 200,),

          AppButton(
            onTap: (){
              Navigator.pushReplacementNamed(context, '/homePage');
            },
            height: 50,
            width: 200,
            child: Center(
              child: Container(
                color: Colors.blue,
                child: AppText(text: "HomePage"),
              ),
            ),

          ),
        ],
      ),
    );
  }
}
