import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/services.dart';
import 'package:pro_connect_projet/constants/images_paths.dart';
import 'package:pro_connect_projet/constants/routes.dart';
import 'package:pro_connect_projet/views/colors/app_colors.dart';
import 'package:pro_connect_projet/views/sizes/app_sizes.dart';
import 'package:pro_connect_projet/views/sizes/text_sizes.dart';
import 'package:pro_connect_projet/widgets/app_list_tile.dart';
import 'package:pro_connect_projet/widgets/app_text.dart';
import 'package:provider/provider.dart';

import '../../../models/register/talent/profile.dart';
import '../../../providers/talent_providers/notification_talent_provider.dart';
import '../../../providers/themes/theme_provider.dart';
import '../../../widgets/app_button.dart';
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

  //pour ouvrir le drawer
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Chargement simulé du profil depuis un JSON local
  TalentProfile? profil;
  Future<void> loadProfile() async {
    final String response = await rootBundle.loadString(
      'asserts/jsons/profiles.json',
    );
    final List<dynamic> data = json.decode(response);
    setState(() {
      profil = TalentProfile.fromJson(data[35]); // Simule profil connecté
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
      // Affichage d'un indicateur de chargement si le profil n'est pas encore dispo
      return const Center(child: CircularProgressIndicator());
    }

    //Appel de la variable qui gère  thème dans le provider
    final isDarkMode = context.watch<ThemeProvider>().isDarkMode;

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        width: context.screenWidth * 0.9,
        child: Column(
          children: [
            ListTile(
              onTap:
                  () =>
                  Navigator.pushNamed(context, AppRoutes.TALENTPROFILEPAGE),
              leading: CircleAvatar(
                radius: context.referenceSize * 2,
                backgroundImage:
                profil != null
                    ? NetworkImage(profil!.avatar)
                    : AssetImage(ImagesPaths.DEFAULTAVATAR),
              ),

              title: AppText(
                text: "${profil!.firstName} ${profil!.lastName}",
                fontWeight: FontWeight.bold,
              ),
              subtitle: AppText(
                text: profil!.title,
                color: AppColors.greyColor,
                fontSize: context.mediumText * 0.9,
              ),
            ),

            //Options du ListTile
            AppListTile(
              leading: Icon(Icons.settings),
              title: AppText(text: "Paramètres"),
            ),
            AppListTile(
              leading: Icon(Icons.dark_mode),
              title: AppText(text: "Thème Sombre",),
              trailing: Switch(
                activeColor: AppColors.blueColor,
                inactiveThumbColor: AppColors.blackColor,
                value: isDarkMode,
                onChanged: (bool value){
                  context.read<ThemeProvider>().toggleTheme();
                },
              ),
            ),

            Spacer(),
            //Bouton Se deconnecter
            AppButton(
              onTap: ()=> Navigator.pushNamedAndRemoveUntil(context, AppRoutes.PRESENTATIONPAGE, (route)=>false),
              backgroundColor: AppColors.redColor,
              width: context.screenWidth * 0.5,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.logout, color: Colors.white),
                  SizedBox(width: 8),
                  AppText(
                    text: "Se déconnecter",
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            )
          ],
        ),
      ),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: context.referenceSize),
              child: GestureDetector(
                onTap: () => _scaffoldKey.currentState?.openDrawer(),
                child:
                profil != null
                    ? CircleAvatar(
                  radius: context.referenceSize * 2,
                  backgroundImage: NetworkImage(profil!.avatar),
                )
                    : Container(
                  decoration: BoxDecoration(
                    color: AppColors.greyColor,
                    borderRadius: BorderRadius.circular(
                      context.screenHeight * 0.03,
                    ),
                  ),
                  child: Icon(
                    Icons.person,
                    size: context.screenHeight * 0.038,
                    color: AppColors.blackColor,
                  ),
                ),
              ),
            ),
            SizedBox(width: context.referenceSize),

            AppText(
              text: "proconnect",
              color: AppColors.blueColor,
              fontSize: context.largeText,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),

      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),

      //Bar de navigation
      bottomNavigationBar: ConvexAppBar.badge(
        {
          // 👇 Index du tab "Notifications"
          3: context.watch<NotificationTalentProvider>().unreadCount > 0
              ? '${context.watch<NotificationTalentProvider>().unreadCount}' // Le nombre à afficher
              : null, // Pas de badge si 0
        },
        style: TabStyle.react,
        backgroundColor: AppColors.blueColor,
        activeColor: AppColors.whiteColor,
        items: [
          TabItem(icon: Icons.home, title: "Accueil"),
          TabItem(icon: Icons.message, title: "Discussions"),
          TabItem(icon: Icons.developer_board, title: "Dashboard"),
          TabItem(icon: Icons.notifications, title: "Notifications"),
        ],
        initialActiveIndex: _selectedIndex,
        onTap: _onItemTapped,
      )
    );
  }
}
