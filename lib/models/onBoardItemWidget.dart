import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sahypam/models/onboard_item.dart';


class Onboarditemwidget extends StatelessWidget {
  const Onboarditemwidget({super.key,required this.item});

  final OnboardItem item;


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      children: [
        Lottie.network(item.lottieUrl,height: 200),
        const SizedBox(height: 20,),
        Text(item.title,style: TextStyle(fontSize: 25),),
        const SizedBox(height: 20,),
        Text(item.subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15,color: Colors.blueGrey),),
      ],
    );
  }
}
