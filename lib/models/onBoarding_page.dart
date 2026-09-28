import 'package:flutter/material.dart';
import 'package:sahypam/authentification/authentification.dart';
import 'package:sahypam/models/onboard_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onBoardItemWidget.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentPage = 0;
  final PageController _pageController = PageController();
  final List<OnboardItem> _pages = [
    OnboardItem(
      title: 'Время молитвы',
      subtitle: 'Вы можете посмотреть время намаза и другие функции',
      lottieUrl: 'https://lottie.host/f2427f7e-6397-4297-80e2-beca6d026253/vAXNwsatI0.json',
    ),
    OnboardItem(
      title: 'Учет страниц',
      subtitle: 'Легко считайте прочитанные страницы за каждый месяц',
      lottieUrl: 'https://lottie.host/f8fbd2f9-59cb-4465-97fd-dfa55cf751b4/PvaSIzMts9.json',
    ),
    OnboardItem(
      title: 'Добро пожаловать!',
      subtitle: 'Наслаждайтесь простым и удобным использованием приложения',
      lottieUrl: 'https://lottie.host/c2fe247c-898d-4f19-b4ff-cd1c571ea3c1/vroGPmgqWX.json',
    ),

  ];

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }
  void _next() async {
    if (currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_first_time', false);

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const Authentification()), // Homepage const bolsa const goşuň
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: (value)=>setState(() {
                    currentPage = value;
                  }),
                  itemBuilder: (context,index){
                    return Onboarditemwidget(
                        item: _pages[index],
                      );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: .center,
                spacing: 10,
                children: List.generate(_pages.length, (index){
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 8,
                    width: currentPage == index ? 18 : 8,
                    decoration: BoxDecoration(
                      color: currentPage == index ? Colors.red : Colors.blueGrey,
                      borderRadius: BorderRadius.circular(10)
                    ),
                  );
                }),
              ),
              const SizedBox(height: 25,),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                    onPressed: _next,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      textStyle: const TextStyle(fontWeight:.bold,fontSize: 16),
                    ),
                  child: Text(
                    currentPage == _pages.length - 1 ? 'Bismillah' : 'Next'
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}