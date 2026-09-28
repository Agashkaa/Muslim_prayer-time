import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Forgotpas extends StatefulWidget {
  const Forgotpas({super.key});

  @override
  State<Forgotpas> createState() => _ForgotpasState();
}

class _ForgotpasState extends State<Forgotpas> {
  bool showSpinner = false;
  TextEditingController _emailController = TextEditingController();
  String email = "";

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    super.dispose();
  }
  Future passwordReset()async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text("Пароль отправлено на вашем почте! Проверте!"),
        );
      });
    } on FirebaseAuthException catch (e){
      print(e.toString());
      showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text(e.message.toString()),
        );
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Восттановление пароль",style: TextStyle(fontSize: 25,),),
          const SizedBox(height: 20,),
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
          const SizedBox(height: 15,),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
                onPressed: ()async {
                  passwordReset();
                },
                child: Text("Получить код")
            )
          )

        ],
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
