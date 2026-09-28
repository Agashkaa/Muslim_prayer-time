import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sahypam/authentification/forgotPas.dart';
import 'package:sahypam/mainPage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool showSpinner = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Метод теперь возвращает Future<void> для корректного await
  Future<void> signin() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(), // Добавлен trim() для email
      password: _passwordController.text.trim(),
    );
  }

  @override
  void dispose() {
    // Обязательно очищаем контроллеры для предотвращения утечек памяти
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            // Обернули поля в Form для работы валидации
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      "Войти!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center( // Центрируем подзаголовок для красоты
                    child: Text(
                      "Войдите в свой аккаунт, чтобы продолжить",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: Colors.white), // Белый текст ввода
                    decoration: InputDecoration(
                      hintText: 'Email',
                      labelText: 'Email',
                      hintStyle: const TextStyle(color: Colors.grey),
                      labelStyle: const TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Введите Email"; // Исправлен текст ошибки
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true, // Скрываем ввод пароля точками
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Password',
                      labelText: 'Password',
                      hintStyle: const TextStyle(color: Colors.grey),
                      labelStyle: const TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Введите пароль";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),

                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Forgotpas()));
                      },
                      child: Text("Forgot password"),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50, // Фиксированная высота кнопки
                    child: FilledButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            showSpinner = true;
                          });

                          try {
                            await signin();
                            final user = FirebaseAuth.instance.currentUser;
                            if(user != null && !user.emailVerified){
                              await FirebaseAuth.instance.signOut();
                              toastMessage("Пожалуйста, подтвердите ваш Email на почте перед входом!");
                              if(mounted){
                                setState(() {
                                  showSpinner = false;
                                });
                              }
                              return;
                            }
                            print("success");
                            toastMessage("Вы успешно вошли");

                            if (mounted) {
                              setState(() {
                                showSpinner = false; // Выключаем спиннер
                              });
                              // Переходим на Homepage и очищаем стек переходов
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => const Mainpage()),
                                    (route) => false,
                              );
                            }
                          } catch (e) {
                            print(e.toString());
                            toastMessage("Ошибка: ${e.toString()}");
                            if (mounted) {
                              setState(() {
                                showSpinner = false; // Выключаем спиннер при ошибке
                              });
                            }
                          }
                        }
                      },
                      child: const Text("Войти", style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
