import 'package:flutter/material.dart';
import 'package:pro_connect_projet/views/sizes/app_sizes.dart';
import 'package:pro_connect_projet/views/sizes/text_sizes.dart';
import 'package:pro_connect_projet/widgets/app_snackbar.dart';
import 'package:pro_connect_projet/widgets/app_textField.dart';

import '../../../../constants/routes.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_text.dart';
import '../../../colors/app_colors.dart';

class TalentProfileStep3Page extends StatefulWidget {
  const TalentProfileStep3Page({super.key});

  @override
  State<TalentProfileStep3Page> createState() => _TalentProfileStep3PageState();
}

class _TalentProfileStep3PageState extends State<TalentProfileStep3Page> {
  
  final TextEditingController _titleProController = TextEditingController();

  final FocusNode _titleProFocusNode = FocusNode();


  void _focusNodeLaunch(){
    Future.delayed(const Duration(seconds: 2), (){
      FocusScope.of(context).requestFocus(_titleProFocusNode);
    });
  }

  @override
  void initState() {
    _focusNodeLaunch();
    super.initState();
  }

  void _onSubmitted(){
    if(_titleProController.text.isEmpty){
      AppSnackBar.show(context, "Veuillez entrer un titre Pro");
    }else{
      Navigator.pushNamed(context, AppRoutes.TALENTPROFILESTEP4);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: context.screenHeight * 0.05,
        leadingWidth: context.screenHeight * 0.075,
        centerTitle: true,
        title: AppText(text: "Créez votre Profil", fontWeight: FontWeight.bold, fontSize: context.largeText * 0.9,),
        leading: Padding(
          padding: EdgeInsets.only(left: context.defaultPagePadding),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.greyColor,
              borderRadius: BorderRadius.circular(context.screenHeight * 0.03),
            ),
            child: Icon(Icons.person, size: context.screenHeight * 0.038, color: AppColors.blackColor,),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(context.defaultPagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.defaultSpacing * 4,),
              AppText(
                text: "Exprimez en une phrase qui vous êtes en tant que professionnel",
                fontWeight: FontWeight.bold,
                fontSize: context.largeText * 0.9,
                textAlign: TextAlign.center,
                color: AppColors.blueColor,
              ),

              SizedBox(height: context.defaultSpacing * 2,),
              AppText(
                text: "C’est la première chose que les recruteurs verront, alors assurez-vous qu’il reflète clairement votre expertise. Montrez en quelques mots ce que vous faites de mieux.",
                textAlign: TextAlign.justify,
                fontWeight: FontWeight.bold,
              ),

              SizedBox(height: context.defaultSpacing * 2,),
              AppText(
                text: "Titre professionnel",
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.start,
                ),

              SizedBox(height: context.defaultSpacing,),
              AppTextField(
                controller: _titleProController,
                //focusNode: _titleProFocusNode,
                keyboardType: TextInputType.text,
                hinText: "Ex : Développeur web et mobile",
              ),

            ],
          ),
        ),
      ),

      bottomNavigationBar:  Container(
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        padding: EdgeInsets.all(context.defaultPagePadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(context.screenHeight * 0.038),
                  border: Border.all(
                    color: AppColors.greyColor,
                    width: 2,
                  )
              ),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios_new, size: context.screenHeight * 0.03, color: AppColors.blueColor,),
              ),
            ),

            //Suivant
            AppButton(
              onTap: _onSubmitted,
              width: context.screenWidth * 0.4,
              child: AppText(text: "Suivant"),
            )
          ],
        ),
      ),

    );
  }
}
