import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glass_bottom_navigation/nav_style.dart';
import 'package:sahypam/Driver/profile.dart';
import 'package:sahypam/mainpage_constructors/MenuTable.dart';
import 'package:sahypam/mainpage_constructors/nextprayer_location.dart';
import 'package:sahypam/mainpage_constructors/prayerTile.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {

  // Reňkleri bir ýerde saklamak - üýtgetmek aňsat bolar ýaly
  static const Color kBgColor = Color(0xFFFAF6EF);
  static const Color kGradientTop = Color(0xFFF4A94A);
  static const Color kGradientBottom = Color(0xFFFCE0AE);
  static const Color kAccent = Color(0xFF0F6E5C);

  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: kBgColor,
      drawer: Drawer(
        backgroundColor: const Color(0xFF121212),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 32,
                backgroundColor: kAccent.withOpacity(0.2),
                child: const Icon(Icons.person, color: Colors.white, size: 32),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                "Hello  ${user.displayName}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(color: Colors.white24),
              _drawerItem(
                Icons.home,
                "Baş sahypa",
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const Profile()));
                }
              ),
              _drawerItem(
                  Icons.access_time,
                  "Namaz wagtlary",
                  onTap: (){

                  }
              ),
              _drawerItem(
                  Icons.book,
                  "Gurhan",
                  onTap: (){

              }),
              _drawerItem(Icons.settings,
                  "Sazlamalar",
                  onTap: (){

              }),
            ],
          ),
        ),
      ),
      body: Builder(
        builder: (context) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // 1. Gradiýent fon
                        Container(
                          height: 300,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [kGradientTop, kGradientBottom],
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(36),
                              bottomRight: Radius.circular(36),
                            ),
                          ),
                        ),

                        //surat
                        Positioned(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(36),
                              bottomRight: Radius.circular(36),
                            ),
                            child: Opacity(
                              opacity: 0.55,
                              child: Image.asset(
                                "assets/vintage.jfif",
                                height: 300,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        CurrentLocation(),
                        SizedBox(height: 10,),
                      ],
                    ),

                    // Card aşak çykandygy sebäpli boşluk goşulýar
                    const SizedBox(height: 50),

                    // Mazmun bölegi
                    Prayertile(),
                    Menutable(),

                    const SizedBox(height: 50,)

                  ],
                ),
              ),

              Positioned(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 12,
                    left: 12,
                    right: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GlassActionButtonRow(
                        actions: [
                          GlassActionButtonItem(
                            type: GlassActionIcon.settings,
                            icon: Icons.menu,
                            nativeSymbolName: 'slider.horizontal.3',
                            semanticLabel: 'Filters',
                            onTap: () => Scaffold.of(context).openDrawer(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }


  Widget _drawerItem(IconData icon, String label, {required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(label, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}
