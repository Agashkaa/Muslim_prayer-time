import 'package:flutter/material.dart';
import 'package:glass_bottom_navigation/glass_bottom_navigation.dart';

// Переименовали класс здесь
class Hymazikir extends StatefulWidget {
  const Hymazikir({super.key});

  @override
  State<Hymazikir> createState() => _HymazikirState();
}

class _HymazikirState extends State<Hymazikir> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: GlassBottomBar(
          items: const [
            GlassBarItem(
                icon: Icons.home_max_rounded,
                label: "Home",nativeSymbolName: 'house.fill'
            ),
            GlassBarItem(
                icon: Icons.search,
                label: "Search",
                nativeSymbolName: 'magnyfyinglass'
            )
          ],
          currentIndex: _currentIndex,
          onTap: (int value) {
            setState(() {
              _currentIndex = value;
            });
        },
        )
      ),
    );
  }
}
