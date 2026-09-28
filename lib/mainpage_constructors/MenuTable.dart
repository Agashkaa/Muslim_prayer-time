import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sahypam/mainpage_constructors/finderQibla.dart';
import 'package:sahypam/mainpage_constructors/quranpage.dart';
import 'package:sahypam/mainpage_constructors/tasbeehat.dart';
import 'package:sahypam/mainpage_constructors/zikirler.dart';

class Menutable extends StatefulWidget {
  const Menutable({super.key});

  @override
  State<Menutable> createState() => _MenutableState();
}

class _MenutableState extends State<Menutable> {
  final List<Map<String, dynamic>> menuItems = [
    {
      'icon': AssetImage("assets/quran.png"),
      'title': 'Gurhan',
      'page': const QuranPage(),
    },
    {
      'icon': AssetImage("assets/tasbeeh.jfif"),
      'title': 'Dogalar',
      'page': const Tasbeehat(),
    },
    {
      'icon': AssetImage("assets/qiblafind.jfif"),
      'title': 'Kible',
      'page': const QiblaFinder(),
    },
    {
      'icon': AssetImage("assets/learn.jfif"),
      'title': 'Zekat',
      'page': const Hymazikir(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: menuItems.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12, // Добавлено для красивого зазора между рядами
        childAspectRatio: 1.3,
      ),
      itemBuilder: (context, index) {
        final item = menuItems[index];

        return Container(
          // Перенесли margin наружу, чтобы анимация нажатия InkWell не обрезалась
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24), // Исправлена синтаксическая ошибка
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), // Увеличено размытие для мягкости
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  // Тонкая белая граница создает эффект преломления света на гранях стекла
                  border: Border.all(
                    color: Colors.white60,
                    width: 2.5,
                  ),
                  // Полупрозрачный белый градиент — основа светлого стекла
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.45),
                      Colors.white.withOpacity(0.40),
                    ],
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => item['page']),
                    );
                  },
                  borderRadius: BorderRadius.circular(24),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0), // Отступы для содержимого карточки
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Иконка приложения
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: ColorFiltered(
                            // Ak reňki fon bilen garyşdyryp, ony dury (transparent) edýär
                            colorFilter: ColorFilter.mode(
                              Colors.white,
                              BlendMode.darken, // Ýa-da BlendMode.multiply synap görüň
                            ),
                            child: Image(
                              image: item['icon'] as AssetImage,
                              width: 150,
                              height: 100,
                              fit: BoxFit.contain,
                            ),
                          ),
                        )

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
