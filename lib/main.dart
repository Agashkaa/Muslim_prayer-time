import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart'; // Hökmany goşuň
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sahypam/mainPage.dart';
import 'package:sahypam/models/onBoarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'authentification/authentification.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      // Слушаем изменения состояния авторизации (вошел/вышел)
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Пока Firebase проверяет токен, показываем индикатор загрузки
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Colors.black,
            body: Center(child: CircularProgressIndicator(color: Colors.blue)),
          );
        }

        // Если пользователь найден в системе
        if (snapshot.hasData && snapshot.data != null) {
          final user = snapshot.data!;

          // Проверяем, подтвердил ли он email
          if (user.emailVerified) {
            return const Mainpage(); // Почта подтверждена -> пускаем на главную
          }
        }

        // Если пользователя нет или email не подтвержден -> отправляем логиниться
        // Замените WelcomeOrLogin на ваш начальный экран (например, Login или Welcome)
        return const Authentification();
      },
    );
  }
}



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  final bool isFirstTime = preferences.getBool('is_first_time') ?? true;

  runApp(MyApp(isFirstTime: isFirstTime));
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;
  const MyApp({super.key, required this.isFirstTime});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const MaterialScrollBehavior().copyWith(
        physics: const ClampingScrollPhysics()
      ),
      child: MaterialApp(
        title: "Sahypam",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFF121212),
          canvasColor: const Color(0xFF121212),
          colorScheme: const ColorScheme.dark(
            background: const Color(0xFF121212),
            surface: const Color(0xFF121212),
          ),
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            },
          ),
        ),
        // Şu aşakdaky şertli StreamBuilder-i goşduk:
        home: isFirstTime
            ? const OnboardingPage()
            : StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // Firebase maglumatlary barlap ýetişýänçä garaşma ekrany
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              );
            }
            // Eger ulanyjy öň login bolan bolsa göni Mainpage ugradýar
            if (snapshot.hasData) {
              //return const Mainpage();
              return const AuthGate();
            }
            // Login bolmadyk bolsa Authentification sahypasyna ugradýar
            return const Authentification();
          },
        ),
      ),
    );
  }
}
