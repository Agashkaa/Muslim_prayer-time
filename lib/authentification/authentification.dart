import 'package:flutter/material.dart';
import 'package:sahypam/authentification/Login.dart';
import 'package:sahypam/authentification/signin.dart';


class Authentification extends StatefulWidget {
  const Authentification({super.key});

  @override
  State<Authentification> createState() => _AuthentificationState();
}

class _AuthentificationState extends State<Authentification> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
               Image.asset('assets/ss.gif',height: 300,width: 200,),
                const SizedBox(height: 20,),
                Text("Добро пожаловать",style: TextStyle(color: Colors.white,fontWeight: .bold,fontSize: 30),),
                const SizedBox(height: 15,),
                const Text(
                  "Если вы уже зарегистрированы, выберите «Войти».\nЕсли нет — нажмите «Регистрация»", // Текст стал более профессиональным
                  textAlign: TextAlign.center, // ИСПРАВЛЕНО
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white70,
                    height: 1.4, // Межстрочный интервал для читаемости
                  ),
                ),
                const SizedBox(height: 50,),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const Login()));
                    },
                    child: Text("Войти"),
                  ),
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const Signin()));
                    },
                    child: Text("Регистрация"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
