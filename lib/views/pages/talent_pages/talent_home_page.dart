import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:pro_connect_projet/constants/routes.dart';
import 'package:pro_connect_projet/views/colors/app_colors.dart';
import 'package:pro_connect_projet/views/sizes/app_sizes.dart';
import 'package:pro_connect_projet/views/sizes/text_sizes.dart';
import 'package:pro_connect_projet/widgets/app_text.dart';

import 'landing_screens/chart_page.dart';
import 'landing_screens/dashboard_page.dart';
import 'landing_screens/home_page.dart';
import 'landing_screens/notifications_page.dart';

class TalentHomePage extends StatefulWidget {
  const TalentHomePage({super.key});

  @override
  State<TalentHomePage> createState() => _TalentHomePageState();
}

class _TalentHomePageState extends State<TalentHomePage> {

  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  //Liste des pages du pageview
  final List<Widget> _pages = [
    HomePage(),
    ChartPage(),
    DashboardPage(),
    NotificationsPage(),
  ];

  //Fonction de défilement des pages
  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: context.screenHeight * 0.05,
        leadingWidth: context.screenHeight * 0.075,
        centerTitle: true,
        title: AppText(
          text: "ProConnect",
          color: AppColors.blueColor,
          fontSize: context.largeText,
          fontWeight: FontWeight.bold,
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: context.defaultPagePadding),
          child: GestureDetector(
            onTap: ()=> Navigator.pushNamed(context, AppRoutes.PROFILPAGE),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.greyColor,
                borderRadius: BorderRadius.circular(context.screenHeight * 0.03),
              ),
              child: Icon(Icons.person, size: context.screenHeight * 0.038, color: AppColors.blackColor,),
            ),
          ),
        ),
      ),

      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index){
          setState(() {
            _selectedIndex = index;
          });
        },
      ),

      //Bar de navigation
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        backgroundColor: AppColors.blueColor,
        activeColor: AppColors.whiteColor,
        items: [
          TabItem(icon: Icons.home, title: "Accueil"),
          TabItem(icon: Icons.message, title: "Discussions"),
          TabItem(icon: Icons.developer_board, title: "Dashbord"),
          TabItem(icon: Icons.notifications, title: "Notifications"),
        ],
        initialActiveIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );



  }
}
