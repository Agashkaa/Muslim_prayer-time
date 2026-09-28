import 'dart:ui';
import 'package:flutter/material.dart';


class Frostedglass extends StatelessWidget {
  const Frostedglass({super.key, this.theWidth, this.theHeight, this.theChild, this.theColors});
  final theWidth;
  final theHeight;
  final theChild;
  final theColors;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(20),
      child: Container(
        width: theWidth,
        height: theHeight,
        color: Colors.transparent,
        child: Stack(
          children: [
            BackdropFilter(filter: ImageFilter.blur(sigmaX: 4.0,sigmaY: 4.0),child: Container(),),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(blurRadius: 15.0,spreadRadius: 5.0,offset: Offset(5.0, 5.0))
                ],
                borderRadius: BorderRadiusGeometry.circular(20),
                border: Border.all(color: Colors.black12),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.15),
                    Colors.white.withOpacity(0.05),
                  ]
                )
              ),
            ),
            Center(child: theChild,)
          ],
        ),
      ),
    );
  }
}
