import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glass_bottom_navigation/glass_bottom_navigation.dart';
import 'package:intl/intl.dart';
import 'package:sahypam/Helper/Frostedglass.dart';
import 'package:sahypam/charts/fl_chart.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Profile1(),
    );
  }
}

class Profile1 extends StatefulWidget {
  const Profile1({super.key});

  @override
  State<Profile1> createState() => _Profile1State();
}

class _Profile1State extends State<Profile1> {
TextEditingController pageController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;

  var now = DateTime.now();
  var formatter = DateFormat('dd-MM-yyyy');
  late String formattedTime = formatter.format(now);
  String mypage = "";


  void _showDialog(){
    showDialog(context: context, builder: (context){
      return AlertDialog(
          title: Align(
            alignment: .center,
            child: Text("Sahypa"),
          ),

          actions: [
            TextFormField(
              controller: pageController,
              decoration: InputDecoration(
                  hintText: "Sahypa",
                  labelText: "Okalan Sahypa",
                  prefixIcon: Icon(Icons.book,color: Colors.red,),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18)
                  )
              ),
              onChanged: (String value){
               // mypage = value;
              },
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Enter Password';
                }
                return null;
              },
            ),
            const SizedBox(height: 20,),
            Align(
              alignment: .center,
              child: FilledButton(
                onPressed:  ()async{

                },
                child: Text("Send"),
              ),
            )
          ],
          content: Text(formattedTime,textAlign: .center,),
      );
    });
  }

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
  backgroundColor: CupertinoColors.systemBackground,

    child: Stack(

      children: [
        NestedScrollView(
          physics: const ClampingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            CupertinoSliverNavigationBar(
              backgroundColor: Colors.black,
              largeTitle: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text("${user.displayName}", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              trailing: CupertinoButton(
                child: Icon(Icons.settings),
                onPressed: _showDialog,
              ),
            )
          ],
          body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .snapshots(),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                return Text('Error = ${snapshot.error}', style: TextStyle(color: Colors.black));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || !snapshot.data!.exists) {
                return const Center(child: Text('Maglumat tapylmady', style: TextStyle(color: Colors.white)));
              }

              final data = snapshot.data!.data()!;
              final int pages = data['page'] ?? 0;
              final Timestamp? createdAt = data['createdAt'] as Timestamp?;
              final String createdAtText = createdAt != null
                  ? DateFormat('dd.MM.yyyy HH:mm').format(createdAt.toDate())
                  : 'Error';

              // Aşakdaky düwme ekranyň iň aşagynda fiksirlenip durmagy üçin SingleChildScrollView ulandyk
              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 100), // Düwmäniň üstüne basmazlygy üçin aşakdan boşluk
                child: ListTile(
                  title: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text("${user.uid}", style: TextStyle(color: Colors.white, fontSize: 12)),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Frostedglass(
                            theHeight: 90.0,
                            theWidth: 165.0,
                            theChild: Column(
                              children: [
                                Container(
                                    alignment: Alignment.topLeft,
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(children: [
                                      Text("Progres", style: TextStyle(fontWeight: FontWeight.bold)),
                                    ])),
                                Center(child: Text("120", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
                              ],
                            ),
                          ),
                          Frostedglass(
                            theHeight: 90.0,
                            theWidth: 165.0,
                            theChild: Container(
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.all(9.0),
                                child: Text("Streak")),
                          ),
                        ],
                      ),
                      Text('$pages', style: TextStyle(color: Colors.white, fontSize: 30)),
                      Text(createdAtText, style: TextStyle(color: Colors.white)),
                      LineChartSample2(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );

}