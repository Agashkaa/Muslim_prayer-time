import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sahypam/authentification/Login.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {

  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailCotnroller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstname  = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool showSpinner = false;
  String name = "";
  String email = "";
  String password = "";

  @override
  void dispose() {
    // TODO: implement dispose
    firstname.dispose();
    super.dispose();
  }

  Future adduserdetails(String uid,String firstname) async{
    await FirebaseFirestore.instance.collection("users").doc(uid).set({
      'first name': firstname,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return  ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        backgroundColor: Colors.black, // Fon hökman gara bolmaly
        appBar: AppBar(
          title: Text(""),
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(color: Colors.white), // Yza dolanyş düwmesiniň reňki
        ),
        body: SafeArea(
            child: SingleChildScrollView( // <--- Решает проблему overflow
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  Image.asset('assets/login.gif',height: 150,width: 150,),
                  const SizedBox(height: 15,),
                  Center(
                    child: Text("Регистрация",style: TextStyle(fontSize: 30),),
                  ),
                  const SizedBox(height: 60,),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [

                        // username
                        TextFormField(
                          controller: firstname,
                          decoration: InputDecoration(
                              hintText: "Имя",
                              labelText: "Имя",
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18)
                              )
                          ),
                          onChanged: (String value){
                            name = value;
                          },
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Enter Password';
                            }
                            return null;
                          },
                        ),

                        //email
                        TextFormField(
                          controller: emailCotnroller,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: "Email",
                              labelText: "Email",
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18)
                              )
                          ),
                          onChanged: (String value){
                            email = value;
                          },
                          validator: (value){
                            return value!.isEmpty ? 'Enter email' : null;
                          },
                        ),

                        const SizedBox(height: 20,),

                        //password
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: "Password",
                              labelText: "Password",
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18)
                              )
                          ),
                          onChanged: (String value){
                              password = value;
                          },
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Enter Password';
                            }
                            if(value.length < 5){
                              return "Must be more 5";
                            }
                            return null;
                          },

                        )
                      ],
                    )
                  ),
                  const SizedBox(height: 20,),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () async{
                        if(_formKey.currentState!.validate()){
                          setState(() {
                            showSpinner = true;
                          });
                          try{
                            final userCredential = await _auth.createUserWithEmailAndPassword(
                                email: email.toString(),
                                password: password.toString().trim());
                            await userCredential.user!.updateDisplayName(name);

                            await adduserdetails(userCredential.user!.uid,firstname.text.trim());


                            if(userCredential.user != null){
                              await userCredential.user!.sendEmailVerification();
                              await _auth.signOut();
                              toastMessage("Писмо с потдверждение отправлено на вашу почту");
                              setState(() {
                                showSpinner = false;
                              });
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
                            }
                          }on FirebaseAuthException catch(e){
                            setState(() {
                              showSpinner = false;
                            });
                            if(e.code == 'email-already-in-bound'){
                              toastMessage("Этот email уже используется");
                            }else{
                              toastMessage(e.message ?? "Произошла ошибка");
                            }
                          }
                          catch(e){
                            print(e.toString());
                            setState(() {
                              showSpinner = false;
                            });
                            toastMessage("Что то пошло не так");
                          }
                        }
                      },
                      child: Text("Регистрация"),
                    ),
                  )
                ],
              ),
            )
        ),
      ),
    );
  }
  void toastMessage(String message){
    Fluttertoast.showToast(
        msg: message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
