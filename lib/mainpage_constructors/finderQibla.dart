import 'package:flutter/material.dart';
import 'package:location/location.dart';

class QiblaFinder extends StatelessWidget {
  const QiblaFinder({super.key});

  @override
  Widget build(BuildContext context) {
    Location location = Location();

    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Center(
        child: ElevatedButton(
            onPressed: ()async{




            },
            child: Text("dat")
        ),
      ),
      
    );
  }
}
